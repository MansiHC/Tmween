import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'drawer_controller.dart';

class MyAccountController extends GetxController {
  late BuildContext context;
  TextEditingController passwordController = TextEditingController();


  int userId = 0;
  int loginLogId = 0;
  String token = '';

  final api = Api();
  bool loading = false;
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
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  void doLogout(language) async {

    loading = true;
    update();
    await api
        .logout(token, userId,loginLogId,
        language)
        .then((value) {
      loading = false;
      update();
      Helper.showGetSnackBar( value.message!);
      MySharedPreferences.instance
          .addBoolToSF(SharedPreferencesKeys.isLogin, false);
      navigateToDashBoardScreen();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });


  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashBoardScreen() {
    Get.delete<MyAccountController>();
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
