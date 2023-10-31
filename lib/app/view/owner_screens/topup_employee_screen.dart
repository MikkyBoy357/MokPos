import 'package:flutter/material.dart';
import 'package:mokpos/app/view/nfc_scan_screen_topup.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/widgets/error_dialog.dart';
import 'package:mokpos/widgets/number_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../widgets/back_button_black.dart';

class TopupEmployeeScreen extends StatefulWidget {
  const TopupEmployeeScreen({super.key});

  @override
  State<TopupEmployeeScreen> createState() => _TopupEmployeeScreenState();
}

class _TopupEmployeeScreenState extends State<TopupEmployeeScreen> {
  TextEditingController topupAmtController = TextEditingController();

  @override
  void didChangeDependencies() {
    Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Topup Employee"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                NumberTextField(
                  title: "Topup Amount (Min: CFA ${userViewModel.minTopup})",
                  controller: topupAmtController,
                  onChanged: (val) {
                    userViewModel.setTopupAmt(val);
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            margin: EdgeInsets.symmetric(horizontal: 20),
            label: "PROCEED",
            backgroundColor: Colors.green,
            onTap: () {
              if (userViewModel.topupAmt >= userViewModel.minTopup) {
                showDialog(
                  context: context,
                  builder: (dcontext) {
                    return ConfirmDialog(
                      title: "Confirm Topup",
                      text:
                          "Do you want to proceed with topup CFA ${userViewModel.minTopup} for Employee ${userViewModel.topupEmployee?.name?.toUpperCase()} with ID: ${userViewModel.topupEmployee?.employeeId}",
                      onYes: () async {
                        Navigator.of(context).pop(context);
                        await userViewModel.makeTopupForEmployee(context);
                      },
                    );
                  },
                );
              } else {
                print("Invalid Form");
              }
            },
          ),
        );
      },
    );
  }
}
