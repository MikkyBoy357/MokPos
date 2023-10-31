import 'package:flutter/material.dart';
import 'package:mokpos/app/view/cashier_screens/add_customer_screen.dart';
import 'package:mokpos/app/view/cashier_screens/register_client_nfc_screen.dart';
import 'package:mokpos/app/view/nfc_scan_screen_register_customer.dart';
import 'package:mokpos/app/view_model/customer/customer_view_model.dart';
import 'package:mokpos/app/view_model/user/user_view_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:mokpos/widgets/email_text_field.dart';
import 'package:mokpos/widgets/number_text_field.dart';
import 'package:mokpos/widgets/password_field.dart';
import 'package:mokpos/widgets/phone_text_field.dart';
import 'package:provider/provider.dart';

import '../../../widgets/my_drawer.dart';
import '../../../widgets/name_text_field.dart';
import '../onboarding_screens/custom_button.dart';
import '../owner_screens/history_modal_sheet.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool checkFields() {
    return emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        passController.text.length >= 8;
  }

  bool isGrid = false;

  void changeGrid() {
    isGrid = !isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Enregistrer un Agent"),
          ),
          // drawer: MyDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  buildForm(context, userViewModel),
                  SizedBox(height: 20),
                  Text(
                    "Select Type of Employee",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomSmallButton(
                        isSelected: userViewModel.newEmpType == "cashier",
                        label: "Point de vente",
                        fontSize: 12,
                        icon: Icons.money,
                        onTap: () => userViewModel.setEmpType("cashier"),
                      ),
                      CustomSmallButton(
                        isSelected: userViewModel.newEmpType == "topup",
                        label: "Point de Recharge",
                        fontSize: 12,
                        icon: Icons.wifi,
                        onTap: () => userViewModel.setEmpType("topup"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MyTextButton(
            margin: EdgeInsets.symmetric(horizontal: 20),
            label: "ENREGISTRER",
            backgroundColor: checkFields() ? Colors.green : Colors.grey[600],
            onTap: () {
              if (userViewModel.email.isNotEmpty &&
                  userViewModel.name.isNotEmpty &&
                  userViewModel.phone.isNotEmpty &&
                  userViewModel.pass.isNotEmpty &&
                  (userViewModel.pass.length >= 8) &&
                  checkFields()) {
                print("Add Employee");
                userViewModel.registerNewEmployee(context);
                // Constant.navigatePush(
                //     context, RegisterClientNfcScreen.withDependency());
              } else {
                print("Invalid Form");
              }
            },
          ),
        );
      },
    );
  }

  Widget buildForm(BuildContext context, UserViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          NameTextField(
            title: "NOM",
            hintText: "Martin MBAPPE",
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
          NumberTextField(
            title: "Tel",
            hintText: "12378900",
            controller: phoneController,
            onChanged: (String val) {
              viewModel.setPhone(val);
            },
          ),
          SizedBox(height: 20),
          PasswordField(
            controller: passController,
            onChanged: (String val) {
              viewModel.setPass(val);
            },
          ),
        ],
      ),
    );
  }
}
