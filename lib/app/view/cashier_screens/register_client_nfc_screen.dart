import 'package:flutter/material.dart';
import 'package:mokpos/base/constant.dart';

import '../../../widgets/back_button_black.dart';

class RegisterClientNfcScreen extends StatelessWidget {
  const RegisterClientNfcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register client NFC Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFFFCE1F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFFFCE1F).withOpacity(0.4),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "NFC",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "This feature will allow you communicate with an NFC device and show the details of an item. To test it out you need a NFC",
                    style: TextStyle(
                      color: Color(0xFFD8A900),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black.withOpacity(0.05),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black.withOpacity(0.47),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    radius: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_tethering_sharp,
                          size: 50,
                        ),
                        Text(
                          "NFC",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Register for:",
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Michael Olusegun",
              style: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Press and get an NFC closer to your device",
              style: TextStyle(
                // color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyTextButton(
        backgroundColor: Colors.red,
        onTap: () {
          // Constant.navigatePush(context, NfcScanScreen());
          Constant.backToPrev(context);
        },
        margin: EdgeInsets.symmetric(horizontal: 20),
        label: "BACK",
      ),
    );
  }
}
