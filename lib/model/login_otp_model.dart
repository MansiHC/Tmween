class LoginOTPModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  LoginOTPModel({this.statusCode, this.statusMessage, this.message, this.data});

  LoginOTPModel.fromJson(Map<String, dynamic> json) {
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
  int? otp;
  int? loginWithPasswordFlag;

  Data({this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    loginWithPasswordFlag = json['login_with_password_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['login_with_password_flag'] = this.loginWithPasswordFlag;
    return data;
  }
}
