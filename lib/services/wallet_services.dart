import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/model/employee_model.dart';
import 'package:provider/provider.dart';

import '../app/view_model/user/user_view_model.dart';
import '../util/firebase/firebase.dart';

class WalletService {
  Future<void> debitOwner(
    BuildContext context, {
    required String ownerId,
    required double debitAmount,
  }) async {
    print("=======> Error Debit Owner <=======");
    print("===> DebitAmount: $debitAmount");

    try {
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);

      await userViewModel.getUser(isForced: true);

      DocumentReference docRef = await usersRef.doc(ownerId);

      print("CurrentOwner => ${userViewModel.user!.walletBalance}");
      print("CurrentOwner => ${userViewModel.user!.walletBalance}");
      num newBalance = userViewModel.user!.walletBalance! - debitAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Debit Owner <=======");
      print(e);
    }
  }

  Future<void> creditOwner(
    BuildContext context, {
    required String ownerId,
    required double creditAmount,
  }) async {
    print("=======> Error Credit Owner <=======");
    print("===> CreditAmount: $creditAmount");

    try {
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);

      await userViewModel.getUser(isForced: true);

      DocumentReference docRef = await usersRef.doc(ownerId);

      print("CurrentOwner => ${userViewModel.user!.walletBalance}");
      print("CurrentOwner => ${userViewModel.user!.walletBalance}");
      num newBalance = userViewModel.user!.walletBalance! + creditAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Credit Owner <=======");
      print(e);
    }
  }

  Future<void> creditEmployee(
    BuildContext context, {
    required String employeeCode,
    required double creditAmount,
  }) async {
    print("=======> Error Credit Employee <=======");
    print("===> CreditAmount: $creditAmount");

    try {
      UserViewModel userViewModel =
          Provider.of<UserViewModel>(context, listen: false);

      await userViewModel.getEmployeeList(forced: true);

      DocumentReference docRef = employeesRef.doc(employeeCode);

      EmployeeModel currentEmployee = userViewModel.employeeList
          .firstWhere((element) => element.employeeCode == employeeCode);

      print("CurrentEmployee => ${currentEmployee.walletBalance}");
      num newBalance = currentEmployee.walletBalance! + creditAmount;

      await docRef.update({
        "walletBalance": newBalance,
      });
    } catch (e) {
      print("=======> Error on Credit Employee <=======");
      print(e);
    }
  }
}
