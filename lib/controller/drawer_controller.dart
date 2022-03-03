import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/address_model.dart';
import 'package:tmween/model/language_model.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/dashboard_screen.dart';
import 'package:tmween/screens/drawer/search_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';
import 'package:tmween/service/api.dart';

import '../lang/locale_keys.g.dart';
import '../screens/drawer/cart_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class DrawerControllers extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  int pageIndex = 0;
  String pageTitle = 'Home';
  late List<LanguageModel> languages;
  late LanguageModel languageValue;
  bool isLogin = true;

  List<AddressModel> addresses = const <AddressModel>[
    const AddressModel(
        name: 'Salim Akka',
        addressLine1: '34 Brooke Place,',
        addressLine2: '',
        city: 'Farmington',
        state: 'nm',
        country: 'Unites States',
        pincode: '83401',
        isDefault: true),
    const AddressModel(
      name: 'Salim Akka',
      addressLine1: '34 Brooke Place,',
      addressLine2: '',
      city: 'Farmington',
      state: 'nm',
      country: 'Unites States',
      pincode: '83401',
    )
  ];

  final pages = [
    DashboardScreen(),
    CategoriesScreen(),
    SearchScreen(),
    WishlistScreen(),
    CartScreen()
  ];

  @override
  void onInit() {
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      isLogin = value!;
      update();
    });
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isDrawer, true);
    languages = <LanguageModel>[
      LanguageModel(name: LocaleKeys.english.tr, locale: Locale('en', 'US')),
      /* LanguageModel(name: LocaleKeys.arabian.tr, locale: Locale('ar', 'DZ')),
      LanguageModel(name: LocaleKeys.spanish.tr, locale: Locale('es', 'ES')),*/
    ];
    languageValue = languages[0];
    super.onInit();
  }

  void changePage(int pageNo) {
    pageIndex = pageNo;
    update();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
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

  final api = Api();
  bool loading = false;
}
