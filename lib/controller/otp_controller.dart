import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class OtpController extends GetxController {
  late BuildContext context;

  TextEditingController otpController = TextEditingController();
  String currentText = "";
  final api = Api();
  bool loading = false;
  late String phone, otp;

  verifyOTP(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    otp = otpController.text;

    navigateToDrawerScreen();
    /*
    loading = true;
    update();
    await api.verifyOTP(context, 1, phone, otp).then((value) {
      loading = false;
      update();
      Helper.showSnackBar(context, value.status_message!);
      if(value.message==AppConstants.success) {
      doRegister( name, email, phone, password,deviceType,langCode,agreeTerms);
      }
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });*/
  }

  verifyLoginOTP() {
    FocusScope.of(context).nextFocus();
    otp = otpController.text;
    navigateToDrawerScreen();
  }

  doRegister(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    loading = true;
    update();
    await api
        .register(context, name, deviceType, password, email, phone, agreeTerms,
            langCode)
        .then((value) {
      loading = false;
      update();
      print('value....${value.toString()}');
      Helper.showSnackBar(context, value.message!);
      /* if(value.message==AppConstants.success) {
        navigateToOtpScreen();
      }*/
      navigateToDrawerScreen();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  resendOTP() async {
    /* loading = true;
    update();

    await api.resendOTP(context, "1", phone).then((value) {
      loading = false;
      update();
      Helper.showSnackBar(context, value.status_message!);
      if (value.message == AppConstants.success) {}
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });*/
  }

  void navigateToDrawerScreen() {
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void exitScreen() {
    Navigator.of(context).pop(false);
  }

  void navigateToLoginScreen(String from, String frm) {
    Get.delete<OtpController>();
    if (from == AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                from: frm,
                isPassword: false,
                isStorePassword: false,
              )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(
                    from: frm,
                    isPassword: true,
                    isStorePassword: true,
                  )));
    }
  }

  void navigateToLoginEmailScreen(String from, String frm,bool isPassword,bool isStorePassword) {
    Get.delete<OtpController>();
    if (from == AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                from: frm,
                isPassword: false,
                isStorePassword: isStorePassword,
              )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                from: frm,
                isPassword: isPassword,
                isStorePassword: false,
              )));
    }
  }
  }
