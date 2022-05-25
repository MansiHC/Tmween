class AddWalletModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  AddWalletData? data;

  AddWalletModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  AddWalletModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if(statusCode==200)
    data = json['data'] != null ? new AddWalletData.fromJson(json['data']) : null;
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

class AddWalletData {
  String? paymentMethodCode;
  String? paymentUrl;
  int? walletStatus;
  int? salesOrderId;

  AddWalletData({this.paymentMethodCode, this.paymentUrl, this.walletStatus});

  AddWalletData.fromJson(Map<String, dynamic> json) {
    paymentMethodCode = json['payment_method_code'];
    paymentUrl = json['payment_url'];
    walletStatus = json['wallet_status'];
    salesOrderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_code'] = this.paymentMethodCode;
    data['payment_url'] = this.paymentUrl;
    data['wallet_status'] = this.walletStatus;
    data['order_id'] = this.salesOrderId;
    return data;
  }
}
