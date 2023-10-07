import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const BottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          label: "Checking",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Dashboard",
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: "Customers",
          icon: Icon(CupertinoIcons.profile_circled),
        ),
      ],
    );
  }
}
