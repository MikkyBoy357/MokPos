import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/app/view_model/auth/login/login_view_model.dart';
import 'package:mokpos/app/view_model/auth_provider.dart';
import 'package:mokpos/widgets/name_text_field.dart';
import 'package:mokpos/widgets/number_text_field.dart';
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

  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
      body: Consumer<LoginViewModel>(
        builder: (context, loginProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  buildForm(loginProvider, context),
                  SizedBox(height: 40),
                  // Spacer(),
                  CustomButton(
                    label: "Login",
                    onTap: () {
                      loginProvider.loginAsCashier(context);
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
          NumberTextField(
            title: "Employee Code",
            hintText: "0000",
            controller: codeController,
            onChanged: (String val) {
              viewModel.setCode(val);
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
