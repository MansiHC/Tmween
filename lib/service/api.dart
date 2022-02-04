import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tmween/model/success_model.dart';
import 'package:tmween/model/login_model.dart';
import 'package:tmween/model/verify_otp_model.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import 'app_exception.dart';

class Api {
  Future<SuccessModel> register(context, fName, lName, deviceType, password,
      phone, agreeTerms, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.registerUrl),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: jsonEncode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "first_name": fName,
            "last_name": lName,
            "device_type": deviceType,
            "email": phone,
            "password": password,
            "agree_terms": agreeTerms,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }

  Future<LoginModel> login(context, deviceType,  phone,
      uuid,deviceNo,deviceName,platform,model,version) async {
    late LoginModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.loginUrl),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: jsonEncode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "email": phone,
           // "password": password,
            "device_uuid": uuid,
            "device_no": deviceNo,
            "device_name": deviceName,
            "device_platform": platform,
            "device_model": model,
            "device_version": version
          }));
      var responseJson = _returnResponse(response);
      result = LoginModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }

  Future<VerifyOtpModel> verifyOTP(context, deviceType,  phone,
      otp) async {
    late VerifyOtpModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.verifyOTP),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: jsonEncode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "phone": phone,
            "otp": otp,
          }));
      var responseJson = _returnResponse(response);
      result = VerifyOtpModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }




  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
