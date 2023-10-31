import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopupBottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const TopupBottomBar({
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
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Ajouter Client",
          icon: Icon(CupertinoIcons.profile_circled),
        ),
        // BottomNavigationBarItem(
        //   label: "Employees",
        //   icon: Icon(CupertinoIcons.profile_circled),
        // ),
      ],
    );
  }
}
