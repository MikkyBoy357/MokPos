class CustomerModel {
  String? id;
  String? name;
  String? email;
  num? walletBalance;

  CustomerModel({this.id, this.name, this.email, this.walletBalance});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    walletBalance = json['walletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['walletBalance'] = this.walletBalance;
    return data;
  }
}
