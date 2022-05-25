import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/model/get_customer_data_model.dart';
import 'package:tmween/model/user_local_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/address/your_addresses_screen.dart';
import 'package:tmween/screens/drawer/profile/updateProfile/update_profile_screen.dart';

import '../database/db_helper.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

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

  Future<void> fetchEmployeesFromDatabase() async {
    var dbHelper = DBHelper();

    await dbHelper.getuserLocalModels().then((value) {
      profileData = ProfileData(
          id: int.parse(value[0].id!),
          fullname: value[0].fullname,
          countryName: value[0].countryName,
          stateName: value[0].stateName,
          cityName: value[0].cityName,
          largeImageUrl: value[0].largeImageUrl,
          mobile1: value[0].mobile1,
          zip: value[0].zip,
          phone: value[0].phone,
          email: value[0].email,
          yourName: value[0].yourName,
          image: value[0].image);

      return profileData;
    });
  }

  Future<void> getCustomerData(language) async {
    /* loading = true;
    update();*/
    Helper.showLoading();
    await api.getCustomerData(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        profileData = value.data![0];
        Helper.hideLoading(context);
        var dbHelper = DBHelper();
        dbHelper.saveUser(UserLocalModel(
            id: profileData!.id.toString(),
            fullname: profileData!.fullname,
            mobile1: profileData!.mobile1,
            zip: profileData!.zip,
            yourName: profileData!.yourName,
            phone: profileData!.phone,
            email: profileData!.email,
            image: profileData!.image,
            countryName: profileData!.countryName,
            stateName: profileData!.stateName,
            cityName: profileData!.cityName,
            largeImageUrl: profileData!.largeImageUrl));
        if (profileData!.cityName != null) {
          MySharedPreferences.instance.addStringToSF(
              SharedPreferencesKeys.address,
              "${profileData!.cityName} - ${profileData!.zip}");
          MySharedPreferences.instance.addStringToSF(
              SharedPreferencesKeys.addressId, profileData!.id.toString());
        } else {
          MySharedPreferences.instance
              .addStringToSF(SharedPreferencesKeys.address, "");
          MySharedPreferences.instance
              .addStringToSF(SharedPreferencesKeys.addressId, 0);
        }
        MySharedPreferences.instance.addStringToSF(
            SharedPreferencesKeys.image, profileData!.largeImageUrl);
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
      fetchEmployeesFromDatabase().then((value) => update());
      //update();
      print('error....$error');
    });
  }

  void doLogout(language) async {
    Helper.showLoading();
    print('.......$userId....$loginLogId');
    await api.logout(token, userId, loginLogId, language).then((value) {
      Helper.hideLoading(context);
      update();

      if (value.statusCode == 401 && value.statusCode == 200) {
        navigateToDashBoardScreen();
      } else {
        //  Helper.showGetSnackBar(value.message!);
      }
      navigateToDashBoardScreen();
    }).catchError((error) {
      Helper.hideLoading(context);
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
    MySharedPreferences.instance
        .addStringToSF(SharedPreferencesKeys.address, "");
    MySharedPreferences.instance
        .addStringToSF(SharedPreferencesKeys.addressId, "");
    MySharedPreferences.instance.addStringToSF(SharedPreferencesKeys.image, "");
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
