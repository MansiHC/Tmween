import 'dart:ui';

import 'package:flutter/material.dart';
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
  static Color successColor = Colors.green;
  static Color errorColor = Colors.red[400]!;
}

abstract class AppConstants {
  static const entity_type_id_customer = "4";
  static const device_type = "2";
  static const customer_token =
      "4L1YpgPnsb3M3tqt6Jhfa9H6xDw0RIUPYaQk41K8hAKWilYg41hP3P60Er7RRw8v8dCpLhiMqYa9Q2hA";
  static const success = "Success";
  static String fontFamily = 'OpenSans';
  static String productDetail = 'productDetail';
  static String forgotPassword = 'forgotPassword';
  static String bottomBar = 'bottomBar';
  static String individual = 'individual';
  static String store = 'store';
  static int timer = 30;
  static int cardsPerPage = 6;

}

abstract class UrlConstants {
  static const String baseUrl2 =
      'http://192.168.32.160/tmween/panel/public/api/v1';

  static const String baseUrl = 'http://admin.tmween.com/api/v1';

  //customer
  static const String request = '$baseUrl/customer/request';
  static const String register = '$baseUrl/customer/register';
  static const String login = '$baseUrl/customer/login';
  static const String checkAccountStatus =
      '$baseUrl/customer/check-account-status';
  static const String generateMobileOtp =
      '$baseUrl/customer/generate-mobile-otp';
  static const String generateMobileOtpLogin =
      '$baseUrl/customer/generate-mobile-otp-login';
  static const String verifyLoginOTP = '$baseUrl/customer/verify-login-otp';
  static const String logout = '$baseUrl/customer/logout';
  static const String verifyOTP = '$baseUrl/customer/verify-otp';
  static const String resendOTP = '$baseUrl/customer/resend-otp';
  static const String resendLoginOTP = '$baseUrl/customer/resend-login-otp';
  static const String resendLoginOTPLogin =
      '$baseUrl/customer/resend-login-otp-login';
  static const String generateForgotPasswordOTP =
      '$baseUrl/customer/generate-forgot-pasword-mobile-otp';
  static const String generateMobileOTP =
      '$baseUrl/customer/generate-mobile-otp';
  static const String verifyForgotPasswordOTP =
      '$baseUrl/customer/verify-mobile-forgot-password-otp';
  static const String resendForgotPasswordOTP =
      '$baseUrl/customer/resend-forgot-password-mobile-otp';
  static const String resetPassword = '$baseUrl/customer/reset-forgot-password';
  static const String editProfile = '$baseUrl/customer/edit-profile';
  static const String addDataToWishList =
      '$baseUrl/customer/add-data-to-whishlist';
  static const String deleteWishListDetails =
      '$baseUrl/customer/delete-wishlist-details';
  static const String getWishListDetails =
      '$baseUrl/customer/get-wishlist-details';
  static const String getCustomerData =
      '$baseUrl/customer/get-customer-data-mobile';
  static const String generateSendOtp = '$baseUrl/customer/generate-send-otp';
  static const String resendMobileOtp = '$baseUrl/customer/resend-mobile-otp';
  static const String verifyMobileChangePassword =
      '$baseUrl/customer/verify-mobile-change-password';
  static const String updateEmail = '$baseUrl/customer/update-email';
  static const String updateMobile = '$baseUrl/customer/update-mobile';
  static const String updateProfileMobile =
      '$baseUrl/customer/update-profile-mobile';
  static const String getCustomerAddressList =
      '$baseUrl/customer/get-customer-address-list-csc';
  static const String deleteCustomerAddress =
      '$baseUrl/customer/delete-customer-address';
  static const String editCustomerAddress =
      '$baseUrl/customer/update-customer-address-mobile';
  static const String addCustomerAddress =
      '$baseUrl/customer/add-customer-address';
  static const String getSearchHistory = '$baseUrl/customer/get-search-history';
  static const String clearSearchHistory =
      '$baseUrl/customer/clear-search-history';
  static const String updateAccountStatus =
      '$baseUrl/customer/update-account-status';
  static const String reactivateUserAccount =
      '$baseUrl/customer/reactivate-user-account';
  static const String addCustomerReview =
      '$baseUrl/customer/add-customer-review';
  static const String addToCart = '$baseUrl/customer/add-to-cart';
  static const String updateCartItem = '$baseUrl/customer/update-cart-item-quantity';
  static const String removeCartItem = '$baseUrl/customer/remove-cart-items';
  static const String getCartItems = '$baseUrl/customer/get-cart-items';
  static const String addReviewReportAbuse =
      '$baseUrl/customer/add-review-report-abuse';
  static const String addReviewHelpful = '$baseUrl/customer/add-review-helpful';

