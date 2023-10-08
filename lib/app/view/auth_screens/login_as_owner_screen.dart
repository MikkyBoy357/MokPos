import 'package:flutter/material.dart';
import 'package:mokpos/app/view/main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/app/view/owner_screens/dashboard_screen.dart';
import 'package:mokpos/app/view_model/auth/login/login_view_model.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../base/my_colors.dart';
import '../../../widgets/back_button_black.dart';
import '../../../widgets/email_text_field.dart';
import '../../../widgets/password_field.dart';

class LoginAsOwnerScreen extends StatefulWidget {
  const LoginAsOwnerScreen({super.key});

  @override
  State<LoginAsOwnerScreen> createState() => _LoginAsOwnerScreenState();
}

class _LoginAsOwnerScreenState extends State<LoginAsOwnerScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
          "Login",
          style: TextStyle(
            color: MyColors().myGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, loginProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  buildForm(loginProvider, context),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Send OTP:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomSmallButton(
                    isSelected: otpMethod == "Email",
                    label: "Email",
                    icon: Icons.mail_outlined,
                    onTap: () => changeOtpMethod("Email"),
                  ),
                  SizedBox(height: 10),
                  CustomSmallButton(
                    isSelected: otpMethod == "SMS",
                    label: "SMS",
                    icon: Icons.message,
                    onTap: () => changeOtpMethod("SMS"),
                  ),
                  SizedBox(height: 40),
                  // Spacer(),
                  CustomButton(
                    label: "Login",
                    onTap: () {
                      loginProvider.login(context, "Owner");
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildForm(LoginViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          EmailTextField(
            controller: emailController,
            onChanged: (String val) {
              print(val);
              viewModel.setEmail(val);
            },
          ),
          SizedBox(height: 20),
          PasswordField(
            controller: passController,
            title: "Password",
            hintText: "At least 8 characters",
            onChanged: (String val) {
              viewModel.setPassword(val);
            },
          ),
        ],
      ),
    );
  }
}
