class GetCustomerAddressListModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  List<Address>? data;

  GetCustomerAddressListModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetCustomerAddressListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200) {
      if (json['data'] != null) {
        data = <Address>[];
        json['data'].forEach((v) {
          data!.add(new Address.fromJson(v));
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

class Address {
  int? id;
  int? customerId;
  String? createdAt;
  int? status;
  String? updatedAt;
  String? fullname;
  String? firstName;
  String? lastName;
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
  String? countryName;
  String? stateName;
  String? cityName;

  Address(
      {this.id,
      this.customerId,
      this.createdAt,
      this.status,
      this.updatedAt,
      this.fullname,
      this.firstName,
      this.lastName,
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
      this.countryName,
      this.stateName,
      this.cityName});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    status = json['status'];
    updatedAt = json['updated_at'];
    fullname = json['fullname'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['fullname'] = this.fullname;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    return data;
  }
}
