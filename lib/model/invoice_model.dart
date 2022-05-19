class InvoiceModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  String? data;

  InvoiceModel({this.statusCode, this.statusMessage, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200) data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
