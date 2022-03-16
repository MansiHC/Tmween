class GetCustomerDataModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  List<ProfileData>? data;

  GetCustomerDataModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetCustomerDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProfileData>[];
      json['data'].forEach((v) {
        data!.add(new ProfileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? yourName;
  String? phone;
  String? email;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? createdFrom;
  String? dob;
  String? password;
  String? passwordHash;
  String? defaultBilling;
  String? defaultShipping;
  String? taxvat;
  String? accountVerificationToken;
  int? confirmation;
  int? isVerified;
  String? gender;
  String? resetPwdToken;
  String? tokenExpiredAt;
  String? otp;
  String? expiredDate;
  String? smallImageUrl;
  String? largeImageUrl;

  ProfileData(
      {this.id,
        this.yourName,
        this.phone,
        this.email,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdFrom,
        this.dob,
        this.password,
        this.passwordHash,
        this.defaultBilling,
        this.defaultShipping,
        this.taxvat,
        this.accountVerificationToken,
        this.confirmation,
        this.isVerified,
        this.gender,
        this.resetPwdToken,
        this.tokenExpiredAt,
        this.otp,
        this.expiredDate,
        this.smallImageUrl,
        this.largeImageUrl});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yourName = json['your_name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdFrom = json['created_from'];
    dob = json['dob'];
    password = json['password'];
    passwordHash = json['password_hash'];
    defaultBilling = json['default_billing'];
    defaultShipping = json['default_shipping'];
    taxvat = json['taxvat'];
    accountVerificationToken = json['account_verification_token'];
    confirmation = json['confirmation'];
    isVerified = json['is_verified'];
    gender = json['gender'];
    resetPwdToken = json['reset_pwd_token'];
    tokenExpiredAt = json['token_expired_at'];
    otp = json['otp'];
    expiredDate = json['expired_date'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['your_name'] = this.yourName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_from'] = this.createdFrom;
    data['dob'] = this.dob;
    data['password'] = this.password;
    data['password_hash'] = this.passwordHash;
    data['default_billing'] = this.defaultBilling;
    data['default_shipping'] = this.defaultShipping;
    data['taxvat'] = this.taxvat;
    data['account_verification_token'] = this.accountVerificationToken;
    data['confirmation'] = this.confirmation;
    data['is_verified'] = this.isVerified;
    data['gender'] = this.gender;
    data['reset_pwd_token'] = this.resetPwdToken;
    data['token_expired_at'] = this.tokenExpiredAt;
    data['otp'] = this.otp;
    data['expired_date'] = this.expiredDate;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}
