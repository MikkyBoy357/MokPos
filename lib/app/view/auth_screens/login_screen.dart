import 'package:flutter/material.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/my_colors.dart';
import '../../../widgets/back_button_black.dart';
import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          "Login",
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
                EmailTextField(
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
                SizedBox(height: 20),
                Text(
                  "Send OTP:",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40),
                Spacer(),
                CustomButton(label: "Login"),
                SizedBox(height: 10),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
