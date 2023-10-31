import 'package:flutter/material.dart';
import 'package:mokpos/app/view/owner_screens/account_screen.dart';

import '../../base/constant.dart';
import '../view/budget_list_screen.dart';
import '../view/owner_screens/history_transactions_screen.dart';

class DrawerItemModel {
  String label;
  String svgPath;
  Widget nextPage;

  DrawerItemModel({
    required this.label,
    required this.svgPath,
    required this.nextPage,
  });
}

List<DrawerItemModel> drawerItems = [
  // DrawerItemModel(
  //   label: "Cashier",
  //   svgPath: "${Constant.assetSvgPath}cashier.svg",
  //   nextPage: Placeholder(),
  // ),
  DrawerItemModel(
    label: "History Transaction",
    svgPath: "${Constant.assetSvgPath}coins.svg",
    nextPage: HistoryTransactionsScreen(),
  ),
  DrawerItemModel(
    label: "Budgets",
    svgPath: "${Constant.assetSvgPath}coins.svg",
    nextPage: BudgetListScreen(),
  ),
  // DrawerItemModel(
  //   label: "Report",
  //   svgPath: "${Constant.assetSvgPath}touch_screen.svg",
  //   nextPage: Placeholder(),
  // ),
  // DrawerItemModel(
  //   label: "Manage Store",
  //   svgPath: "${Constant.assetSvgPath}shop.svg",
  //   nextPage: Placeholder(),
  // ),
  DrawerItemModel(
    label: "Account",
    svgPath: "${Constant.assetSvgPath}user_outlined.svg",
    nextPage: AccountScreen(),
  ),
  // DrawerItemModel(
  //   label: "Support",
  //   svgPath: "${Constant.assetSvgPath}support.svg",
  //   nextPage: Placeholder(),
  // ),
];
