class VerifyForgotPasswordMobileOTP {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  VerifyForgotPasswordMobileOTP(
      {this.statusCode, this.statusMessage, this.message, this.data});

  VerifyForgotPasswordMobileOTP.fromJson(Map<String, dynamic> json) {
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
  int? customerId;

  Data({this.token, this.loginLogId, this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    loginLogId = json['login_log_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['login_log_id'] = this.loginLogId;
    data['customer_id'] = this.customerId;
    return data;
  }
}