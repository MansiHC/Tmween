import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';
import 'drawer_controller.dart';

class MyAccountController extends GetxController {
  late BuildContext context;
  TextEditingController passwordController = TextEditingController();

  int userId = 0;
  int loginLogId = 0;

  @override
  void onInit() {
    /*MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value!;
      });
    });*/
    super.onInit();
  }

  void doLogout() async {
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, false);
    navigateToDashBoardScreen();
    /*loading = true;
    update();
    await api
        .logout(context, 1, userId, loginLogId )
        .then((value) {
      if (value.message == AppConstants.success) {
        loading = false;
        update();
        navigateToLoginScreen();
      } else {
        Helper.showSnackBar(context, value.message!);
      }
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });*/
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashBoardScreen() {
    Get.delete<DrawerControllers>();
    Get.offAll(DrawerScreen());
    /*
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);*/
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
