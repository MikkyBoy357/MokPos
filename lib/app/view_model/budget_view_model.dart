import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/budget_model.dart';
import 'package:mokpos/app/view_model/shop/shop_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/util/firebase/firebase.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/order_item_model.dart';
import '../view/product_model.dart';

class BudgetViewModel extends ChangeNotifier {
  double totalPrice = 0;
  List<BudgetModel> budgetsList = [];

  List<BudgetItems> budgetsItems = [];

  void addItemToCart(ProductModel shopItem) {
    var tempShopItem = shopItem.toJson();
    var budgetsItem = BudgetItems.fromJson(tempShopItem);

    var index =
        budgetsItems.indexWhere((element) => element.id == budgetsItem.id);
    if (index < 0) {
      budgetsItems.add(budgetsItem..quantity = 1);
    } else {
      print("====> Item exist in cart");

      budgetsItems[index].quantity = budgetsItems[index].quantity! + 1;
      // print("====> ${cartItems[index].toJson()}");
    }
    print(budgetsItems);
    calculateTotalPrice();
    notifyListeners();
  }

  void generateBudgetItems(List<OrderItemModel> cartItems) {
    budgetsItems.clear();

    for (var item in cartItems) {
      BudgetItems tempBudItem = BudgetItems()
        ..id = Uuid().v1()
        ..name = item.name
        ..price = item.price
        ..quantity = item.count;

      budgetsItems.add(tempBudItem);
    }

    print("=======> Generate Budget Items");
    print(budgetsItems);
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in budgetsItems) {
      double itemPrice = (item.price! * item.quantity!);
      totalPrice += itemPrice;
    }
  }

  Future<void> getBudgetsList() async {
    print("get budgets");
    QuerySnapshot snap = await budgetsRef.get();

    budgetsList.clear();
    for (QueryDocumentSnapshot doc in snap.docs) {
      var tempBud = doc.data() as Map<String, dynamic>;
      budgetsList.add(BudgetModel.fromJson(tempBud));
    }
  }

  void clearBudget() {
    budgetsItems.clear();
    calculateTotalPrice();
    notifyListeners();
  }

  Future<void> saveBudget(BuildContext context) async {
    if (budgetsItems.isEmpty) {
      print("Budget must not be empty");
    } else {
      try {
        print("========> Save Budget <=======");

        String tempId = Uuid().v1();
        BudgetModel tempBud = BudgetModel()
          ..id = tempId
          ..budgetItems = budgetsItems;

        var snap = await budgetsRef.doc(tempId).set(tempBud.toJson());
        clearBudget();
        Provider.of<ShopViewModel>(context, listen: false).clearCart();
        Constant.backToPrev(context);
        getBudgetsList();
      } catch (e) {
        print("Error saving budget");
      }
    }
  }
}
