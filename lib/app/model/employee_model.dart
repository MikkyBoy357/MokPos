class EmployeeModel {
  String? employeeType;
  String? employeeCode;
  String? employeeId;
  String? ownerId;
  String? password;
  num? walletBalance;
  String? name;
  String? email;
  String? phone;

  EmployeeModel(
      {this.employeeType,
      this.employeeCode,
      this.employeeId,
      this.ownerId,
      this.password,
      this.walletBalance,
      this.name,
      this.email,
      this.phone});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    employeeType = json['employeeType'];
    employeeCode = json['employeeCode'];
    employeeId = json['employeeId'];
    ownerId = json['ownerId'];
    password = json['password'];
    walletBalance = json['walletBalance'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeType'] = this.employeeType;
    data['employeeCode'] = this.employeeCode;
    data['employeeId'] = this.employeeId;
    data['ownerId'] = this.ownerId;
    data['password'] = this.password;
    data['walletBalance'] = this.walletBalance;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
