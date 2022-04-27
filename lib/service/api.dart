import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/UserDataModel.dart';
import 'package:tmween/model/add_to_cart_model.dart';
import 'package:tmween/model/attribute_combination_model.dart';
import 'package:tmween/model/best_seller_model.dart';
import 'package:tmween/model/city_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/dashboard_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/get_cart_products_model.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/model/get_customer_data_model.dart';
import 'package:tmween/model/get_filter_data_model.dart';
import 'package:tmween/model/get_recommended_product_model.dart';
import 'package:tmween/model/get_reviews_model.dart';
import 'package:tmween/model/get_wishlist_details_model.dart';
import 'package:tmween/model/login_otp_model.dart';
import 'package:tmween/model/popular_search_model.dart';
import 'package:tmween/model/product_detail_model.dart';
import 'package:tmween/model/product_listing_model.dart';
import 'package:tmween/model/recently_viewed_model.dart';
import 'package:tmween/model/review_order_model.dart';
import 'package:tmween/model/search_history_model.dart';
import 'package:tmween/model/signup_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/model/sub_category_product_listing_model.dart';
import 'package:tmween/model/success_model.dart';
import 'package:tmween/model/top_selection_model.dart';
import 'package:tmween/model/verify_forgot_password_otp_model.dart';
import 'package:tmween/model/verify_otp_model.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import '../model/edit_cart_quanity_model.dart';
import '../model/get_categories_model.dart';
import '../model/get_payment_option_model.dart';
import '../model/get_sub_category_model.dart';
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr, AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr, AppColors.errorColor);
    }
    return result;
  }

  Future<UserDataModel> login(email, password, uuid, deviceNo, deviceName,
      platform, model, version, langCode) async {
    late UserDataModel result;
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
      result = UserDataModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> checkAccountStatus(phone, uuid, deviceNo, deviceName,
      platform, model, version, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.checkAccountStatus),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "phone": phone,
                "device_uuid": uuid,
                "device_no": deviceNo,
                "device_name": deviceName,
                "device_platform": platform,
                "device_model": model,
                "device_version": version,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<LoginOTPModel> generateMobileOtpLogin(email, langCode) async {
    late LoginOTPModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.generateMobileOtpLogin),
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
      result = LoginOTPModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SignupModel> generateMobileOtp(
      email, userid, isMobile, langCode) async {
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
                "user_id": userid,
                "email": !isMobile ? email : "",
                "phone": isMobile ? email : "",
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<UserDataModel> verifyLoginOTP(email, otp, uuid, deviceNo, deviceName,
      platform, model, version, langCode) async {
    late UserDataModel result;
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
      result = UserDataModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SignupModel> resendLoginOTPLogin(phone) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SignupModel> resendLoginOTP(userId, phone, isMobile) async {
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
            "phone": isMobile ? phone : "",
            "email": !isMobile ? phone : "",
            "user_id": userId
          }));
      var responseJson = _returnResponse(response);
      result = SignupModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetCustomerDataModel> getCustomerData(token, userId, langCode) async {
    GetCustomerDataModel result = GetCustomerDataModel();
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> verifyMobileChangePassword(
      token, userId, otp, password, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.verifyMobileChangePassword),
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
                "otp": otp,
                "new_password": password,
                "confirm_password": password,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);

      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> updateEmail(token, userId, email, otp, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> updateMobile(token, userId, phone, otp, langCode) async {
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> setPaymentOptions(token,userId,paymentId, langCode) async {
    late SuccessModel result;
    try {
      final response =
      await http.post(Uri.parse(UrlConstants.setPaymentOption),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
            "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
            "user_id": userId,
            "payment_method_id": paymentId
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);

    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> addToRecent(userId,productId, langCode) async {
    late SuccessModel result;
    try {
      final response =
      await http.post(Uri.parse(UrlConstants.addRecentlyViewed),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
            "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
            "user_id": userId,
            "product_id": productId
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);

    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
                "old_image": oldImage != null ? oldImage.split("/").last : '',
                "image": image != null
                    ? 'data:image/jpeg;base64,${base64Encode(image.readAsBytesSync())}'
                    : '',
                "your_name": name,
                "lang_code": langCode
              }));

      var responseJson = _returnResponse(response);
      print(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> addDataToWishlist(
      token, userId, productId, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.addDataToWishList),
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
                "product_id": productId,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> changeDeliverySpeed(
      token, userId, quoteItemId,deliveryMode, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.changeDeliverySpeed),
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
                "qiid": quoteItemId,
                "delivery_mode": deliveryMode,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> addReviewHelpful(
      token, userId, productId, reviewId, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.addReviewHelpful),
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
            "product_id": productId,
            "review_id": reviewId,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> deleteWishListDetails(
      token, id, userId, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.deleteWishListDetails),
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
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetWishlistDetailsModel> getWishListDetails(
      token, userId, langCode) async {
    late GetWishlistDetailsModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getWishListDetails),
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
      result = GetWishlistDetailsModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetCartProductsModel> getCartItems(token, userId, langCode) async {
    late GetCartProductsModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getCartItems),
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
      result = GetCartProductsModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> updateQuoteAddress(token, userId,addressId, langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.updateQuoteAddress),
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
            "customer_address_id": addressId,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<ReviewOrderModel> getReviewOrder(
      token, userId, langCode) async {
    late ReviewOrderModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getReviewOrder),
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
      result = ReviewOrderModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> addCustomerReview(
      token, userId, productId, review, rating, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.addCustomerReview),
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
                "product_id": productId,
                "review_title": "test",
                "review": review,
                "rating": rating,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> deactivateAccount(
      token, userId, password, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.updateAccountStatus),
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
                "password": password,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> addReviewReportAbuse(token, userId, productId, reviewId,
      headline, description, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.addReviewReportAbuse),
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
                "product_id": productId,
                "review_id": reviewId,
                "headline": headline,
                "description": description,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> reactivateAccount(phone, otp, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.reactivateUserAccount),
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
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<AddToCartModel> addToCart(
      token,
      productId,
      productPackId,
      productItemId,
      userId,
      qty,
      customerAddressId,
      supplierId,
      supplierBranchId,
      langCode) async {
    late AddToCartModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.addToCart),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "product_id": productId,
            "product_pack_id": productPackId,
            "product_item_id": productItemId,
            "customer_id": userId,
            "user_id": userId,
            "quantity": qty,
            "customer_address_id": customerAddressId,
            "supplier_id": supplierId,
            "supplier_branch_id": supplierBranchId,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = AddToCartModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<EditCartQuantityModel> editCartItem(
      token,
      quoteItemId,
      quoteId,
      userId,
      qty,
      langCode) async {
    late EditCartQuantityModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.updateCartItem),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "quote_item_id": quoteItemId,
            "quote_id": quoteId,
            "user_id": userId,
            "item_quantity": qty,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = EditCartQuantityModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> removeCartItem(
      token,
      quoteId,
      userId,
      quoteItemId,
      langCode) async {
    late SuccessModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.removeCartItem),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "quote_item_id": quoteItemId,
            "quote_id": quoteId,
            "user_id": userId,
            "lang_code": langCode
          }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  ///E-Commerce
  Future<GetReviewsModel> getProductReviewsList(productId, langCode) async {
    late GetReviewsModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getProductReviewsList),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "product_id": productId,
                "lang_code": langCode
              }));
      var responseJson = _returnResponse(response);
      result = GetReviewsModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
          }));
      var responseJson = _returnResponse(response);
      result = CountryModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<DashboardModel> getHomePageMobileData(userId,language) async {
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
                "lang_code": language,
                "customer_id": userId,
                "pagination": "1",
                "page": "MOBILE-HOME"
              }));
      var responseJson = _returnResponse(response);
      result = DashboardModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

