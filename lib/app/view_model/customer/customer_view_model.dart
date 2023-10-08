// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/model/customer_model.dart';
import 'package:mokpos/app/view/cashier_screens/sucess_screen.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/util/firebase/firebase.dart';
import 'package:mokpos/widgets/error_dialog.dart';
import 'package:mokpos/widgets/loading_dialog.dart';

class CustomerViewModel extends ChangeNotifier {
  CustomerModel? customerData;
  String? customerId = "DPP6qnJi3Kg1mYx4j4Qi";

  bool isLoading = false;

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
        return;
      }
    }

    // Proceed to debit customer account
    debitCustomer(debitAmount: amount, customer: customerData!);

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    Constant.navigatePush(context, SuccessScreen());
  }

  Future<void> debitCustomer({
    required num debitAmount,
    required CustomerModel customer,
  }) async {
    DocumentReference docRef = await customersRef.doc(customer.id);

    num newBalance = customer.walletBalance! - debitAmount;

    await docRef.update({
      "walletBalance": newBalance,
    });
  }
}
