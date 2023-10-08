import 'package:flutter/material.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';

import '../nfc_scan_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Color(0xFF2171C6).withOpacity(0.05),
                child: CircleAvatar(
                  foregroundColor: Colors.green,
                  radius: 60,
                  child: Icon(
                    Icons.check,
                    size: 100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Successful Registered",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "NOTE: Do not forget to give smile to customers.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            MyTextButton(
              margin: EdgeInsets.symmetric(horizontal: 20),
              label: "Balance : 0 FCFA",
              backgroundColor: Colors.white,
              textColor: Colors.black,
            ),
            // Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyTextButton(
        onTap: () {
          Constant.navigatePush(context, NfcScanScreen());
        },
        margin: EdgeInsets.symmetric(horizontal: 20),
        label: "NEXT ORDER",
      ),
    );
  }
}