/*1. product_category
2. product_all_category
3. popular_searches
4. daily_deals_data
5. sold_by_tmween_product_data
6. best_seller_data
7. top_selection_data
8. shop_by_top_category
9. recently_view_product
*/
  Future<SearchHistoryModel> getSearchHistory(token, userId, langCode) async {
    late SearchHistoryModel result;
    try {
      final response = await http.post(Uri.parse(UrlConstants.getSearchHistory),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'username': token,
            HttpHeaders.authorizationHeader:
                " Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "user_id": userId,
            "user_search_keyword_id": userId,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = SearchHistoryModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SuccessModel> clearSearchHistory(token, userId, langCode) async {
    late SuccessModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.clearSearchHistory),
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
                "lang_code": langCode,
              }));
      var responseJson = _returnResponse(response);
      result = SuccessModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<PopularSearchModel> getPopularSearch(langCode) async {
    late PopularSearchModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["popular_searches"],
                "lang_code": langCode,
              }));
      var responseJson = _returnResponse(response);
      result = PopularSearchModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<ProductListingModel> topSearchSuggestionProductList(
      page, searchText, userId, isLogin, langCode) async {
    late ProductListingModel result;
    try {
      final response = await http.post(
          Uri.parse(UrlConstants.topSearchSuggestionProductList),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "search_text": searchText,
            "user_id": isLogin ? userId : 0,
            "lang_code": langCode,
            "pagination": "1",
            "page": page
          }));
      var responseJson = _returnResponse(response);
      result = ProductListingModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SubCategoryProductListingModel> categoryProductList(
      page, categorySlug,categoryId, langCode) async {
    late SubCategoryProductListingModel result;
    try {
      final response = await http.post(
          Uri.parse(UrlConstants.categoryProductList),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
            "search_arr": {
              "slug_name":categorySlug,
              "product_category_id": [categoryId],
            },
            "pagination": "1",
            "page": page,
            "records_per_page": "10",
            "sort_by": "product_name",
            "sort_order": "desc",
          }));
      var responseJson = _returnResponse(response);
      result = SubCategoryProductListingModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<ProductDetailModel> getProductDetailsMobile(
      slug, isLogin, userId, langCode) async {
    late ProductDetailModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getProductDetailsMobile),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "user_id": isLogin ? userId : 0,
                "slug": slug,
                "lang_code": langCode,
              }));
      var responseJson = _returnResponse(response);
      result = ProductDetailModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  /*{
 "entity_type_id": {{entity_type_id}},
 "device_type": {{device_type}},
 "product_pack_id":"283",
 "product_id":"244",
 "attribute_data": {
    "attribute_type": ["Color","Size"],
    "attribute_value":["Black","Small"]
 }
}*/

  Future<AttributeCombinationModel> getItemIdByAttributeCombination(
      productPackId, productId, attributeData, langCode) async {
    late AttributeCombinationModel result;
    try {
      final response = await http.post(
          Uri.parse(UrlConstants.getItemIdByAttributeCombination),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
                "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "product_pack_id": productPackId,
            "product_id": productId,
            "attribute_data": attributeData,
            "lang_code": langCode,
          }));
      var responseJson = _returnResponse(response);
      result = AttributeCombinationModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<AttributeCombinationModel> getProductSupplier(
      productPackId, productId, langCode) async {
    late AttributeCombinationModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getProductSupplier),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "product_pack_id": productPackId,
                "product_id": productId,
                "lang_code": langCode,
              }));
      var responseJson = _returnResponse(response);
      result = AttributeCombinationModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetFilterDataModel> getCategoryMobileFilterData(
      catSlug,  langCode) async {
    late GetFilterDataModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getCategoryMobileFilterData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "lang_code": langCode,
                "pagination": 0,
                "page": 1,
                "category_slug": catSlug,
              }));
      var responseJson = _returnResponse(response);
      result = GetFilterDataModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SubCategoryProductListingModel> setCategoryMobileFilterData(
      page,catSlug,catList,brandList,sellerList,fromPrice,toPrice,  langCode) async {
    late SubCategoryProductListingModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.categoryProductList),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "lang_code": langCode,
                "pagination": 1,
                "page": page,
                "category_slug": catSlug,
                "records_per_page": "10",
                "sort_by": "product_name",
                "sort_order": "desc",
                "search_arr": {
                    "category_id":"",
                    "product_category_id": catList,
                    "brand_id": brandList,
                    "supplier_id":sellerList,
                    "slug_name":catSlug,
                    "keyword": "",
                    "price_from": fromPrice,
                    "price_to":toPrice
                  },

              }));
      var responseJson = _returnResponse(response);
      result = SubCategoryProductListingModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }


  Future<GetCategoriesModel> getAllCategories(page, langCode) async {
    late GetCategoriesModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["shop_by_top_category"],
                "lang_code": langCode,
                "pagination": "1",
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = GetCategoriesModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetSubCategoryModel> getSubCategories(categoryId, langCode) async {
    late GetSubCategoryModel result;
    try {
      final response =
      await http.post(Uri.parse(UrlConstants.getSubCategoriesData),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
            "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
            "category_id": categoryId
          }));
      var responseJson = _returnResponse(response);
      result = GetSubCategoryModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }


  Future<DealsOfTheDayModel> getDealsOfTheDay(page, langCode) async {
    late DealsOfTheDayModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["daily_deals_data"],
                "lang_code": langCode,
                "pagination": "1",
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = DealsOfTheDayModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<BestSellerModel> getBestSeller(page, langCode) async {
    late BestSellerModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["best_seller_data"],
                "lang_code": langCode,
                "pagination": "1",
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = BestSellerModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetRecommendedProductModel> getRecommendedProduct(productId,page, langCode) async {
    late GetRecommendedProductModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getRecommendedProduct),
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
                "page": page,
                "product_id": productId,
                "records_per_page": 10
              }));
      var responseJson = _returnResponse(response);
      result = GetRecommendedProductModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<SoldByTmweenModel> getSoldByTmween(page, langCode) async {
    late SoldByTmweenModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["sold_by_tmween_product_data"],
                "lang_code": langCode,
                "pagination": "1",
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = SoldByTmweenModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<GetPaymentOptionModel> getPaymentOptions(userId, langCode) async {
    late GetPaymentOptionModel result;
    try {
      final response =
      await http.post(Uri.parse(UrlConstants.getPaymentOptions),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader:
            "Bearer ${AppConstants.customer_token}"
          },
          body: json.encode({
            "entity_type_id": AppConstants.entity_type_id_customer,
            "device_type": AppConstants.device_type,
            "lang_code": langCode,
            "user_id": userId
          }));
      var responseJson = _returnResponse(response);
      result = GetPaymentOptionModel.fromJson(responseJson);
     /* for(Map<String,dynamic> i in responseJson){
        result.add(GetPaymentOptionModel.fromJson(i));
      }*/
      } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }



  Future<TopSelectionModel> getTopSelection(page, langCode) async {
    late TopSelectionModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["top_selection_data"],
                "lang_code": langCode,
                "pagination": "1",
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = TopSelectionModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
    }
    return result;
  }

  Future<RecentlyViewedModel> getRecentlyViewed(userId,page, langCode) async {
    late RecentlyViewedModel result;
    try {
      final response =
          await http.post(Uri.parse(UrlConstants.getMobileMasterViewData),
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                HttpHeaders.authorizationHeader:
                    "Bearer ${AppConstants.customer_token}"
              },
              body: json.encode({
                "entity_type_id": AppConstants.entity_type_id_customer,
                "device_type": AppConstants.device_type,
                "data-request": ["recently_view_product"],
                "lang_code": langCode,
                "pagination": "1",
                "customer_id": userId,
                "records_per_page": 10,
                "page": page
              }));
      var responseJson = _returnResponse(response);
      result = RecentlyViewedModel.fromJson(responseJson);
    } on SocketException {
      Helper.showGetSnackBar(LocaleKeys.noInternet.tr,  AppColors.errorColor);
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
      case 406:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 422:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 426:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 413:
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
