class GetPaymentOptionModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  GetPaymentOptionModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetPaymentOptionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
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
  List<PaymentMethod>? paymentMethod;

  Data({this.paymentMethod});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(new PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethod {
  int? id;
  String? methodName;
  String? methodCode;
  String? image;
  String? smallImageUrl;

  PaymentMethod(
      {this.id,
      this.methodName,
      this.methodCode,
      this.image,
      this.smallImageUrl});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodName = json['method_name'];
    methodCode = json['method_code'];
    image = json['image'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_name'] = this.methodName;
    data['method_code'] = this.methodCode;
    data['image'] = this.image;
    data['small_image_url'] = this.smallImageUrl;
    return data;
  }
}