  //e-commerce
  static const String getMasterData = '$baseUrl/get-master-data';
  static const String getProductReviewsList =
      '$baseUrl/get-product-review-list-mobile';
  static const String getHomePageMobileData =
      '$baseUrl/get-home-page-mobile-data';
  static const String getMobileMasterViewData =
      '$baseUrl/get-mobile-master-view-data';
  static const String getCategoryMobileFilterData =
      '$baseUrl/get-category-mobile-filter-data';
  static const String topSearchSuggestionProductList =
      '$baseUrl/top-search-suggestion-product-list-mobile';
  static const String getProductDetailsMobile =
      '$baseUrl/get-product-details-mobile';
  static const String getItemIdByAttributeCombination =
      '$baseUrl/get-itemid-by-attribute-combination';
  static const String getProductSupplier = '$baseUrl/get-product-suppliers';
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
  static const String iIcon = 'asset/image/i_icon.svg';
  static const String worldIcon = 'asset/image/world.svg';
  static const String lock2Icon = 'asset/image/lock_2.svg';
  static const String lockIcon = 'asset/image/lock.svg';
  static const String homeIcon = 'asset/image/home.svg';
  static const String userIcon = 'asset/image/user_icon.svg';
  static const String otpIcon = 'asset/image/otp.svg';
  static const String phoneCallIcon = 'asset/image/phone_call.svg';
  static const String phoneEmailIcon = 'asset/image/phone_email.svg';
  static const String townHallIcon = 'asset/image/town_hall.svg';
  static const String emailIcon = 'asset/image/email.svg';
  static const String pinIcon = 'asset/image/pin.svg';
  static const String deliveryInstructionIcon =
      'asset/image/delivery_instruction.svg';
  static const String walletTickMarkIcon = 'asset/image/wallet_tickmark.svg';
  static const String walletCrossIcon = 'asset/image/wallet_cross.svg';
  static const String syberPay = 'asset/image/syberpay.svg';
  static const String user = 'asset/image/user.svg';
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
  static const String star1MoodIcon = 'asset/image/1_star_mood.svg';
  static const String star2MoodIcon = 'asset/image/2_star_mood.svg';
  static const String star3MoodIcon = 'asset/image/3_star_mood.svg';
  static const String star4MoodIcon = 'asset/image/4_star_mood.svg';
  static const String star5MoodIcon = 'asset/image/5_star_mood.svg';
  static const String checkIcon = 'asset/image/check.svg';
  static const String save = 'asset/image/save.svg';
  static const String delete = 'asset/image/delete.svg';
  static const String freeDelivery = 'asset/image/free_delivery.svg';
  static const String info = 'asset/image/info.svg';
  static const String creditCardIcon = 'asset/image/credit_card.svg';
  static const String internetBankingIcon = 'asset/image/internet_banking.svg';
  static const String upiIcon = 'asset/image/upi.svg';
  static const String deactivateUserIcon = 'asset/image/deactivate_user.svg';
  static const String accountSettingIcon =
      'asset/image/account_setting_icon.svg';
  static const String walletLogoIcon = 'asset/image/wallet_logo.png';
  static const String payIcon = 'asset/image/pay_icon.svg';
  static const String cashOnDelivertIcon = 'asset/image/cash_on_delivery_icon.svg';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
  static const isLogin = "isLogin";
  static const address = "address";
  static const addressFromCurrentLocation = "addressFromCurrentLocation";
  static const addressId = "addressId";
  static const image = "image";
  static const isDashboard = "isDashboard";
  static const isDrawer = "isDrawer";
  static const isSplash = "isSplash";
  static const userId = "userId";
  static const loginLogId = "loginLogId";
  static const isIndividual = "isIndividual";
  static const token = "token";
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
