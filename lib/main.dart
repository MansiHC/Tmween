import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/splash_screen.dart';
import 'package:tmween/theme.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/my_shared_preferences.dart';

import 'lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  ThemeData theme = lightTheme;
  var isLogin = false;
  var isSplash = false;
  var isDrawer = false;
  var language = 'en_US';

  MySharedPreferences.instance
      .getStringValuesSF(SharedPreferencesKeys.language)
      .then((value) async {
    language = value ?? 'en_US';
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isSplash)
        .then((value) async {
      isSplash = value ?? false;
      MySharedPreferences.instance
          .getBoolValuesSF(SharedPreferencesKeys.isLogin)
          .then((value) async {
        isLogin = value ?? false;
        MySharedPreferences.instance
            .getBoolValuesSF(SharedPreferencesKeys.isDrawer)
            .then((value) async {
          isDrawer = value ?? false;
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
              .then((_) {
            runApp(
              MyApp(
                isLogin: isLogin,
                isSplash: isSplash,
                isDrawer: isDrawer,
                language: language,
              ),
            );
          });
        });
      });
    });
  });
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final bool isSplash;
  final bool isDrawer;
  final String language;

  MyApp(
      {Key? key,
      required this.isLogin,
      required this.isSplash,
      required this.isDrawer,
      required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var languageCode = language.split('_')[0];
    String deviceLanguageCode = Platform.localeName.split('_')[0];
    Locale currentLocale = Locale('en', 'US');
    if (languageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (languageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (languageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }
    /*if (deviceLanguageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (deviceLanguageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (deviceLanguageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }*/


    return GetMaterialApp(
      translations: TranslationService(),
      locale: currentLocale,
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.appTitle,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryColor,
          brightness: Brightness.light,
          backgroundColor: const Color(0xFFE5E5E5),
          accentColor: Colors.black,
          accentIconTheme: IconThemeData(color: Colors.white),
          dividerColor: Colors.white54,
          fontFamily: AppConstants.fontFamily),
      home: isDrawer
          ? DrawerScreen()
          : isLogin
              ? DrawerScreen()
              : SplashScreen(),
    );
  }
}
