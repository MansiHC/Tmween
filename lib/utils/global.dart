import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
/*

final client = Client();

final netWorkCalls = NetworkCalls();
*/

final mySharedPreferences = MySharedPreferences();

final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//final Function mathFunc = (Match match) => '${match[1]},';

String mathFunc(Match match) => '${match[1]},';

abstract class AppColors {
  static const lightGrayColor = Color(0xFFF3F3F3);
  static const primaryColor = Color(0xFF0088CA);
}

abstract class AppConstants{
  static const entity_type_id_customer = 4;
  static const customer_token = "FbuaPNITXrR16tRwXBAJGexrgUKtXMsKMp52CfVxnBzn9L2CUMqEOIaYgbBbrf5LrdCg8wzbDLtn14MW";
}

abstract class UrlConstants {
  static const String baseUrl = 'http://192.168.32.160/tmween/panel/public/api/v1/customer';
  static const String registerUrl = '$baseUrl/register';
  static const String loginUrl = '$baseUrl/login';
  static const String verifyOTP = '$baseUrl/verify-otp';
}

abstract class ImageConstanst {
  static const String splashBackground = 'asset/image/splash_background.jpg';
  static const String loginBackground = 'asset/image/login_bg.jpg';
  static const String logo = 'asset/image/logo.svg';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}

abstract class LanguageConstant {
  static String selectedLanguage = 'en';
  static String sel_Language = 'English';
  static const String arabian = "Arabian";
  static const String english = "English";
}

class MySharedPreferences {
  Future<List<String>?> fetchHomeCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(SharedPreferencesKeys.homeCountryDetails);
    return list;
  }

/* Future setHomeCountry(HomeCountry country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SharedPreferencesKeys.homeCountryDetails, <String>[
      country.name,
      country.cases,
      country.deaths,
    ]);
  }*/
}
