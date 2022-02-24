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
  static const lighterGrayColor = Color(0xFFF2F2F2);
  static const back = Color(0xFFF2F2F2);
  static const primaryColor = Color(0xFF0088CA);
  static const appBarColor = Color(0xFF314156);
  static const offerGreen = Color(0xFF158D07);
  static const darkGrayBackground = Color(0xFFF7F7F7);
  static const lightBlueBackground = Color(0xFFDCF4FF);
  static const lightBlue = Color(0xFFABD9E4);
  static const blue = Color(0xFF5BABD0);
  static const darkblue = Color(0xFF369ED2);
}

abstract class AppConstants {
  static const entity_type_id_customer = "4";
  static const customer_token =
      "FbuaPNITXrR16tRwXBAJGexrgUKtXMsKMp52CfVxnBzn9L2CUMqEOIaYgbBbrf5LrdCg8wzbDLtn14MW";
  static const success = "Success";
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
  static const String deliveryOnTmweenIcon =
      'asset/image/delivery_on_tmween_icon.svg';
  static const String sellingOnTmweenIcon =
      'asset/image/selling_on_tmween_icon.svg';
  static const String soldByTmweenIcon = 'asset/image/sold_by_tmween_icon.svg';
  static const String dealsOfTheDayIcon =
      'asset/image/deals_of_the_day_icon.svg';
  static const String shopByCategoryIcon =
      'asset/image/shop_by_category_icon.svg';
  static const String customerServiceIcon =
      'asset/image/customer_service_icon.svg';
  static const String indiaFlagIcon = 'asset/image/india_flag_icon.svg';
  static const String sudanFlagIcon = 'asset/image/sudan_flag_icon.svg';
  static const String warranty = 'asset/image/warranty.svg';
  static const String original = 'asset/image/original.svg';
  static const String like = 'asset/image/like.svg';
  static const String likeFill = 'asset/image/like_fill.svg';
  static const String share = 'asset/image/share.svg';
  static const String secure = 'asset/image/secure.svg';
  static const String protected = 'asset/image/protected.svg';
  static const String usFlagIcon = 'asset/image/us_flag_icon.svg';
  static const String spainFlagIcon = 'asset/image/spain_flag_icon.svg';
  static const String yourWalletIcon = 'asset/image/your_wallet_icon.svg';
  static const String yourOrdersIcon = 'asset/image/your_orders_icon.svg';
  static const String yourAddressesIcon = 'asset/image/your_address_icon.svg';
  static const String wishlistIcon = 'asset/image/wishlist_icon.svg';
  static const String logoutIcon = 'asset/image/logout_icon.svg';
  static const String locationPinIcon = 'asset/image/location_pin_icon.svg';
  static const String notificationsIcon = 'asset/image/notifications_icon.svg';
  static const String wishListssIcon = 'asset/image/wish_lists_icon.svg';
  static const String shoppingCartIcon = 'asset/image/shopping_cart_icon.svg';
  static const String filterIcon = 'asset/image/filter_icon.svg';
  static const String bestMatchIcon = 'asset/image/best_match_icon.svg';
  static const String minusIcon = 'asset/image/minus.svg';
  static const String plusIcon = 'asset/image/plus.svg';
  static const String checkIcon = 'asset/image/check.svg';
  static const String accountSettingIcon =
      'asset/image/account_setting_icon.svg';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
  static const isLogin = "isLogin";
  static const isSplash = "isSplash";
  static const userId = "userId";
  static const loginLogId = "loginLogId";
  static const language = "language";
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
