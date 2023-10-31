import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mokpos/app/view/service.dart';
import 'package:mokpos/app/model/order_item_model.dart';
import 'package:mokpos/app/model/shop_item_model.dart';
import 'package:mokpos/app/view/product_model.dart';
import 'package:mokpos/base/constant.dart';
import 'package:mokpos/util/firebase/firebase.dart';
import 'package:mokpos/widgets/error_dialog.dart';
import 'package:uuid/uuid.dart';

class ShopViewModel extends ChangeNotifier {
  double totalPrice = 0;
  List<OrderItemModel> cartItems = [];
  List<ProductModel> productsList = [];

  /// Add Product
  String name = "";
  String category = "";
  double price = 0.0;
  String image = "";

  //Variables
  XFile? pickedFile;
  bool loading = false;
  File? mediaFile;
  final picker = ImagePicker();
  File? userDp;
  String? imgLink;

  void setName(String val) {
    name = val;
    notifyListeners();
  }

  void setCategory(String val) {
    category = val;
    notifyListeners();
  }

  void setPrice(String val) {
    price = double.parse(val);
    notifyListeners();
  }

  void setImage(String val) {
    image = val;
    notifyListeners();
  }

  //Functions
  pickImage({bool camera = false, BuildContext? context}) async {
    loading = true;
    notifyListeners();
    try {
      print('Picking Image');
      pickedFile = await picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery,
      );
      // File croppedFile = await ImageCropper.cropImage(
      //   sourcePath: pickedFile.path,
      //   aspectRatioPresets: [
      //     CropAspectRatioPreset.square,
      //     CropAspectRatioPreset.ratio3x2,
      //     CropAspectRatioPreset.original,
      //     CropAspectRatioPreset.ratio4x3,
      //     CropAspectRatioPreset.ratio16x9
      //   ],
      //   androidUiSettings: AndroidUiSettings(
      //     toolbarTitle: 'Crop Image',
      //     toolbarColor: Constants.lightAccent,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false,
      //   ),
      //   iosUiSettings: IOSUiSettings(
      //     minimumAspectRatio: 1.0,
      //   ),
      // );
      // mediaFile = File(croppedFile.path);
      mediaFile = File(pickedFile!.path);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      // showInSnackBar('Cancelled', context);
      print('Cancelled');
    }
  }

  Future<void> uploadProductImage(BuildContext context) async {
    if (mediaFile == null) {
      showInSnackBar('Please select an image', context);
    } else {
      try {
        loading = true;
        notifyListeners();

        try {
          // await productImagesRef.putFile(mediaFile!).then((p0) => p0.ref.);
          image = await Service().uploadImage(productImagesRef, mediaFile!);

          print("file upload success");
        } catch (e) {
          print("Error uploading file");
          print(e);
        }
        loading = false;
        // Navigator.of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
        notifyListeners();
      } catch (e) {
        print(e);
        loading = false;
        // showInSnackBar('Uploaded successfully!', context);
        notifyListeners();
      }
    }
  }

  resetPost() {
    mediaFile = null;
    notifyListeners();
  }

  Future<void> uploadProduct(BuildContext context) async {
    if (name.isEmpty || price <= 0 || category.isEmpty) {
      print("Invalid Fields");
      return;
    }

    await uploadProductImage(context);

    try {
      print("=====> Upload Product <=====");

      String tempId = Uuid().v1();
      ProductModel newProduct = ProductModel();
      newProduct.id = tempId;
      newProduct.name = name;
      newProduct.price = price;
      newProduct.category = category;
      newProduct.image = image;

      print(newProduct.toJson());

      await productsRef.doc(tempId).set(newProduct.toJson());

      showDialog(
        context: context,
        builder: (context) {
          return SuccessDialog(
            text: "Product added successfully",
          );
        },
      ).then((value) => {Constant.backToPrev(context)});

      print("=====> Product Upload Success <=====");
    } catch (e) {
      print("Product Error");
      print(e);
    }
  }

  void showInSnackBar(String value, BuildContext context) {
    // scaffoldKey.currentState.removeCurrentSnackBar();
    var snackBar = SnackBar(content: Text(value));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getProducts() async {
    print("get products");
    QuerySnapshot snap = await productsRef.get();

    productsList.clear();
    for (QueryDocumentSnapshot doc in snap.docs) {
      var tempProd = doc.data() as Map<String, dynamic>;
      productsList.add(ProductModel.fromJson(tempProd));
    }
  }

  void addItemToCart(ProductModel shopItem) {
    var tempShopItem = shopItem.toJson();
    var orderItem = OrderItemModel.fromJson(tempShopItem);

    var index = cartItems.indexWhere((element) => element.id == orderItem.id);
    if (index < 0) {
      cartItems.add(orderItem..count = 1);
    } else {
      print("====> Item exist in cart");

      cartItems[index].count = cartItems[index].count! + 1;
      // print("====> ${cartItems[index].toJson()}");
    }
    print(cartItems);
    calculateTotalPrice();
    notifyListeners();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in cartItems) {
      double itemPrice = (item.price! * item.count!);
      totalPrice += itemPrice;
    }
  }

  void clearCart() {
    cartItems.clear();
    calculateTotalPrice();
    notifyListeners();
  }
}
