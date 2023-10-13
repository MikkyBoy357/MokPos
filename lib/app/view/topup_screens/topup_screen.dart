import 'package:flutter/material.dart';
import 'package:mokpos/app/view/nfc_scan_screen_topup.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/widgets/employee_drawer.dart';
import 'package:mokpos/widgets/number_text_field.dart';
import 'package:provider/provider.dart';

import '../../../base/constant.dart';
import '../../../widgets/back_button_black.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  TextEditingController topupAmtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerViewModel>(
      builder: (context, customerViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text("Topup Account"),
          ),
          drawer: EmployeeDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                NumberTextField(
                  title: "Topup Amount (Min: \$${customerViewModel.minTopup})",
                  controller: topupAmtController,
                  onChanged: (val) {
                    customerViewModel.setTopupAmt(val);
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
              if (customerViewModel.topupAmt >= customerViewModel.minTopup) {
                Constant.navigatePush(
                    context, NfcScanScreenTopup.withDependency());
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
