import 'package:flutter/material.dart';

class ProductModel {
  String? id;
  String? name;
  num? price;
  String? category;
  String? image;

  ProductModel({this.name, this.price, this.category, this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
