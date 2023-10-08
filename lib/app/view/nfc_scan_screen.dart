import 'package:flutter/material.dart';
import 'package:mokpos/app/view_model/auth/shop/shop_view_model.dart';
import 'package:provider/provider.dart';

import '../../base/constant.dart';
import '../../widgets/back_button_black.dart';
import '../view_model/customer/customer_view_model.dart';

class NfcScanScreen extends StatelessWidget {
  const NfcScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ShopViewModel, CustomerViewModel>(
      builder: (context, shopViewModel, customerViewModel, _) {
        return Scaffold(
          // backgroundColor: Colors.green,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacer(),
                SizedBox(height: 150),
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
                  "Payer",
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${shopViewModel.totalPrice}",
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
                    // fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                MyTextButton(
                  onTap: () async {
                    await customerViewModel.makePayment(
                      context,
                      amount: shopViewModel.totalPrice,
                    );
                  },
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  label: "Simulate Card Scan",
                )
                // Spacer(),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            onTap: () {
              // Constant.navigatePush(context, NfcScanScreen());
            },
            margin: EdgeInsets.symmetric(horizontal: 20),
            label: "BACK",
          ),
        );
      },
    );
  }
}
