import 'package:flutter/material.dart';
import 'package:mokpos/app/view/budget_model.dart';
import 'package:mokpos/app/view_model/budget_view_model.dart';
import 'package:provider/provider.dart';

import '../../base/constant.dart';
import '../../widgets/back_button_black.dart';
import 'add_budget_item_screen.dart';

class AddBudgetScreen extends StatelessWidget {
  const AddBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetViewModel>(
      builder: (context, budgetViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add budget"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  buildBudgetItems(context, budgetViewModel),
                  SizedBox(height: 50),
                  MyTextButton(
                    backgroundColor: Colors.green,
                    onTap: () {
                      Constant.navigatePush(context, AddBudgetItemScreen());
                    },
                    label: "Ajouter un produit",
                    margin: EdgeInsets.all(16),
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: MyTextButton(
            backgroundColor: Colors.green,
            onTap: () {
              budgetViewModel.saveBudget(context);
            },
            label: "ENREGISTRER",
            margin: EdgeInsets.all(16),
          ),
        );
      },
    );
  }

  Column buildBudgetItems(
      BuildContext context, BudgetViewModel budgetViewModel) {
    return Column(
      children: [
        Builder(
          builder: (context) {
            if (budgetViewModel.budgetsItems.isEmpty) {
              return Text("no items yet");
            } else {
              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: budgetViewModel.budgetsItems.length,
                    separatorBuilder: (context, index) {
                      return Divider(height: 25);
                    },
                    itemBuilder: (context, index) {
                      BudgetItems item = budgetViewModel.budgetsItems[index];

                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 30,
                              child: Text("${item.name}"),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BlackIconButton(
                                  child: Center(
                                    child: Text(
                                      "${item.quantity}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("CFA ${item.price}"),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Divider(height: 25),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 30,
                          child: Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(Icons.chevron_right),
                            Text(
                              "CFA ${budgetViewModel.totalPrice}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
