import 'dart:ui';
/*

final client = Client();

final netWorkCalls = NetworkCalls();
*/

final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//final Function mathFunc = (Match match) => '${match[1]},';

String mathFunc(Match match) => '${match[1]},';

abstract class AppColors {
  static const lightGrayColor = Color(0xFFF3F3F3);
  static const primaryColor = Color(0xFF0088CA);
  static const appBarColor = Color(0xFF314156);
  static const offerGreen = Color(0xFF158D07);
  static const darkGrayBackground = Color(0xFFF6F6F6);
}

abstract class AppConstants {
  static const entity_type_id_customer = "4";
  static const customer_token =
      "FbuaPNITXrR16tRwXBAJGexrgUKtXMsKMp52CfVxnBzn9L2CUMqEOIaYgbBbrf5LrdCg8wzbDLtn14MW";
  static const isLogin = "isLogin";
  static const isSplash = "isSplash";
  static const success = "Success";
  static const userId = "userId";
  static const loginLogId = "loginLogId";
  static const language = "language";
}

abstract class UrlConstants {
  static const String baseUrl2 =
      'http://192.168.32.160/tmween/panel/public/api/v1';
  static const String baseUrl = 'http://admin.tmween.com/api/v1';

  //customer
  static const String request = '$baseUrl/customer/request';
  static const String register = '$baseUrl/customer/register';
  static const String login = '$baseUrl/customer/login';
  static const String logout = '$baseUrl/customer/logout';
  static const String verifyOTP = '$baseUrl/customer/verify-otp';
  static const String resendOTP = '$baseUrl/customer/resend-otp';

  //e-commerce
  static const String dealOfTheDay = '$baseUrl/get-dailydeal-list';
  static const String soldByTmween = '$baseUrl/get-soldby-system-product-list';
  static const String topSelection = '$baseUrl/get-top-selected-product';
  static const String bestSeller = '$baseUrl/get-best-seller-product';
  static const String banner = '$baseUrl/get-page-banner';
}

abstract class ImageConstanst {
  static const String splashBackground = 'asset/image/splash_background.jpg';
  static const String loginBackground = 'asset/image/login_bg.jpg';
  static const String logo = 'asset/image/logo.svg';
  static const String dashboardIcon = 'asset/image/dashboard_icon.png';
  static const String dealOfTheDayBg = 'asset/image/deal_of_the_day_bg.jpg';
  static const String recentlyViewedBg = 'asset/image/recently_viewed_bg.jpg';
  static const String soldByTmweenBg = 'asset/image/sold_by_tmween_bg.jpg';
  static const String topSelectionBg = 'asset/image/top_selection_bg.jpg';
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

/* Future setHomeCountry(HomeCountry country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SharedPreferencesKeys.homeCountryDetails, <String>[
      country.name,
      country.cases,
      country.deaths,
    ]);
  }
}*/
