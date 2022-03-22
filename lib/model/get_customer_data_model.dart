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
    if (statusCode == 200) {
      if (json['data'] != null) {
        data = <ProfileData>[];
        json['data'].forEach((v) {
          data!.add(new ProfileData.fromJson(v));
        });
      }
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
  int? isDefaultShipping;
  int? isDefaultBilling;
  String? yourName;
  String? phone;
  String? email;
  int? createdFrom;
  String? dob;
  String? image;
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
  String? countryName;
  String? stateName;
  String? cityName;
  String? smallImageUrl;
  String? largeImageUrl;

  ProfileData(
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
        this.isDefaultShipping,
        this.isDefaultBilling,
        this.yourName,
        this.phone,
        this.email,
        this.createdFrom,
        this.dob,
        this.image,
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
        this.countryName,
        this.stateName,
        this.cityName,
        this.smallImageUrl,
        this.largeImageUrl});

  ProfileData.fromJson(Map<String, dynamic> json) {
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
    isDefaultShipping = json['is_default_shipping'];
    isDefaultBilling = json['is_default_billing'];
    yourName = json['your_name'];
    phone = json['phone'];
    email = json['email'];
    createdFrom = json['created_from'];
    dob = json['dob'];
    image = json['image'];
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
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
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
    data['is_default_shipping'] = this.isDefaultShipping;
    data['is_default_billing'] = this.isDefaultBilling;
    data['your_name'] = this.yourName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['created_from'] = this.createdFrom;
    data['dob'] = this.dob;
    data['image'] = this.image;
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
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}
