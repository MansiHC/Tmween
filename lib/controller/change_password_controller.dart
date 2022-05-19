import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ChangePasswordController extends GetxController {
  late BuildContext context;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  bool visiblePassword = true, visibleConfirmPassword = true;
  int userId = 0;
  int loginLogId = 0;
  String token = '';
  final api = Api();
  bool loading = false;
  bool otpExpired = false;
  String otpValue = "";

  void exitScreen() {
    Get.delete<ChangePasswordController>();
    Navigator.of(context).pop();
  }

  @override
  void onInit() {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        generateOtp(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> generateOtp(language) async {
    Helper.showLoading();
    await api.generateSendOtp(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        otpValue = value.data!.otp.toString();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> resendOtp(language) async {
    otpExpired = false;
    Helper.showLoading();
    await api.resendMobileOtp(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        otpValue = value.data!.otp.toString();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void navigateToDashBoardScreen() {
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, false);
    Get.deleteAll();
    Get.offAll(DrawerScreen());
    /*
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);*/
  }

  Future<void> changePassword(language) async {
    Helper.showLoading();
    await api
        .verifyMobileChangePassword(
            token, userId, otpValue, newPasswordController.text, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
        navigateToDashBoardScreen();
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    update();
  }

  void visibleConfirmPasswordIcon() {
    visibleConfirmPassword = !visibleConfirmPassword;
    update();
  }
}
