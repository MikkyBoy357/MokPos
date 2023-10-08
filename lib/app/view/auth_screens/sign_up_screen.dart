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
import '../../view_model/auth/sign_up/register_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, registerViewModel, _) {
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  buildForm(registerViewModel, context),
                  SizedBox(height: 40),
                  CustomButton(
                    label: "Sign up",
                    onTap: () => registerViewModel.register(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          EmailTextField(
            controller: emailController,
            onChanged: (String val) {
              viewModel.setEmail(val);
            },
          ),
          SizedBox(height: 20),
          PhoneTextField(
            controller: phoneController,
            onChanged: (String val) {
              viewModel.setPhone(val);
            },
          ),
          SizedBox(height: 20),
          PasswordField(
            controller: passController,
            title: "Password",
            hintText: "at least 8 characters",
            onChanged: (String val) {
              viewModel.setPassword(val);
              viewModel.setConfirmPass(val);
            },
          ),
        ],
      ),
    );
  }
}
