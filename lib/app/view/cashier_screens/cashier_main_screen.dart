import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/owner_screens/dashboard_screen.dart';
import 'package:mokpos/widgets/bottom_bar.dart';

import 'cashier_home_screen.dart';

// ignore: must_be_immutable
class CashierMainScreen extends StatefulWidget {
  var cartItemId;
  @override
  _CashierMainScreenState createState() => _CashierMainScreenState();
}

class _CashierMainScreenState extends State<CashierMainScreen> {
  int _selectedItem = 1;
  late String uid;
  PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
            print(_selectedItem);
          });
        },
        children: [
          CashierHomeScreen(),
          Text("Checking"),
          Text("Customers"),
        ],
        controller: _pageController,
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedItem,
        onTap: (index) {
          setState(
            () {
              _selectedItem = index;
              _pageController.animateToPage(_selectedItem,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          );
        },
      ),
    );
  }
}
