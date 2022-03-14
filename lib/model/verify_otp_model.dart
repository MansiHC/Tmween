class VerifyOtpModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  VerifyOtpModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CustomerData? customerData;

  Data({this.customerData});

  Data.fromJson(Map<String, dynamic> json) {
    customerData = json['customer_data'] != null
        ? new CustomerData.fromJson(json['customer_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerData != null) {
      data['customer_data'] = this.customerData!.toJson();
    }
    return data;
  }
}

class CustomerData {
  String? yourName;
  String? phone;
  int? confirmation;
  int? status;
  int? isVerified;
  Null? email;
  String? dob;
  String? createdAt;
  String? updatedAt;
  int? id;

  CustomerData(
      {this.yourName,
      this.phone,
      this.confirmation,
      this.status,
      this.isVerified,
      this.email,
      this.dob,
      this.createdAt,
      this.updatedAt,
      this.id});

  CustomerData.fromJson(Map<String, dynamic> json) {
    yourName = json['your_name'];
    phone = json['phone'];
    confirmation = json['confirmation'];
    status = json['status'];
    isVerified = json['is_verified'];
    email = json['email'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['your_name'] = this.yourName;
    data['phone'] = this.phone;
    data['confirmation'] = this.confirmation;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
