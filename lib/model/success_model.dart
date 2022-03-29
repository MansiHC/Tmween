class SuccessModel {
  final int? statusCode;
  final String? statusMessage;
  final String? message;

  SuccessModel({this.statusCode, this.statusMessage, this.message});

  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      message:
          json['message'].toString().replaceAll('[', '').replaceAll(']', ''),
    );
  }
}
