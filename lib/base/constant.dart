import 'package:flutter/material.dart';

extension ApplyComma on String {
  String get valueWithComma => replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");

  String asAmount() => toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");
}

class Constant {
  static const assetImagePath = "assets/images/";
  static const assetSvgPath = "assets/svg/";
  static void navigatePush(BuildContext context, Widget nextScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return nextScreen;
        },
      ),
    );
  }

  static void navigatePushReplacement(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return nextScreen;
        },
      ),
    );
  }

  static backToPrev(BuildContext context) {
    Navigator.of(context).pop();
  }
}
