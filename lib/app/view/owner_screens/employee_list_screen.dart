import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/topup_screen.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:provider/provider.dart';

import 'add_new_employee_screen.dart';
import 'topup_employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Employees"),
            actions: [
              IconButton(
                onPressed: () {
                  Constant.navigatePush(context, AddNewEmployeeScreen());
                },
                icon: Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future: userViewModel.getEmployeeList(),
                    builder: (context, AsyncSnapshot snap) {
                      if (userViewModel.employeeList.isEmpty) {
                        return Text("You currently have no employees");
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userViewModel.employeeList.length,
                          itemBuilder: (context, index) {
                            final currentEmployee =
                                userViewModel.employeeList[index];

                            return Card(
                              child: ListTile(
                                // leading: Text(currentEmployee.employeeId!),
                                title: Text("${currentEmployee.employeeId}"),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${currentEmployee.name}"),
                                    Text(
                                      "\$${currentEmployee.walletBalance}",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    if (currentEmployee.employeeType ==
                                        "topup") {
                                      userViewModel.topupEmployee =
                                          currentEmployee;
                                      Constant.navigatePush(
                                        context,
                                        TopupEmployeeScreen(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Center(
                                      child: Text(
                                          "${currentEmployee.employeeType}"),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
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
