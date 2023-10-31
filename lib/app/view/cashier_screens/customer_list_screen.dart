import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import '../../../widgets/my_drawer.dart';
import '../owner_screens/history_modal_sheet.dart';
import 'customer_detail_screen.dart';
import 'sucess_screen.dart';
import '../topup_screens/topup_screen.dart';

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
    return Consumer<CustomerViewModel>(
      builder: (context, customerViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Mes clients"),
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
                      FutureBuilder(
                        future: customerViewModel.getCustomers(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading Customers..."),
                            );
                          } else {
                            return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: customerViewModel.customersList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                var currentCustomer =
                                    customerViewModel.customersList[index];

                                return InkWell(
                                  onTap: () {
                                    customerViewModel
                                        .setSelectedCustomer(currentCustomer);
                                    Constant.navigatePush(
                                        context, CustomerDetailScreen());
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(currentCustomer.name!),
                                          Icon(Icons.chevron_right)
                                        ],
                                      ),
                                      Divider(thickness: 0.5),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            margin: EdgeInsets.symmetric(horizontal: 20),
            label: "Ajoutr un client",
            backgroundColor: Colors.green,
            onTap: () {
              Constant.navigatePush(context, AddCustomerScreen());
            },
          ),
        );
      },
    );
  }
}
