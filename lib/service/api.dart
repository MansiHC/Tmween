import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/banner_model.dart';
import 'package:tmween/model/city_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/model/login_model.dart';
import 'package:tmween/model/login_using_otp_model.dart';
import 'package:tmween/model/reset_password_model.dart';
import 'package:tmween/model/signup_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/model/success_model.dart';
import 'package:tmween/model/top_selection_model.dart';
import 'package:tmween/model/verify_otp_model.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import 'app_exception.dart';

class Api {
  ///Customer
  Future<SuccessModel> register(
      context, name, password, email, phone, agreeTerms, langCode) async {
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
            "device_type": AppConstants.device_type,
            "email": email,
            "phone": phone,
            "password": password,
            "agree_terms": agreeTerms,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    }
    /* on Exception catch (e) {
      print('never reached ${e.toString()}');
    }*/
    on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> request(context, fName, lName, password, email, phone,
      agreeTerms, langCode) async {
    late SignupModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.request),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "your_name": fName + " " + lName,
            "device_type": AppConstants.device_type,
            "email": email,
            "phone": phone,
            "password": password,
            "agree_terms": agreeTerms,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    }
    /* on Exception catch (e) {
      print('never reached ${e.toString()}');
    }*/
    on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<LoginModel> login(context, email, password, uuid, deviceNo, deviceName,
      platform, model, version, langCode) async {
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
            "device_type": AppConstants.device_type,
            "email": email,
            "password": password,
            "device_uuid": uuid,
            "device_no": deviceNo,
            "device_name": deviceName,
            "device_platform": platform,
            "device_model": model,
            "device_version": version,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = LoginModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }

  Future<SignupModel> generateMobileOtp(context, email, uuid, deviceNo,
      deviceName, platform, model, version, langCode) async {
    late SignupModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.generateMobileOtp),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "email": email,
                "device_uuid": uuid,
                "device_no": deviceNo,
                "device_name": deviceName,
                "device_platform": platform,
                "device_model": model,
                "device_version": version,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }

  Future<LoginUsingOtpModel> verifyLoginOTP(context, email, otp, uuid, deviceNo,
      deviceName, platform, model, version, langCode) async {
    late LoginUsingOtpModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.verifyLoginOTP),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "email": email,
            "otp": otp,
            "device_uuid": uuid,
            "device_no": deviceNo,
            "device_name": deviceName,
            "device_platform": platform,
            "device_model": model,
            "device_version": version,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = LoginUsingOtpModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, 'No Internet connection');
    }
    return result;
  }

  Future<SuccessModel> logout(token, userId, loginLogId, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.logout),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "user_id": userId,
            "login_log_id": loginLogId,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<VerifyOtpModel> verifyOTP(context, phone, otp) async {
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
            "device_type": AppConstants.device_type,
            "phone": phone,
            "otp": otp,
          }));
      var responseJson = _returnResponse(response);
      result = VerifyOtpModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> resendOTP(context, phone) async {
    late SignupModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.resendOTP),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "phone": phone,
          }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> forgotPassword(context, email, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.forgotPassword),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "email": email,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<ResetPasswordModel> resetPassword(
      context, email, password, token, langCode) async {
    late ResetPasswordModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.resetPassword),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "email": email,
            "password": password,
            "token": token,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = ResetPasswordModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> editProfile(
      context, userId, email, firstName, lastName, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.editProfile),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "user_id": userId,
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<GetCustomerAddressListModel> getCustomerAddressList(
      token, userId, customerId, langCode) async {
    late GetCustomerAddressListModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getCustomerAddressList),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'username': token,
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": userId,
                "customer_id": customerId,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = GetCustomerAddressListModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> deleteCustomerAddress(
      token, id, userId, customerId, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.deleteCustomerAddress),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'username': token,
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": userId,
                "customer_id": customerId,
                "id": id,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar( LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> editCustomerAddress(
      token,
      id,
      userId,
      customerId,
      fullName,
      address1,
      address2,
      countryCode,
      stateCode,
      cityCode,
      zipCode,
      mobile,
      addressType,
      deliveryInstruction,
      isDefault,
      langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.editCustomerAddress),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": userId,
                "customer_id": customerId,
                "id": id,
                "fullname": fullName,
                "address1": address1,
                "address2": address2,
                "country_code": countryCode,
                "state_code": stateCode,
                "city_code": cityCode,
                "zip": zipCode,
                "mobile1": mobile,
                "status": "1",
                "is_default_shipping": isDefault,
                "is_default_billing": isDefault,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar( LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel>  addCustomerAddress(
      token,
      userId,
      customerId,
      fullName,
      address1,
      address2,
      countryCode,
      stateCode,
      cityCode,
      zipCode,
      mobile,
      addressType,
      deliveryInstruction,
      isDefault,
      langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.addCustomerAddress),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'username': token,
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": userId,
                "customer_id": customerId,
                "fullname": fullName,
                "address1": address1,
                "address2": address2,
                "country_code": countryCode,
                "state_code": stateCode,
                "city_code": cityCode,
                "zip": zipCode,
                "mobile1": mobile,
                "status": "1",
                "address_type": addressType,
                "delivery_instruction": deliveryInstruction,
                "default_address": isDefault,
                "is_default_shipping": 0,
                "is_default_billing": 0,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> changePassword(
      context, userId, newPassword, confirmPassword, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.addCustomerAddress),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": userId,
                "new_password": newPassword,
                "confirm_password": confirmPassword,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  ///E-Commerce
  Future<DealsOfTheDayModel> getDealsOfTheDay(context, langCode) async {
    late DealsOfTheDayModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.dealOfTheDay),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = DealsOfTheDayModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<CountryModel> getCountries(langCode) async {
    late CountryModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getMasterData),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "data-request": ["country"],
            "country_code": "IN",
          }));
      var responseJson = _returnResponse(response);
      result = CountryModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<StateModel> getStates(countryCode, langCode) async {
    late StateModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getMasterData),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "data-request": ["state"],
            "country_code": countryCode,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = StateModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<CityModel> getCity(countryCode, stateCode, langCode) async {
    late CityModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getMasterData),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "data-request": ["city"],
            "country_code": countryCode,
            "state_code": stateCode,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = CityModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SoldByTmweenModel> getSoldByTmween(context, langCode) async {
    late SoldByTmweenModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.soldByTmween),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = SoldByTmweenModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<TopSelectionModel> getTopSelection(
      context, isTopSelection, langCode) async {
    late TopSelectionModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.topSelection),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "is_top_selection": isTopSelection,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = TopSelectionModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<BannerModel> getBanner(context, isBestSeller, langCode) async {
    late BannerModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.banner),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "page": "HOME",
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = BannerModel.fromJson(responseJson);
    } on SocketException {
      Helper.showSnackBar(context, LocaleKeys.noInternet.tr);
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
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
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
