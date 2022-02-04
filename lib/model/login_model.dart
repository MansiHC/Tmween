
class LoginModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  LoginModel({this.statusCode, this.statusMessage, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? token;
  int? loginLogId;
  CustomerData? customerData;

  Data({this.token, this.loginLogId, this.customerData});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    loginLogId = json['login_log_id'];
    customerData = json['customer_data'] != null
        ? new CustomerData.fromJson(json['customer_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['login_log_id'] = this.loginLogId;
    if (this.customerData != null) {
      data['customer_data'] = this.customerData!.toJson();
    }
    return data;
  }
}

class CustomerData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? createdFrom;
  String? dob;
  String? passwordHash;
  Null? defaultBilling;
  Null? defaultShipping;
  Null? taxvat;
  String? accountVerificationToken;
  int? confirmation;
  int? gender;
  String? resetPwdToken;
  String? tokenExpiredAt;

  CustomerData(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdFrom,
        this.dob,
        this.passwordHash,
        this.defaultBilling,
        this.defaultShipping,
        this.taxvat,
        this.accountVerificationToken,
        this.confirmation,
        this.gender,
        this.resetPwdToken,
        this.tokenExpiredAt});

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdFrom = json['created_from'];
    dob = json['dob'];
    passwordHash = json['password_hash'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    taxvat = json['taxvat'];
    accountVerificationToken = json['account_verification_token'];
    confirmation = json['confirmation'];
    gender = json['gender'];
    resetPwdToken = json['reset_pwd_token'];
    tokenExpiredAt = json['token_expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_from'] = this.createdFrom;
    data['dob'] = this.dob;
    data['password_hash'] = this.passwordHash;
    data['default_billing'] = this.defaultBilling;
    data['default_shipping'] = this.defaultShipping;
    data['taxvat'] = this.taxvat;
    data['account_verification_token'] = this.accountVerificationToken;
    data['confirmation'] = this.confirmation;
    data['gender'] = this.gender;
    data['reset_pwd_token'] = this.resetPwdToken;
    data['token_expired_at'] = this.tokenExpiredAt;
    return data;
  }
}

