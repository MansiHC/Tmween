import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/language_model.dart';

import '../lang/locale_keys.g.dart';
import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class SplashController extends GetxController {
  late BuildContext context;
  late List<LanguageModel> languages;
  late LanguageModel languageValue;

  @override
  void onInit() {
    languages = <LanguageModel>[
      LanguageModel(name: LocaleKeys.english.tr, locale: Locale('en', 'US')),
      /*LanguageModel(name: LocaleKeys.arabian.tr, locale: Locale('ar', 'DZ')),
      LanguageModel(name: LocaleKeys.spanish.tr, locale: Locale('es', 'ES')),*/
    ];
    languageValue = languages[0];
    super.onInit();
  }

  void navigateToLogin() {
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isSplash, true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen(from: SharedPreferencesKeys.isSplash,)),
            (Route<dynamic> route) => false);

  }

}
