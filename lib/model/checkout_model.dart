class CheckoutModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  CheckoutData? data;

  CheckoutModel({this.statusCode, this.statusMessage, this.message, this.data});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
      data =
          json['data'] != null ? new CheckoutData.fromJson(json['data']) : null;
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

class CheckoutData {
  String? paymentMethodCode;
  String? paymentUrl;
  int? checkoutStatus;
  String? orderNumber;
  int? salesOrderId;

  CheckoutData(
      {this.paymentMethodCode,
      this.paymentUrl,
      this.checkoutStatus,
      this.orderNumber,
      this.salesOrderId});

  CheckoutData.fromJson(Map<String, dynamic> json) {
    paymentMethodCode = json['payment_method_code'];
    paymentUrl = json['payment_url'];
    checkoutStatus = json['checkout_status'];
    orderNumber = json['order_number'];
    salesOrderId = json['sales_order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_code'] = this.paymentMethodCode;
    data['payment_url'] = this.paymentUrl;
    data['checkout_status'] = this.checkoutStatus;
    data['order_number'] = this.orderNumber;
    data['sales_order_id'] = this.salesOrderId;
    return data;
  }
}
