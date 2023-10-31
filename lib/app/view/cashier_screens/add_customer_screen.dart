import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/app/view/cashier_screens/register_client_nfc_screen.dart';
import 'package:mokpos/app/view/nfc_scan_screen_register_customer.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:mokpos/widgets/email_text_field.dart';
import 'package:mokpos/widgets/employee_drawer.dart';
import 'package:mokpos/widgets/phone_text_field.dart';
import 'package:provider/provider.dart';

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
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zoneController = TextEditingController();

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
            title: Text("Add New Customer"),
          ),
          drawer: EmployeeDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                buildForm(context, customerViewModel),
                SizedBox(height: 20),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            margin: EdgeInsets.symmetric(horizontal: 20),
            label: "ENREGISTRER",
            backgroundColor: Colors.green,
            onTap: () {
              if (customerViewModel.email.isNotEmpty &&
                  customerViewModel.name.isNotEmpty) {
                Constant.navigatePush(
                    context, RegisterClientNfcScreen.withDependency());
              } else {
                print("Invalid Form");
              }
            },
          ),
        );
      },
    );
  }

  Widget buildForm(BuildContext context, CustomerViewModel viewModel) {
    return Form(
      // key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          NameTextField(
            title: "NOM",
            hintText: "DOSSA Jean",
            controller: nameController,
            onChanged: (String val) {
              viewModel.setName(val);
            },
          ),
          SizedBox(height: 20),
          EmailTextField(
            controller: emailController,
            onChanged: (String val) {
              viewModel.setEmail(val);
            },
          ),
          SizedBox(height: 20),
          PhoneTextField(
            title: "Tel (+229)",
            hintText: "97090909",
            controller: emailController,
            onChanged: (String val) {
              viewModel.setEmail(val);
            },
          ),
          SizedBox(height: 20),
          NameTextField(
            title: "Address",
            hintText: "Entrer une adresse",
            controller: addressController,
            onChanged: (String val) {
              viewModel.setAddress(val);
            },
          ),
          SizedBox(height: 20),
          NameTextField(
            title: "Zone",
            hintText: "Entrer une zone",
            controller: zoneController,
            onChanged: (String val) {
              viewModel.setZone(val);
            },
          ),
        ],
      ),
    );
  }
}
