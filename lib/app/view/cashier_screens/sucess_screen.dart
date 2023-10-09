import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/cashier_main_screen.dart';
import 'package:mokpos/app/view_model/auth/shop/shop_view_model.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import '../nfc_scan_screen.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String description;

  const SuccessScreen({
    super.key,
    this.title = "Successful Registered",
    this.description = "NOTE: Do not forget to smile for customers.",
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<CustomerViewModel, ShopViewModel>(
        builder: (context, customerViewModel, shopViewModel, _) {
      return Scaffold(
        backgroundColor: Colors.green,
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
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              MyTextButton(
                margin: EdgeInsets.symmetric(horizontal: 20),
                label:
                    "Balance : \$${customerViewModel.customerData?.walletBalance!.roundToDouble()}",
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
            customerViewModel.resetcustomerData();
            shopViewModel.clearCart();

            Constant.navigatePushReplacement(
              context,
              WillPopScope(
                onWillPop: () async => false,
                child: CashierMainScreen(),
              ),
            );
          },
          margin: EdgeInsets.symmetric(horizontal: 20),
          label: "DONE",
        ),
      );
    });
  }
}
