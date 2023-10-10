// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/model/customer_model.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/cashier_screens/sucess_screen.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/util/extensions/extensions.dart';
import 'package:mokpos/util/firebase/firebase.dart';
import 'package:mokpos/widgets/error_dialog.dart';
import 'package:mokpos/widgets/loading_dialog.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../nfc_model/record.dart';
import '../../../nfc_model/write_record.dart';

class CustomerViewModel extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String email = "", name = "";

  NfcTag? tag;
  Object? tech;

  List<NdefRecordInfo> myRecords = [];

  CustomerModel? customerData;
  String? customerId;

  double topupAmt = 0;
  double minTopup = 200;

  List<CustomerModel> customersList = [];

  String tempCustomerId = "";
  Iterable<WriteRecord> myRecordsIterable = [];

  bool isLoading = false;

  Future<void> checkTagForId(BuildContext context, NfcTag? _tag,
      {required String actionType}) async {
    tag = _tag;
    if (tag == null) {
      print("======>WAHALA (Tag is NULL)<======");
      return;
    } else {
      tech = Ndef.from(tag!);

      if (tech is Ndef) {
        final myTech = (tech as Ndef);
        final cachedMessage = myTech.cachedMessage;
        final canMakeReadOnly =
            myTech.additionalData['canMakeReadOnly'] as bool?;

        customerId = null;
        myRecords.clear();
        // myRecords = cachedMessage!.records;
        for (NdefRecord record in cachedMessage!.records) {
          final info = NdefRecordInfo.fromNdef(record);
          myRecords.add(info);
          print("===Rikky==> ${info.title}");
          print("===Rikky Sub==> ${info.subtitle}\n\n");
        }

        // assuming the first record is the userId
        String firstRecordContent = myRecords.first.subtitle;
        List<String> splitList = firstRecordContent.split(" ");
        if (splitList.isNotEmpty) {
          customerId = splitList.last;
          print("======ID Found=====> ${customerId}");
          // await Future.delayed(Duration(seconds: 5));
          print("======ActionType=====> $actionType");
          if (actionType == "payment") {
            await checkCustomerExist(context);
          } else if (actionType == "topup") {
            await checkCustomerExist(context);
          }
        } else {
          print("======ID NOT Found in First content=====> ${customerId}");
        }
      }
      notifyListeners();
    }
  }

  Future<void> handleWriteTag(BuildContext context, NfcTag? _tag,
      {required String actionType}) async {}

  Future<void> getCustomers() async {
    print("====> Get Customers");
    QuerySnapshot snapshot = await customersRef.get();
    List<DocumentSnapshot> docs = snapshot.docs;

    print(docs[0].data());
    customersList.clear();
    for (var doc in docs) {
      final tempCus =
          CustomerModel.fromJson(doc.data() as Map<String, dynamic>);
      customersList.add(tempCus);
    }

    // print(tempcus);
  }

  void startLoading(BuildContext context) {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading(BuildContext context) {
    isLoading = false;
    notifyListeners();
  }

  Future<bool> checkCustomerExist(BuildContext context) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    DocumentSnapshot snapshot = await customersRef.doc(customerId!).get();

    if (snapshot.exists) {
      var tempUser = snapshot.data() as Map<String, dynamic>;
      print("TempUser => $tempUser");

      customerData = CustomerModel.fromJson(tempUser);
    } else {
      print("User doesn't exist");
    }

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();
    return snapshot.exists;
  }

  Future<void> makePayment(
    BuildContext context, {
    required double amount,
  }) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    if (await checkCustomerExist(context)) {
      // Check for sufficient funds
      if (customerData!.walletBalance! < amount) {
        Navigator.of(context).pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(
              title: "Insufficient Funds",
              text: "Veuillez recharger votre compte",
            );
          },
        );
        resetcustomerData();
        return;
      }
    }

    // Proceed to debit customer account
    await debitCustomer(debitAmount: amount, customer: customerData!);
    await creditCashier(context, creditAmount: amount, customer: customerData!);

    // Get customer data again to get updated wallet balance
    await checkCustomerExist(context);

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    Constant.navigatePush(
      context,
      WillPopScope(
        onWillPop: () async => false,
        child: SuccessScreen(
          title: "Transaction Success",
          description: "NOTE: Do not forget to smile for customers.",
        ),
      ),
    );
    // resetcustomerData();
  }

  Future<void> topupCustomerAccount(BuildContext context) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    // Proceed to credit customer account and debit cashier
    await creditCustomer(creditAmount: topupAmt, customer: customerData!);
    await debitCashier(context, debitAmount: topupAmt, customer: customerData!);

    // Get customer data again to get updated wallet balance
    await checkCustomerExist(context);

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    Constant.navigatePush(
      context,
      WillPopScope(
        onWillPop: () async => false,
        child: SuccessScreen(
          title: "Transaction Success",
          description: "NOTE: Do not forget to smile for customers.",
        ),
      ),
    );
    resetcustomerData();
  }

  Future<void> creditCustomer({
    required num creditAmount,
    required CustomerModel customer,
  }) async {
    try {
      DocumentReference docRef = await customersRef.doc(customer.id);

      num newBalance = customer.walletBalance! + creditAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Credit Customer <=======");
      print(e);
    }
  }

  Future<void> debitCustomer({
    required num debitAmount,
    required CustomerModel customer,
  }) async {
    try {
      DocumentReference docRef = await customersRef.doc(customer.id);

      num newBalance = customer.walletBalance! - debitAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Debit Customer <=======");
      print(e);
    }
  }

  Future<void> debitCashier(
    BuildContext context, {
    required num debitAmount,
    required CustomerModel customer,
  }) async {
    try {
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);

      await userViewModel.getUser();

      User? currentUser = FirebaseAuth.instance.currentUser;
      DocumentReference docRef = await usersRef.doc(currentUser!.uid);

      print("MyUser => ${userViewModel.user!.walletBalance}");
      num newBalance = userViewModel.user!.walletBalance! - debitAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Debit Cashier <=======");
      print(e);
    }
  }

  Future<void> creditCashier(
    BuildContext context, {
    required num creditAmount,
    required CustomerModel customer,
  }) async {
    try {
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);

      await userViewModel.getUser();

      User? currentUser = FirebaseAuth.instance.currentUser;
      DocumentReference docRef = await usersRef.doc(currentUser!.uid);

      print("MyUser => ${userViewModel.user!.walletBalance}");
      num newBalance = userViewModel.user!.walletBalance! + creditAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Credit Cashier <=======");
      print(e);
    }
  }

  void resetcustomerData() {
    customerData = null;
    notifyListeners();
  }

  void setTopupAmt(String? val) {
    if (val != null && val.isNotEmpty) {
      topupAmt = double.parse(val);
    } else {
      topupAmt = 0.0;
    }

    notifyListeners();
  }

  void setName(val) {
    name = val;
    notifyListeners();
  }

  void setEmail(val) {
    email = val;
    notifyListeners();
  }

  Future<void> startRegisterCustomer() async {
    tempCustomerId = Uuid().v4();
    print("NewID => $tempCustomerId");

    myRecordsIterable = [
      WriteRecord(
        id: 0,
        record: NdefRecord.createText(tempCustomerId),
      ),
    ];

    notifyListeners();
  }

  Future<void> addNewCustomer(BuildContext context) async {
    loading = true;
    notifyListeners();

    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    try {
      CustomerModel tempCustomer = CustomerModel(
        id: tempCustomerId,
        email: email,
        name: name,
        walletBalance: 0.0,
      );

      await customersRef.doc(tempCustomerId).set(tempCustomer.toJson());
    } catch (e) {
      print(e);
      print("Error adding new customer");
      showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            title: "Error adding new customer",
            text: e.toString(),
          );
        },
      );
    }

    tempCustomerId = "CustomerIdPlaceHolder";
    Navigator.of(context).pop(context);
    loading = false;

    Constant.navigatePushReplacement(
      context,
      WillPopScope(onWillPop: () async => false, child: CashierMainScreen()),
    );
    resetcustomerData();
  }
}

