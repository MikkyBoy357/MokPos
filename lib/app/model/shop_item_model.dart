import 'package:mokpos/util/firebase/firebase.dart';
import 'package:uuid/uuid.dart';

class ShopItemModel {
  String? id;
  String? name;
  double? price;
  String? imageUrl;

  ShopItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  ShopItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

List<ShopItemModel> shopItems = [
  ShopItemModel(
    id: uuid.v1(),
    name: "Cottage Pie",
    price: 10.99,
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/oriri-dd0ec.appspot.com/o/posts%2F35d4e957-b67f-45f0-8e5f-0afe7d91621f.jpg?alt=media&token=9101f050-ee03-4fd7-8e72-1e1c746d4abd",
  ),
  ShopItemModel(
    id: uuid.v1(),
    name: "Cottage Pie",
    price: 10.99,
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/oriri-dd0ec.appspot.com/o/posts%2F35d4e957-b67f-45f0-8e5f-0afe7d91621f.jpg?alt=media&token=9101f050-ee03-4fd7-8e72-1e1c746d4abd",
  ),
  ShopItemModel(
    id: uuid.v1(),
    name: "Amala",
    price: 9.99,
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/oriri-dd0ec.appspot.com/o/posts%2Fed3dc561-7eb4-4aa1-bed0-7d6e28c46608.jpg?alt=media&token=a8c00952-5cef-4138-a853-5677d9b84897",
  ),
  ShopItemModel(
    id: uuid.v1(),
    name: "Cottage Pie",
    price: 10.99,
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/oriri-dd0ec.appspot.com/o/posts%2F35d4e957-b67f-45f0-8e5f-0afe7d91621f.jpg?alt=media&token=9101f050-ee03-4fd7-8e72-1e1c746d4abd",
  ),
];
