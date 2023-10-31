import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mokpos/app/view/auth_screens/login_as_employee_screen.dart';
import 'package:mokpos/app/view/auth_screens/login_as_owner_screen.dart';
import 'package:mokpos/app/view/auth_screens/sign_up_screen.dart';
import 'package:mokpos/app/view/onboarding_screens/custom_button.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';

import '../../../base/my_colors.dart';

class ChooseLoginScreen extends StatelessWidget {
  const ChooseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
          "Type de connexion",
          style: TextStyle(
            color: MyColors().myGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Cashless POS!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Select login as the owner or employee first to continue.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              height: size.height / 4,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Image.asset("${Constant.assetImagePath}welcome.png"),
              ),
            ),
            // Spacer(),
            CustomButton(
              label: "Connexion Admin",
              prefixWidget: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
                size: 30,
              ),
              onTap: () {
                Constant.navigatePush(context, LoginAsOwnerScreen());
              },
            ),
            SizedBox(height: 10),
            Text("or"),
            SizedBox(height: 10),
            CustomButton(
              label: "Connexion Agent",
              prefixWidget: SvgPicture.asset(
                "${Constant.assetSvgPath}employees.svg",
                height: 30,
                width: 30,
              ),
              onTap: () {
                Constant.navigatePush(context, LoginAsEmployeeScreen());
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
              ],
            ),
            SizedBox(height: 40),
            // Spacer()
          ],
        ),
      ),
    );
  }
}
