class OrderItemModel {
  int? count;
  String? id;
  String? name;
  double? price;
  String? imageUrl;

  OrderItemModel({
    required this.count,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
