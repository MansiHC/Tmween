class UserDataModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  UserDataModel({this.statusCode, this.statusMessage, this.message, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200) {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    }
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
  List<CustomerAddressData>? customerAddressData;

  Data(
      {this.token,
      this.loginLogId,
      this.customerData,
      this.customerAddressData});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    loginLogId = json['login_log_id'];
    customerData = json['customer_data'] != null
        ? new CustomerData.fromJson(json['customer_data'])
        : null;
    if (json['customer_address_data'] != null) {
      customerAddressData = <CustomerAddressData>[];
      json['customer_address_data'].forEach((v) {
        customerAddressData!.add(new CustomerAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['login_log_id'] = this.loginLogId;
    if (this.customerData != null) {
      data['customer_data'] = this.customerData!.toJson();
    }
    if (this.customerAddressData != null) {
      data['customer_address_data'] =
          this.customerAddressData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerData {
  int? id;
  String? yourName;
  String? phone;
  String? email;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? createdFrom;
  String? dob;
  String? image;
  String? password;
  String? passwordHash;
  String? taxvat;
  String? accountVerificationToken;
  int? confirmation;
  int? isVerified;
  int? gender;
  String? resetPwdToken;
  String? tokenExpiredAt;
  String? otp;
  String? expiredDate;
  String? smallImageUrl;
  String? largeImageUrl;

  CustomerData(
      {this.id,
      this.yourName,
      this.phone,
      this.email,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdFrom,
      this.dob,
      this.image,
      this.password,
      this.passwordHash,
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

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yourName = json['your_name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdFrom = json['created_from'];
    dob = json['dob'];
    image = json['image'];
    password = json['password'];
    passwordHash = json['password_hash'];
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
    data['image'] = this.image;
    data['password'] = this.password;
    data['password_hash'] = this.passwordHash;
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

class CustomerAddressData {
  int? id;
  int? customerId;
  String? createdAt;
  int? status;
  String? updatedAt;
  String? fullname;
  String? address1;
  String? address2;
  String? landmark;
  String? addressType;
  int? defaultAddress;
  String? deliveryInstruction;
  String? phone1Isd;
  String? phone1;
  String? mobile1Isd;
  String? mobile1;
  String? zip;
  String? countryCode;
  String? stateCode;
  String? cityCode;
  String? countryName;
  String? stateName;
  String? cityName;
  int? isDefaultShipping;
  int? isDefaultBilling;

  CustomerAddressData(
      {this.id,
      this.customerId,
      this.createdAt,
      this.status,
      this.updatedAt,
      this.fullname,
      this.address1,
      this.address2,
      this.landmark,
      this.addressType,
      this.defaultAddress,
      this.deliveryInstruction,
      this.phone1Isd,
      this.phone1,
      this.mobile1Isd,
      this.mobile1,
      this.zip,
      this.countryCode,
      this.stateCode,
      this.cityCode,
      this.countryName,
      this.cityName,
      this.stateName,
      this.isDefaultShipping,
      this.isDefaultBilling});

  CustomerAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    status = json['status'];
    updatedAt = json['updated_at'];
    fullname = json['fullname'];
    address1 = json['address1'];
    address2 = json['address2'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    defaultAddress = json['default_address'];
    deliveryInstruction = json['delivery_instruction'];
    phone1Isd = json['phone1_isd'];
    phone1 = json['phone1'];
    mobile1Isd = json['mobile1_isd'];
    mobile1 = json['mobile1'];
    zip = json['zip'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
    cityCode = json['city_code'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    isDefaultShipping = json['is_default_shipping'];
    isDefaultBilling = json['is_default_billing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['fullname'] = this.fullname;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['default_address'] = this.defaultAddress;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['phone1_isd'] = this.phone1Isd;
    data['phone1'] = this.phone1;
    data['mobile1_isd'] = this.mobile1Isd;
    data['mobile1'] = this.mobile1;
    data['zip'] = this.zip;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city_code'] = this.cityCode;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['is_default_shipping'] = this.isDefaultShipping;
    data['is_default_billing'] = this.isDefaultBilling;
    return data;
  }
}
