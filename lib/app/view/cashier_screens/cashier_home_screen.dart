import 'package:flutter/material.dart';
import 'package:mokpos/app/model/shop_item_model.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/app/view/cashier_screens/customer_list_screen.dart';
import 'package:mokpos/app/view/cashier_screens/register_client_nfc_screen.dart';
import 'package:mokpos/app/view_model/auth/shop/shop_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import '../../../widgets/my_drawer.dart';
import '../owner_screens/history_modal_sheet.dart';
import 'components/shop_grid_card.dart';
import 'components/shop_list_card.dart';
import 'order_detail_screen.dart';
import 'sucess_screen.dart';

class CashierHomeScreen extends StatefulWidget {
  const CashierHomeScreen({super.key});

  @override
  State<CashierHomeScreen> createState() => _CashierHomeScreenState();
}

class _CashierHomeScreenState extends State<CashierHomeScreen> {
  bool isGrid = false;

  void changeGrid() {
    isGrid = !isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopViewModel>(
      builder: (context, shopViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Cashier"),
            actions: [
              MyTextButton(
                margin: EdgeInsets.symmetric(horizontal: 10),
                onTap: () {
                  Constant.navigatePush(context, AddCustomerScreen());
                },
                label: "Add Customer",
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Divider(thickness: 0.5),
                Container(
                  height: 45,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Product",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              changeGrid();
                            },
                            icon: Icon(Icons.grid_view),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 0.5),
                Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Builder(
                          builder: (context) {
                            if (isGrid) {
                              return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: shopItems.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.85,
                                ),
                                itemBuilder: (context, index) {
                                  final item = shopItems[index];

                                  return ShopGridCard(
                                    onAdd: () {
                                      shopViewModel.addItemToCart(item);
                                    },
                                    shopItem: item,
                                    onTap: () {},
                                  );
                                },
                              );
                            } else {
                              return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: shopItems.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final item = shopItems[index];

                                  return ShopListCard(
                                    onAdd: () {
                                      shopViewModel.addItemToCart(item);
                                    },
                                    shopItem: shopItems[index],
                                    onTap: () {},
                                  );
                                },
                              );
                            }
                          },
                        ),
                        //
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: InkWell(
            onTap: () {
              if (shopViewModel.cartItems.isNotEmpty) {
                Constant.navigatePush(context, OrderDetailScreen());
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${shopViewModel.cartItems.length} Items",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      Text(
                        "Total: \$${shopViewModel.totalPrice}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
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
