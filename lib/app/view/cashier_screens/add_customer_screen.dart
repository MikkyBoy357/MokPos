import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/app/view/cashier_screens/register_client_nfc_screen.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:mokpos/widgets/email_text_field.dart';
import 'package:mokpos/widgets/phone_text_field.dart';

import '../../../widgets/my_drawer.dart';
import '../../../widgets/name_text_field.dart';
import '../owner_screens/history_modal_sheet.dart';
import 'sucess_screen.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  bool isGrid = false;

  void changeGrid() {
    isGrid = !isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            NameTextField(
              title: "Name",
              hintText: "ABC23654",
              controller: TextEditingController(),
              onChanged: (String newVal) {
                // authProvider.changeNotifiers();
              },
            ),
            SizedBox(height: 20),
            PhoneTextField(
              hintText: "1234567890",
              controller: TextEditingController(),
              onChanged: (String newVal) {
                // authProvider.changeNotifiers();
              },
            ),
            SizedBox(height: 20),
            EmailTextField(
              controller: TextEditingController(),
              onChanged: (String newVal) {
                // authProvider.changeNotifiers();
              },
            ),
            SizedBox(height: 20),
            NameTextField(
              title: "Address",
              hintText: "Example: 3795  High Meadow Lane, Harrisburg",
              controller: TextEditingController(),
              onChanged: (String newVal) {
                // authProvider.changeNotifiers();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MyTextButton(
        margin: EdgeInsets.symmetric(horizontal: 20),
        label: "SAVE",
        backgroundColor: Colors.green,
        onTap: () {
          Constant.navigatePush(context, RegisterClientNfcScreen());
        },
      ),
    );
  }
}
