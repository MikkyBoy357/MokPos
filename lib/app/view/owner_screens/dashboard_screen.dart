import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mokpos/app/model/dashboard_item_model.dart';
import 'package:mokpos/widgets/bottom_bar.dart';
import 'package:mokpos/widgets/my_drawer.dart';

import '../../../base/constant.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Dashboard"),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            ListView.separated(
              itemCount: dasboardItems.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemBuilder: (context, index) {
                return DashboardCard(
                  title: dasboardItems[index].title,
                  subtitle: dasboardItems[index].subtitle,
                  svgPath: dasboardItems[index].svgPath,
                );
              },
            ),
          ],
        ),
      ),
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
