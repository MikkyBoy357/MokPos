import 'package:flutter/material.dart';
import 'package:mokpos/app/model/order_item_model.dart';
import 'package:mokpos/app/model/shop_item_model.dart';

class ShopViewModel extends ChangeNotifier {
  double totalPrice = 0;
  List<OrderItemModel> cartItems = [];

  void addItemToCart(ShopItemModel shopItem) {
    var tempShopItem = shopItem.toJson();
    var orderItem = OrderItemModel.fromJson(tempShopItem);

    var index = cartItems.indexWhere((element) => element.id == orderItem.id);
    if (index < 0) {
      cartItems.add(orderItem..count = 1);
    } else {
      print("====> Item exist in cart");

      cartItems[index].count = cartItems[index].count! + 1;
      // print("====> ${cartItems[index].toJson()}");
    }
    print(cartItems);
    calculateTotalPrice();
    notifyListeners();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in cartItems) {
      double itemPrice = (item.price! * item.count!);
      totalPrice += itemPrice;
    }
  }

  void clearCart() {
    cartItems.clear();
    calculateTotalPrice();
    notifyListeners();
  }
}
