// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/onboarding_screen.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../base/constant.dart';
import '../../../../base/validation.dart';
import '../../../../services/auth_service.dart';
import '../../../../widgets/loading_dialog.dart';
import '../../../model/employee_model.dart';
import '../../../view/main_screen.dart';
import '../../../view/topup_screens/topup_main_screen.dart';
import '../../employee/employee_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String email = "", password = "", code = "";
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  AuthService auth = AuthService();

  void startLoading(BuildContext context) {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading(BuildContext context) {
    isLoading = false;
    notifyListeners();
  }

  login(BuildContext context, String userType) async {
    FormState form = formKey.currentState!;
    // form.save();
    // if (!form.validate()) {
    //   validate = true;
    //   notifyListeners();
    //   showInSnackBar(
    //       'Please fix the errors in red before submitting.', context);
    // } else {
    loading = true;
    notifyListeners();
    print("Try Login");
    print(email);
    print(password);
    try {
      bool success = await auth.loginUser(
        email: email,
        password: password,
      );
      print("Login Success");
      print(success);
      if (success) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) =>
                userType == "Cashier" ? CashierMainScreen() : MainScreen(),
          ),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("Login Error");
      print("Email: $email");
      print("Pass: $password");
      print(e);
      showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}', context);
    }
    loading = false;
    notifyListeners();

    Provider.of<UserViewModel>(context, listen: false).getUser();
    // }
  }

  loginAsCashier(BuildContext context) async {
    FormState form = formKey.currentState!;
    loading = true;
    notifyListeners();
    print("Try Login as Employee");
    print(email);
    print(password);
    try {
      bool success = await auth.loginEmloyee(context,
          employeeCode: code, password: password);

      print("Login Employee Pass");
      print(success);

      final EmployeeModel? loggedInEmployee =
          Provider.of<EmployeeViewModel>(context, listen: false)
              .loggedInEmployee;
      if (success) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: loggedInEmployee?.employeeType.toString() == "cashier"
                  ? CashierMainScreen()
                  : TopupMainScreen(),
            ),
          ),
        );
      } else {
        print("invalid code or password");
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("Login Error");
      print("Email: $email");
      print("Pass: $password");
      print(e);
      showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}', context);
    }
    loading = false;
    notifyListeners();

    Provider.of<UserViewModel>(context, listen: false).getUser();
    // }
  }

  Future<void> logout(BuildContext context) async {
    startLoading(context);
    showDialog(
      context: context,
      builder: (context) {
        return LoadingDialog();
      },
    );

    await AuthService().logOut(context);

    stopLoading(context);
    Navigator.of(context).pop(context);
    notifyListeners();

    Constant.navigatePush(
      context,
      WillPopScope(
        onWillPop: () async => false,
        child: OnboardingScreen(),
      ),
    );
  }

  forgotPassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    FormState form = formKey.currentState!;
    form.save();
    print(Validations.validateEmail(email));
    if (Validations.validateEmail(email) != null) {
      showInSnackBar(
          'Please input a valid email to reset your password.', context);
    } else {
      try {
        await auth.forgotPassword(email);
        showInSnackBar(
            'Please check your email for instructions '
            'to reset your password',
            context);
      } catch (e) {
        showInSnackBar('${e.toString()}', context);
      }
    }
    loading = false;
    notifyListeners();
  }

  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }

  setCode(val) {
    code = val;
    notifyListeners();
  }

  void showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
