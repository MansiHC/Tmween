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

class StoreOtpController extends GetxController {
  late BuildContext context;

  TextEditingController otpController = TextEditingController();
  String currentText = "";
  final api = Api();
  bool loading = false;
  bool otpExpired = false;
  late String phone, otp;

  verifyOTP(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    otp = otpController.text;

    navigateToDrawerScreen();
    /*
   Helper.showLoading();
    await api.verifyOTP(context, 1, phone, otp).then((value) {
     Helper.hideLoading();
      update();
      Helper.showSnackBar(context, value.status_message!);
      if(value.message== AppColors.success) {
      doRegister( name, email, phone, password,deviceType,langCode,agreeTerms);
      }
    }).catchError((error) {
    Helper.hideLoading();
      update();
      print('error....$error');
    });*/
  }

  verifyLoginOTP() {
    FocusScope.of(context).nextFocus();
    otp = otpController.text;
    Helper.isIndividual = false;
    navigateToDrawerScreen();
  }

  doRegister(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    Helper.showLoading();
    await api
        .register(name, password, email, phone, agreeTerms, langCode)
        .then((value) {
      Helper.hideLoading(context);
      update();
      print('value....${value.toString()}');
      if (value.statusCode == 200) {
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      /* if(value.message== AppColors.success) {
        navigateToOtpScreen();
      }*/
      navigateToDrawerScreen();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  resendOTP() async {
    otpExpired = false;
    /* Helper.showLoading();

    await api.resendOTP(context, "1", phone).then((value) {
     Helper.hideLoading();
      update();
      Helper.showSnackBar(context, value.status_message!);
      if (value.message ==  AppColors.success) {}
    }).catchError((error) {
     Helper.hideLoading();
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

  void navigateToLoginScreen(
      String from, String frm, bool isPassword, bool isStorePassword) {
    otpController.clear();
    if (from == AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.individual,
                    isPassword: true,
                    isStorePassword: isStorePassword,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.store,
                    isPassword: isPassword,
                    isStorePassword: true,
                  )));
    }
  }

  void navigateToLoginEmailScreen(
      String from, String frm, bool isPassword, bool isStorePassword) {
    otpController.clear();
    if (from == AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.individual,
                    isPassword: false,
                    isStorePassword: isStorePassword,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.store,
                    isPassword: isPassword,
                    isStorePassword: false,
                  )));
    }
  }
}
