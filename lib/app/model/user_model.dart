import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? phone;
  num? walletBalance;
  String? userType;
  num? principalWalletBalance;

  UserModel({
    this.id,
    this.email,
    this.phone,
    this.walletBalance,
    this.userType,
    this.principalWalletBalance,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    walletBalance = json['walletBalance'];
    userType = json['userType'];
    principalWalletBalance = json['principalWalletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['walletBalance'] = this.walletBalance;
    data['userType'] = this.userType;
    data['principalWalletBalance'] = this.principalWalletBalance;

    return data;
  }
}
