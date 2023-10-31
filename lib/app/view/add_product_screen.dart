import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mokpos/app/view_model/shop/shop_view_model.dart';
import 'package:mokpos/widgets/back_button_black.dart';
import 'package:mokpos/widgets/name_text_field.dart';
import 'package:mokpos/widgets/number_text_field.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopViewModel>(
      builder: (context, shopViewModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Ajouter un produit"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Details de produit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  buildForm(context, shopViewModel),
                  SizedBox(height: 10),
                  Builder(builder: (context) {
                    if (shopViewModel.pickedFile == null) {
                      return SizedBox();
                    } else {
                      String path = shopViewModel.pickedFile?.path ?? "";
                      return Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                            image: FileImage(File(path)),
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: 10),
                  MyTextButton(
                    label: "Pick Image",
                    onTap: () {
                      shopViewModel.pickImage();
                    },
                  ),
                  // Text("data"),
                ],
              ),
            ),
          ),
          floatingActionButton: MyTextButton(
            onTap: () {
              print("object");
              shopViewModel.uploadProduct(context);
            },
            label: "Ajouter produit",
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Form buildForm(BuildContext context, ShopViewModel viewModel) {
    return Form(
      child: Column(
        children: [
          NameTextField(
            title: "Nom de produit",
            controller: nameController,
            onChanged: (val) {
              viewModel.setName(val);
            },
          ),
          SizedBox(height: 10),
          NumberTextField(
            title: "Prix vendent",
            controller: priceController,
            onChanged: (val) {
              viewModel.setPrice(val);
            },
          ),
          SizedBox(height: 10),
          NameTextField(
            title: "Category",
            controller: categoryController,
            onChanged: (val) {
              viewModel.setCategory(val);
            },
          ),
          // SizedBox(height: 10),
          // NameTextField(
          //   title: "Image",
          //   controller: imageController,
          //   onChanged: (val) {
          //     viewModel.setImage(val);
          //   },
          // ),
        ],
      ),
    );
  }
}
