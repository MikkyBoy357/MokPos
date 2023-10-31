import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/components/shop_list_card.dart';
import 'package:mokpos/app/view_model/budget_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:provider/provider.dart';

import '../view_model/shop/shop_view_model.dart';
import 'cashier_screens/components/shop_grid_card.dart';

class AddBudgetItemScreen extends StatefulWidget {
  const AddBudgetItemScreen({super.key});

  @override
  State<AddBudgetItemScreen> createState() => _AddBudgetItemScreenState();
}

class _AddBudgetItemScreenState extends State<AddBudgetItemScreen> {
  bool isGrid = false;

  void changeGrid() {
    isGrid = !isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ShopViewModel, BudgetViewModel>(
      builder: (context, shopViewModel, budgetViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add product to budget"),
          ),
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
                Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        FutureBuilder(
                          future: shopViewModel.getProducts(),
                          builder: (context, AsyncSnapshot snap) {
                            if (isGrid) {
                              return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: shopViewModel.productsList.length,
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
                                    onAdd: () {
                                      shopViewModel.addItemToCart(item);
                                      budgetViewModel.addItemToCart(item);
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
                                itemCount: shopViewModel.productsList.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final item =
                                      shopViewModel.productsList[index];

                                  return ShopListCard(
                                    onAdd: () {
                                      shopViewModel.addItemToCart(item);
                                      budgetViewModel.addItemToCart(item);
                                    },
                                    shopItem: shopViewModel.productsList[index],
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
                // Constant.navigatePush(context, OrderDetailScreen());
                budgetViewModel.generateBudgetItems(shopViewModel.cartItems);
                Constant.backToPrev(context);
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
                        "Total: CFA ${shopViewModel.totalPrice}",
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
