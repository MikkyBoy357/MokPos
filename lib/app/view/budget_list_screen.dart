import 'package:flutter/material.dart';
import 'package:mokpos/app/view/budget_detail_screen.dart';
import 'package:mokpos/app/view_model/budget_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import 'add_budget_screen.dart';

class BudgetListScreen extends StatelessWidget {
  const BudgetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetViewModel>(
      builder: (context, budgetViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Liste des fiches budgétaire"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: budgetViewModel.getBudgetsList(),
                    builder: (context, AsyncSnapshot snap) {
                      if (budgetViewModel.budgetsList.isEmpty) {
                        return Text("No budgets yet");
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: budgetViewModel.budgetsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Constant.navigatePush(
                                  context,
                                  BudgetDetailScreen(budgetIndex: index),
                                );
                              },
                              title: Text(
                                "Budget ${index + 1}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Icon(Icons.chevron_right),
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: MyTextButton(
            onTap: () {
              Constant.navigatePush(context, AddBudgetScreen());
            },
            label: "Ajouter une fiche budgétaire",
            margin: EdgeInsets.all(16),
          ),
        );
      },
    );
  }
}
