// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/model/employee_model.dart';
import 'package:mokpos/app/model/user_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/services/wallet_services.dart';
import 'package:mokpos/util/firebase/firebase.dart';
import 'package:mokpos/widgets/error_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/loading_dialog.dart';

class UserViewModel extends ChangeNotifier {
  bool isInitialized = false;
  bool gottenEmps = false;

  WalletService walletService = WalletService();

  // Dashboard Value
  num topupWalletsTotal = 0;
  num cashierWalletsTotal = 0;
  num customerWalletsTotal = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel? user;

  List<EmployeeModel> employeeList = [];

  EmployeeModel? topupEmployee;
  double topupAmt = 0;
  double minTopup = 200;

  bool isLoading = false;

  // Register Employee
  String name = '';
  String email = '';
  String phone = '';
  String pass = '';
  String newEmpType = 'cashier';

  void setEmpType(val) {
    newEmpType = val;
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

  void setPhone(val) {
    phone = val;
    notifyListeners();
  }

  void setPass(val) {
    pass = val;
    notifyListeners();
  }

  void changeNotifier() {
    notifyListeners();
  }

  // setUser() {
  //   user = auth.currentUser;
  //   notifyListeners();
  // }

  // Future<void> getUser() async {}
  Future<void> getUser({bool isForced = false}) async {
    if (!isInitialized || isForced) {
      DocumentSnapshot<Object?> doc =
          await usersRef.doc(auth.currentUser!.uid).get();

      if (doc.exists) {
        var tempUser = doc.data() as Map<String, dynamic>;
        print("TempUser => $tempUser");

        user = UserModel.fromJson(tempUser);
      } else {
        print("User doesn't exist");
      }
      isInitialized = true;
    }
  }

  Future<String> getNewEmployeeCode(BuildContext context) async {
    QuerySnapshot<Object?> snap =
        await employeesRef.where("ownerId", isEqualTo: user?.id).get();

    final int length = snap.docs.length + 1;

    return length.toString().padLeft(4, '0');
  }

  Future<void> registerNewEmployee(BuildContext context) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    final String empId = Uuid().v1();
    final empCode = await getNewEmployeeCode(context);
    // print("EmpCode => ${empCode}");

    final empJson = {
      "employeeType": newEmpType,
      "employeeCode": "${empCode}",
      "employeeId": "${empId}",
      "ownerId": "${user?.id}",
      "password": "${pass}",
      "walletBalance": 0,
      "name": "${name}",
      "email": "$email",
      "phone": "$phone"
    };

    await employeesRef.doc(empCode).set(empJson);

    print("EmpJson Created => ${getPrettyJSONString(empJson)}");

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    await showDialog(
      context: context,
      builder: (context) {
        return SuccessDialog(
          title: "Employee Created",
          text: getPrettyJSONString(empJson),
        );
      },
    );
    Constant.backToPrev(context);
    getEmployeeList(forced: true);
  }

  Future<void> makeTopupForEmployee(BuildContext context) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (dcontext) {
        return LoadingDialog();
      },
    );

    await walletService.debitOwner(context,
        ownerId: "${user?.id}", debitAmount: topupAmt);

    await walletService.creditEmployee(context,
        employeeCode: "${topupEmployee?.employeeCode}", creditAmount: topupAmt);

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    await showDialog(
      context: context,
      builder: (dcontext) {
        return SuccessDialog(
          title: "Topup Success",
          text: getPrettyJSONString(
              "You have sent ${topupAmt} to ${topupEmployee!.name}"),
        );
      },
    );
    // Constant.backToPrev(context);
    getEmployeeList(forced: true);
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<void> getEmployeeList({bool forced = false}) async {
    if (!gottenEmps || forced) {
      QuerySnapshot<Object?> snapshot =
          await employeesRef.where("ownerId", isEqualTo: user!.id).get();

      employeeList.clear();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          final tempEmployee = doc.data() as Map<String, dynamic>;
          print("TempEmployee => $tempEmployee");

          employeeList.add(EmployeeModel.fromJson(tempEmployee));
        }
      }
      gottenEmps = true;
    }
    // print("omoeux => ${getPrettyJSONString(employeeList[0])}");
    if (forced) {
      notifyListeners();
    }
  }

  void setTopupAmt(String? val) {
    if (val != null && val.isNotEmpty) {
      topupAmt = double.parse(val);
    } else {
      topupAmt = 0.0;
    }

    notifyListeners();
  }

  void startLoading(BuildContext context) {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading(BuildContext context) {
    isLoading = false;
    notifyListeners();
  }
}
