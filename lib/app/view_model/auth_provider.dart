import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // Login
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // SignUp
  TextEditingController emailController2 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController phoneNumberController2 = TextEditingController();

  void changeNotifiers() async {
    notifyListeners();
  }
}