class NdefRecordInfo {
  const NdefRecordInfo(
      {required this.record, required this.title, required this.subtitle});

  final Record record;

  final String title;

  final String subtitle;

  static NdefRecordInfo fromNdef(NdefRecord record) {
    final _record = Record.fromNdef(record);
    if (_record is WellknownTextRecord)
      return NdefRecordInfo(
        record: _record,
        title: 'Wellknown Text',
        subtitle: '(${_record.languageCode}) ${_record.text}',
      );
    if (_record is WellknownUriRecord)
      return NdefRecordInfo(
        record: _record,
        title: 'Wellknown Uri',
        subtitle: '${_record.uri}',
      );
    if (_record is MimeRecord)
      return NdefRecordInfo(
        record: _record,
        title: 'Mime',
        subtitle: '(${_record.type}) ${_record.dataString}',
      );
    if (_record is AbsoluteUriRecord)
      return NdefRecordInfo(
        record: _record,
        title: 'Absolute Uri',
        subtitle: '(${_record.uriType}) ${_record.payloadString}',
      );
    if (_record is ExternalRecord)
      return NdefRecordInfo(
        record: _record,
        title: 'External',
        subtitle: '(${_record.domainType}) ${_record.dataString}',
      );
    if (_record is UnsupportedRecord) {
      // more custom info from NdefRecord.
      if (record.typeNameFormat == NdefTypeNameFormat.empty)
        return NdefRecordInfo(
          record: _record,
          title: _typeNameFormatToString(_record.record.typeNameFormat),
          subtitle: '-',
        );
      return NdefRecordInfo(
        record: _record,
        title: _typeNameFormatToString(_record.record.typeNameFormat),
        subtitle:
            '(${_record.record.type.toHexString()}) ${_record.record.payload.toHexString()}',
      );
    }
    throw UnimplementedError();
  }
}

String _typeNameFormatToString(NdefTypeNameFormat format) {
  switch (format) {
    case NdefTypeNameFormat.empty:
      return 'Empty';
    case NdefTypeNameFormat.nfcWellknown:
      return 'NFC Wellknown';
    case NdefTypeNameFormat.media:
      return 'Media';
    case NdefTypeNameFormat.absoluteUri:
      return 'Absolute Uri';
    case NdefTypeNameFormat.nfcExternal:
      return 'NFC External';
    case NdefTypeNameFormat.unknown:
      return 'Unknown';
    case NdefTypeNameFormat.unchanged:
      return 'Unchanged';
  }
}
