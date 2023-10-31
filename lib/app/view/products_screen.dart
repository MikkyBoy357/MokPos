import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/order_detail_screen.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import '../../base/constant.dart';
import '../../widgets/my_drawer.dart';
import '../model/shop_item_model.dart';
import '../view_model/shop/shop_view_model.dart';
import 'add_product_screen.dart';
import 'cashier_screens/components/shop_grid_card.dart';
import 'cashier_screens/components/shop_list_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
            title: Text("Point de vente"),
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
                        "Tous les produits",
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
                FutureBuilder(
                    future: shopViewModel.getProducts(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return Container(
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
                                      itemCount:
                                          shopViewModel.productsList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.85,
                                      ),
                                      itemBuilder: (context, index) {
                                        final item =
                                            shopViewModel.productsList[index];

                                        return ShopGridCard(
                                          showAdd: false,
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
                                      itemCount:
                                          shopViewModel.productsList.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10),
                                      itemBuilder: (context, index) {
                                        final item =
                                            shopViewModel.productsList[index];

                                        return ShopListCard(
                                          showAdd: false,
                                          onAdd: () {
                                            shopViewModel.addItemToCart(item);
                                          },
                                          shopItem:
                                              shopViewModel.productsList[index],
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
                      );
                    }),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            onTap: () {
              Constant.navigatePush(context, AddProductScreen());
            },
            label: "Ajouter un produit",
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          // floatingActionButton: InkWell(
          //   onTap: () {
          //     if (shopViewModel.cartItems.isNotEmpty) {
          //       Constant.navigatePush(context, OrderDetailScreen());
          //     }
          //   },
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 16),
          //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          //     decoration: BoxDecoration(
          //       color: Colors.green,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "${shopViewModel.cartItems.length} Items",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         // Spacer(),
          //         Row(
          //           children: [
          //             Text(
          //               "Total: CFA ${shopViewModel.totalPrice}",
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             Icon(
          //               Icons.chevron_right,
          //               color: Colors.white,
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
