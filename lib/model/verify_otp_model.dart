class VerifyOtpModel {
  final int? status_code;
  final String? status_message;
  final String? message;

  VerifyOtpModel({this.status_code,  this.status_message,  this.message});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      status_code: json['status_code'],
      status_message: json['status_message'],
      message: json['message'] ?? "",
    );
  }
}