import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/owner_screens/dashboard_screen.dart';

import '../../widgets/bottom_bar.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  var cartItemId;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 1;
  late String uid;
  PageController _pageController = PageController(initialPage: 1);
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
          Text("Checking"),
          DashboardScreen(),
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
