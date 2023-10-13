import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mokpos/app/model/dashboard_item_model.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/widgets/bottom_bar.dart';
import 'package:mokpos/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text("Dashboard"),
          ),
          drawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  FutureBuilder(
                    future: userViewModel.getDashboardValues(),
                    builder: (context, AsyncSnapshot asyncSnapshot) {
                      return ListView.separated(
                        itemCount: dasboardItems.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          String mySubtitle = "";
                          if (index == 0) {
                            mySubtitle =
                                "\$${userViewModel.user?.walletBalance}"
                                    .asAmount();
                          } else if (index == 1) {
                            mySubtitle =
                                "\$${userViewModel.user?.principalWalletBalance}"
                                    .asAmount();
                          } else if (index == 2) {
                            mySubtitle = "\$${userViewModel.topupWalletsTotal}"
                                .asAmount();
                          } else if (index == 3) {
                            mySubtitle =
                                "\$${userViewModel.cashierWalletsTotal}"
                                    .asAmount();
                          } else if (index == 4) {
                            mySubtitle =
                                "\$${userViewModel.customerWalletsTotal}"
                                    .asAmount();
                          } else {
                            mySubtitle = "ERROR";
                          }

                          return DashboardCard(
                            title: mySubtitle,
                            subtitle: dasboardItems[index].subtitle,
                            svgPath: dasboardItems[index].svgPath,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String svgPath;
  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SvgPicture.asset(svgPath),
        ],
      ),
    );
  }
}
