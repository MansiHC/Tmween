import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/banner_model.dart';
import 'package:tmween/model/city_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/dashboard_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/model/get_customer_data_model.dart';
import 'package:tmween/model/login_model.dart';
import 'package:tmween/model/login_using_otp_model.dart';
import 'package:tmween/model/signup_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/model/success_model.dart';
import 'package:tmween/model/top_selection_model.dart';
import 'package:tmween/model/verify_forgot_password_otp_model.dart';
import 'package:tmween/model/verify_otp_model.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import 'app_exception.dart';

class Api {
  ///Customer
  Future<SuccessModel> register(
      name, password, email, phone, agreeTerms, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> request(
      fName, lName, password, email, phone, agreeTerms, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<LoginModel> login(email, password, uuid, deviceNo, deviceName,
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
      Helper.showGetSnackBar('No Internet connection');
    }
    return result;
  }

  Future<SignupModel> generateMobileOtp(email,  langCode) async {
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
                /*"device_uuid": uuid,
                "device_no": deviceNo,
                "device_name": deviceName,
                "device_platform": platform,
                "device_model": model,
                "device_version": version,*/
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar('No Internet connection');
    }
    return result;
  }

  Future<LoginUsingOtpModel> verifyLoginOTP(email, otp, uuid, deviceNo,
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
      Helper.showGetSnackBar('No Internet connection');
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

  Future<VerifyOtpModel> verifyOTP(phone, otp) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> resendOTP(phone) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> resendLoginOTP(phone) async {
    late SignupModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.resendLoginOTP),
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> generateForgotPasswordOTP(email, langCode) async {
    late SignupModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.generateForgotPasswordOTP),
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
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> generateMobileOTP(email, langCode) async {
    late SignupModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.generateForgotPasswordOTP),
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
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<VerifyForgotPasswordMobileOTP> verifyForgotPasswordOTP(otp, email,
      uuid, deviceNo, deviceName, platform, model, version, langCode) async {
    late VerifyForgotPasswordMobileOTP result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.verifyForgotPasswordOTP),
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
      result = VerifyForgotPasswordMobileOTP.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> resendForgotPasswordOTP(phone, langCode) async {
    late SignupModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.resendForgotPasswordOTP),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "phone": phone,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> resetPassword(email, password, langCode) async {
    late SuccessModel result;
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
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<GetCustomerDataModel> getCustomerData(token, userId, langCode) async {
    late GetCustomerDataModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getCustomerData),
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
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = GetCustomerDataModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SignupModel> generateSendOtp(token, userId, langCode) async {
    late SignupModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.generateSendOtp),
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
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

Future<SignupModel> resendMobileOtp(token, userId, langCode) async {
    late SignupModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.resendMobileOtp),
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
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }
Future<SuccessModel> verifyMobileChangePassword(token, userId, otp,password,langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.verifyMobileChangePassword),
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
          "otp":otp,
          "new_password": password,
          "confirm_password": password,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> updateEmail(token, userId,email,otp, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.updateEmail),
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
            "email": email,
            "otp": otp,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

 Future<SuccessModel> updateMobile(token, userId,phone,otp, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.updateMobile),
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
            "phone": phone,
            "otp": otp,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);

      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<GetCustomerDataModel> updateProfileMobileImage(
      token, userId, name, oldImage, image, langCode) async {
    late GetCustomerDataModel result;
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'username': token,
        HttpHeaders.authorizationHeader: "Bearer ${AppConstants.customer_token}"
      };
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse(UrlConstants.updateProfileMobile));
      request.headers.addAll(headers);
      request.fields['entity_type_id'] = AppConstants.entity_type_id_customer;
      request.fields['device_type'] = AppConstants.device_type;
      request.fields['user_id'] = userId.toString();
      request.fields['old_image'] = oldImage;
      request.fields['your_name'] = name;
      request.fields['lang_code'] = langCode;

      // request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.files.add(http.MultipartFile('image',
          File(image).readAsBytes().asStream(), File(image).lengthSync(),
          filename: image.split("/").last));
      /*request.files.add(
        http.MultipartFile.fromBytes(
            'image',
            image.readAsBytesSync(),
            filename: image.path.split("/").last
        )
    );*/
      http.StreamedResponse response = await request.send();
      var responseBytes = await response.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      print(responseString);
      var responseJson = json.decode(responseString);
      result = GetCustomerDataModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> updateProfileMobile(
      token, userId, name, oldImage, image, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.updateProfileMobile),
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
                "old_image": oldImage.split("/").last,
                "image": image != null
                    ? 'data:image/jpeg;base64,${base64Encode(image.readAsBytesSync())}'
                    : '',
                "your_name": name,
                "lang_code": langCode
              }));

      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);

    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> editProfile(
      token, userId, email, firstName, lastName, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.editProfile),
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
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<GetCustomerAddressListModel> getCustomerAddressList(
      token, userId, langCode) async {
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
                "customer_id": userId,
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
      token, id, userId, langCode) async {
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
                "customer_id": userId,
                "id": id,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<SuccessModel> editCustomerAddress(
      token,
      id,
      userId,
      fullName,
      address1,
      address2,
      landmark,
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
      print('.........$addressType');
      final response =
          await http.post(Uri.parse(UrlConstants.editCustomerAddress),
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
                "id": id,
                "customer_id": userId,
                "fullname": fullName,
                "address1": address1,
                "address2": address2,
                "landmark": landmark,
                "address_type": addressType,
                "country_code": countryCode,
                "state_code": stateCode,
                "city_code": cityCode,
                "zip": zipCode,
                "mobile1": mobile,
                "status": "1",
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

  Future<SuccessModel> addCustomerAddress(
      token,
      userId,
      fullName,
      address1,
      address2,
      landmark,
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
                "customer_id": userId,
                "fullname": fullName,
                "address1": address1,
                "address2": address2,
                "landmark": landmark,
                "address_type": addressType,
                "country_code": countryCode,
                "state_code": stateCode,
                "city_code": cityCode,
                "zip": zipCode,
                "mobile1": mobile,
                "status": "1",
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
      userId, newPassword, confirmPassword, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  ///E-Commerce
  Future<DashboardModel> getHomePageMobileData(langCode) async {
    late DashboardModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getHomePageMobileData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "lang_code": langCode,
                "pagination": "1",
                "page": "HOME"
              }));
      var responseJson = _returnResponse(response);
      result = DashboardModel.fromJson(responseJson)!;
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<DealsOfTheDayModel> getDealsOfTheDay(langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
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

  Future<SoldByTmweenModel> getSoldByTmween(langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<TopSelectionModel> getTopSelection(isTopSelection, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
    }
    return result;
  }

  Future<BannerModel> getBanner(isBestSeller, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr);
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
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
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
