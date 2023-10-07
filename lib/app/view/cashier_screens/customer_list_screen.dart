import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';

import '../../../widgets/my_drawer.dart';
import '../owner_screens/history_modal_sheet.dart';
import 'sucess_screen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  bool isGrid = false;

  void changeGrid() {
    isGrid = !isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Divider(thickness: 0.5),
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 0.8,
                color: Colors.grey,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search name, phone number, or email",
                  style: TextStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [SizedBox(width: 10), Icon(Icons.search)],
                ),
              ],
            ),
          ),
          Divider(thickness: 0.5),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("John Doe"),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                          Divider(thickness: 0.5),
                        ],
                      );
                    },
                  ),
                  //
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyTextButton(
        margin: EdgeInsets.symmetric(horizontal: 20),
        label: "Add New Customer",
        backgroundColor: Colors.green,
        onTap: () {
          Constant.navigatePush(context, AddCustomerScreen());
        },
      ),
    );
  }
}
