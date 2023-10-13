import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mokpos/app/view/auth_screens/choose_login.dart';
import 'package:mokpos/app/view/auth_screens/login_as_owner_screen.dart';
import 'package:mokpos/app/view/auth_screens/sign_up_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: BackButton(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlackIconButton(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset("${Constant.assetSvgPath}union.svg"),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "POS.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              height: size.height / 3,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Image.asset("${Constant.assetImagePath}desktop.png"),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Easy Payment for your store.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            // Spacer(),
            CustomButton(
              label: "Create new account",
              onTap: () {
                Constant.navigatePush(context, SignUpScreen());
              },
            ),
            SizedBox(height: 15),
            CustomOutlineButton(
              label: "Login",
              onTap: () {
                Constant.navigatePush(context, ChooseLoginScreen());
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
