import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view_model/shop/shop_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import 'payment_method_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopViewModel>(
      builder: (context, shopViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Details commande"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: shopViewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    var orderItem = shopViewModel.cartItems[index];
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                BlackIconButton(
                                  child: Center(
                                    child: Text(
                                      "${orderItem.count}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text("${orderItem.name}"),
                              ],
                            ),
                            Text("CFA ${orderItem.price! * orderItem.count!}")
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 0.3),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[400]!,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:"),
                      Text("CFA ${shopViewModel.totalPrice}"),
                    ],
                  ),
                  SizedBox(height: 10),
                  MyTextButton(
                    // margin: EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: Colors.green,
                    label: "PAYER",
                    onTap: () {
                      Constant.navigatePush(context, PaymentMethodScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
