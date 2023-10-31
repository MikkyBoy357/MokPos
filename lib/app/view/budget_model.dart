class BudgetModel {
  String? id;
  List<BudgetItems>? budgetItems;

  BudgetModel({this.id, this.budgetItems});

  BudgetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['budgetItems'] != null) {
      budgetItems = <BudgetItems>[];
      json['budgetItems'].forEach((v) {
        budgetItems!.add(new BudgetItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.budgetItems != null) {
      data['budgetItems'] = this.budgetItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BudgetItems {
  String? id;
  String? name;
  double? price;
  int? quantity;

  BudgetItems({this.id, this.name, this.price, this.quantity});

  BudgetItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
