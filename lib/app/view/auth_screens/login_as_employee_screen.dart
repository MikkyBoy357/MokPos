import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:mokpos/widgets/name_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/my_colors.dart';
import '../../../widgets/back_button_black.dart';
import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_field.dart';

class LoginAsEmployeeScreen extends StatefulWidget {
  const LoginAsEmployeeScreen({super.key});

  @override
  State<LoginAsEmployeeScreen> createState() => _LoginAsEmployeeScreenState();
}

class _LoginAsEmployeeScreenState extends State<LoginAsEmployeeScreen> {
  String otpMethod = "Email";

  void changeOtpMethod(String val) {
    otpMethod = val;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyBackButton(
              onTap: () => Constant.backToPrev(context),
            ),
          ],
        ),
        title: Text(
          "Login as Employee",
          style: TextStyle(
            color: MyColors().myGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                NameTextField(
                  title: "Cashier Code",
                  hintText: "ABC23654",
                  controller: authProvider.emailController2,
                  onChanged: (String newVal) {
                    authProvider.changeNotifiers();
                  },
                ),
                SizedBox(height: 20),
                PasswordField(
                  controller: authProvider.passwordController2,
                  title: "Password",
                  hintText: "At least 8 characters",
                  onChanged: (String newVal) {
                    authProvider.changeNotifiers();
                  },
                ),
                SizedBox(height: 40),
                // Spacer(),
                CustomButton(
                  label: "Login",
                  onTap: () {
                    Constant.navigatePush(context, CashierMainScreen());
                  },
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0XFF1A72DD).withOpacity(0.1)),
                  child: Text(
                    "Use the cashier code that can be created by the Owner in Manage Store -> Cashier Code",
                  ),
                ),
                Spacer(),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
