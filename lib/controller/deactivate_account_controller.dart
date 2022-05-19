import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class DeactivateAccountController extends GetxController {
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

  Future<void> deActivate(language) async {
    Helper.showLoading();
    await api
        .deactivateAccount(token, userId, passwordController.text, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addStringToSF(SharedPreferencesKeys.address, "");
        MySharedPreferences.instance
            .addStringToSF(SharedPreferencesKeys.image, "");
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
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

  void exitScreen() {
    Navigator.of(context).pop();
  }
}
