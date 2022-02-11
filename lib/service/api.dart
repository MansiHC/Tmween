import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/model/banner_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/login_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/success_model.dart';
import 'package:tmween/model/top_selection_model.dart';
import 'package:tmween/model/verify_otp_model.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import 'app_exception.dart';

class Api {
  Future<SuccessModel> register(context, name, deviceType, password, email,
      phone, agreeTerms, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.register),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "your_name": name,
            "device_type": deviceType,
            "email": email,
            "phone": phone,
            "password": password,
            "agree_terms": agreeTerms,
            "lang_code": langCode,
            "date": "20",
            "month": "06",
            "year": "1995",
            "gender": "1",
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    }
    /* on Exception catch (e) {
      print('never reached ${e.toString()}');
    }*/
    on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<SuccessModel> request(context, fName, lName, deviceType, password,
      email, phone, agreeTerms, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.request),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "your_name": "fName" + " " + "lName",
            "device_type": deviceType,
            "email": "eail@g.j",
            "phone": "5167893215",
            "password": "Ab!1547822",
            "agree_terms": "1",
            "lang_code": langCode,
            "birth_date": "2021-12-27",
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    }
    /* on Exception catch (e) {
      print('never reached ${e.toString()}');
    }*/
    on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<LoginModel> login(context, deviceType, phone, uuid, deviceNo,
      deviceName, platform, model, version) async {
    late LoginModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.login),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "email": "8947047044",
            "password": "Test@123",
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

  Future<SuccessModel> logout(context, deviceType, userId, loginLogId) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.logout),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "user_id": userId,
            "password": loginLogId,
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<VerifyOtpModel> verifyOTP(context, deviceType, phone, otp) async {
    late VerifyOtpModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.verifyOTP),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "phone": phone,
            "otp": otp,
          }));
      var responseJson = _returnResponse(response);
      result = VerifyOtpModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<VerifyOtpModel> resendOTP(context, deviceType, phone) async {
    late VerifyOtpModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.resendOTP),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "phone": phone,
          }));
      var responseJson = _returnResponse(response);
      result = VerifyOtpModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<DealsOfTheDayModel> getDealsOfTheDay(
      context, deviceType, langCode) async {
    late DealsOfTheDayModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.dealOfTheDay),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = DealsOfTheDayModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<SoldByTmweenModel> getSoldByTmween(
      context, deviceType, langCode) async {
    late SoldByTmweenModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.soldByTmween),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = SoldByTmweenModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<TopSelectionModel> getTopSelection(
      context, deviceType, isTopSelection, langCode) async {
    late TopSelectionModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.topSelection),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "is_top_selection": isTopSelection,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = TopSelectionModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
    }
    return result;
  }

  Future<BannerModel> getBanner(
      context, deviceType, isBestSeller, langCode) async {
    late BannerModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.banner),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: AppConstants.customer_token
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": deviceType,
            "page": "HOME",
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = BannerModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr());
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
      case 422:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  /* Future<List<Article>> fetchData() async {
    var responses = await Future.wait([
      http.get(firstUrl),
      http.get(secondUrl),
    ]);
    return <Article>[
      ..._getArticlesFromResponse(responses[0]),
      ..._getArticlesFromResponse(responses[1]),
    ];
  }

  List<Article> _getArticlesFromResponse(http.Response response) {
    return [
      if (response.statusCode == 200)
        for (var i in json.decode(response.body)['items'])
          Article.fromJson(i),
    ];
  }*/
  Future<void> apiFetch() async {
    var status = true;
    await Future.wait([f1(), f2()]).then((v) {
      for (var item in v) {
        print('$item \n');
      }
    }).whenComplete(() {
      status = false;
    });
    print(status == true ? 'Loading' : 'FINISHED');
  }

  Future f1() async {
    print("f1 function is runnion now");
    Future.delayed(Duration(seconds: 8));
    print("f1 function finished processing");
    return 1;
  }

  Future f2() async {
    print("f2 function is runnion now");
    Future.delayed(Duration(seconds: 3));
    print("f2 function finished processing");
    return 2;
  }
}
