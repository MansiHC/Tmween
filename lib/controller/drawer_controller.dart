import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/dashboard_controller.dart';
import 'package:tmween/controller/search_controller.dart';
import 'package:tmween/model/language_model.dart';
import 'package:tmween/screens/drawer/category/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/dashboard_screen.dart';
import 'package:tmween/screens/drawer/search/search_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';

import '../lang/locale_keys.g.dart';
import '../model/get_customer_address_list_model.dart';
import '../screens/drawer/cart/cart_screen.dart';
import '../screens/drawer/drawer_screen.dart';
import '../screens/drawer/profile/my_account_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class DrawerControllers extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  int pageIndex = 0;
  String pageTitle = 'Home';
  late List<LanguageModel> languages;
  late LanguageModel languageValue;
  bool isLogin = true;
  bool addressFromCurrentLocation = true;
  String image = "", address = "";

  ListQueue<int> navigationQueue = ListQueue();

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;
  bool dialogLoading = false;
  List<Address> addressList = [];

  final pages = [
    DashboardScreen(),
    CategoriesScreen(),
    /*SearchScreen(
      from: SharedPreferencesKeys.isDrawer,
    )*/
    Container(),
    WishlistScreen(),
    CartScreen(
      from: SharedPreferencesKeys.isDrawer,
    )
  ];

  @override
  void onInit() {
    Get.delete<SearchController>();
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      isLogin = value!;
      update();
      if(isLogin){
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          if (value != null) address = value;
          update();
        });
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.image)
            .then((value) async {
          image = value!;
          update();
        });
      }
    });


    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isDrawer, true);
    languages = <LanguageModel>[
      LanguageModel(name: LocaleKeys.english.tr, locale: Locale('en', 'US')),
      LanguageModel(name: LocaleKeys.arabian.tr, locale: Locale('ar', 'DZ')),
      LanguageModel(name: LocaleKeys.spanish.tr, locale: Locale('es', 'ES')),
    ];
    languageValue = languages[0];
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

  Future<void> getAddressList(language) async {
    addressList = [];
    Helper.showLoading();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        addressList = value.data!;
        Helper.hideLoading(context);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> editAddress(
      id,
      fullName,
      address1,
      address2,
      landmark,
      country,
      state,
      city,
      zip,
      mobile,
      addressType,
      deliveryInstruction,
      defaultValue,
      language) async {
    Helper.showLoading();
    await api
        .editCustomerAddress(
            token,
            id,
            userId,
            fullName,
            address1,
            address2,
            landmark,
            country,
            state,
            city,
            zip,
            mobile,
            addressType,
            deliveryInstruction,
            defaultValue,
            language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        MySharedPreferences.instance.addBoolToSF(
            SharedPreferencesKeys.addressFromCurrentLocation, false);
        Get.delete<DrawerControllers>();
        Get.delete<DashboardController>();
        Get.offAll(DrawerScreen());
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      update();
      //  Helper.showGetSnackBar(value.message!);
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void changePage(int pageNo) {
    pageIndex = pageNo;
    update();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void navigateToProfileScreen() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAccountScreen()))
        .then((value) {
      if (value) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.image)
            .then((value) async {
          image = value!;
          update();
        });
      }
    });
  }

  void navigateToSearchScreen(from) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchScreen(from: from)))
        .then((value) {
      if (value) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
      }
    });
  }

  void closeDrawer() {
    Navigator.pop(context);
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
