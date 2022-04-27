class AddToCartModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  AddToCartModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
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
  int? cartTotalItems;

  Data({this.cartTotalItems});

  Data.fromJson(Map<String, dynamic> json) {
    cartTotalItems = json['cart_total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_total_items'] = this.cartTotalItems;
    return data;
  }
}
