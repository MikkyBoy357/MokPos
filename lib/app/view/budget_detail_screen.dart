import 'package:flutter/material.dart';
import 'package:mokpos/app/view/budget_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/back_button_black.dart';
import '../view_model/budget_view_model.dart';

class BudgetDetailScreen extends StatelessWidget {
  final int budgetIndex;
  const BudgetDetailScreen({
    super.key,
    required this.budgetIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetViewModel>(
      builder: (context, budgetViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Budget ${budgetIndex + 1}"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  buildBudgetItems(
                      context, budgetViewModel.budgetsList[budgetIndex]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildBudgetItems(BuildContext context, BudgetModel budget) {
    return Column(
      children: [
        Builder(
          builder: (context) {
            if (false) {
              return Text("no items yet");
            } else {
              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: budget.budgetItems!.length,
                    separatorBuilder: (context, index) {
                      return Divider(height: 25);
                    },
                    itemBuilder: (context, index) {
                      BudgetItems item = budget.budgetItems![index];

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
                            Builder(
                              builder: (context) {
                                double total = 0;

                                for (var item in budget.budgetItems!) {
                                  total += (item.price! * item.quantity!);
                                }

                                return Text(
                                  "CFA $total",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
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
