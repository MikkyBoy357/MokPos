import 'package:flutter/material.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/base/my_colors.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:mokpos/widgets/email_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/password_field.dart';
import '../../../widgets/phone_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
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
              "Sign Up",
              style: TextStyle(
                color: MyColors().myGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                PhoneTextField(
                  controller: authProvider.phoneNumberController2,
                  onChanged: (String newVal) {
                    authProvider.changeNotifiers();
                  },
                ),
                SizedBox(height: 20),
                PasswordField(
                  controller: authProvider.passwordController2,
                  title: "Password",
                  hintText: "at least 8 characters",
                  onChanged: (String newVal) {
                    authProvider.changeNotifiers();
                  },
                ),
                SizedBox(height: 40),
                CustomButton(label: "Sign up"),
              ],
            ),
          ),
        );
      },
    );
  }
}
