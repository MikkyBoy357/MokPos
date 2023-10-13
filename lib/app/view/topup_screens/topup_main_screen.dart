import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/customer_list_screen.dart';
import 'package:mokpos/app/view/topup_screens/topup_screen.dart';
import 'package:mokpos/app/view/owner_screens/dashboard_screen.dart';
import 'package:mokpos/widgets/bottom_bar.dart';

import '../../../widgets/topup_bottom_bar.dart';
import '../cashier_screens/add_customer_screen.dart';

// ignore: must_be_immutable
class TopupMainScreen extends StatefulWidget {
  var cartItemId;
  @override
  _TopupMainScreenState createState() => _TopupMainScreenState();
}

class _TopupMainScreenState extends State<TopupMainScreen> {
  int _selectedItem = 0;
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
          TopupScreen(),
          AddCustomerScreen()
          // Text("Checking"),
          // CustomerListScreen(),
        ],
        controller: _pageController,
      ),
      bottomNavigationBar: TopupBottomBar(
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
