import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/model/get_customer_data_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';
import 'package:tmween/screens/drawer/profile/your_addresses_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'dashboard_controller.dart';
import 'drawer_controller.dart';

class MyAccountController extends GetxController {
  late BuildContext context;
  TextEditingController passwordController = TextEditingController();

  int userId = 0;
  int loginLogId = 0;
  String token = '';
  ProfileData? profileData;

  final api = Api();
  bool loading = false;

  @override
  void onInit() {
    //  if (Helper.isIndividual)
    Get.delete<WishlistController>();
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        getCustomerData(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> getCustomerData(language) async {
    loading = true;
    update();
    await api.getCustomerData(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        profileData = value.data![0];

        if (profileData!.cityName != null)
          MySharedPreferences.instance.addStringToSF(
              SharedPreferencesKeys.address,
              "${profileData!.cityName} - ${profileData!.zip}");
        MySharedPreferences.instance.addStringToSF(
            SharedPreferencesKeys.image, profileData!.largeImageUrl);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!);
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  void doLogout(language) async {
    loading = true;
    update();
    print('.......$userId....$loginLogId');
    await api.logout(token, userId, loginLogId, language).then((value) {
      loading = false;
      update();

      if (value.statusCode == 401 && value.statusCode == 200) {
        navigateToDashBoardScreen();
      } else {
        //  Helper.showGetSnackBar(value.message!);
      }
      navigateToDashBoardScreen();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  void exitScreen() {
    Get.delete<MyAccountController>();
    Navigator.of(context).pop(true);
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashBoardScreen() {
    MySharedPreferences.instance.addStringToSF(
        SharedPreferencesKeys.address,
        "");
    MySharedPreferences.instance.addStringToSF(
        SharedPreferencesKeys.image,"");
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, false);
    Get.deleteAll();
    Get.offAll(DrawerScreen());
    /*
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);*/
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void navigateToUpdateProfileScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateProfileScreen(profileData: profileData))).then((value) {
      if (value) {
        getCustomerData(Get.locale!.languageCode);
      }
    });
  }

  void navigateToAddressScreen() {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => YourAddressesScreen()))
        .then((value) {
      if (value) {
        getCustomerData(Get.locale!.languageCode);
      }
    });
  }
}
