import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/forgot_password_controller.dart';
import 'package:tmween/controller/reset_password_controller.dart';
import 'package:tmween/screens/authentication/login/store_owner/store_owner_otp_screen.dart';
import 'package:tmween/screens/splash_screen.dart';

import '../lang/locale_keys.g.dart';
import '../screens/authentication/login/forgot_password/forgot_password_screen.dart';
import '../screens/authentication/login/individual/login_otp_screen.dart';
import '../screens/authentication/signup/signup_screen.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'forgot_otp_controller.dart';

class LoginController extends GetxController {
  String? uuid, deviceNo, deviceName, platform, model, version;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Map<String, dynamic> deviceData;
  var isSplash;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final storeOwnerFormKey = GlobalKey<FormState>();
  final storeOwnerFormKey2 = GlobalKey<FormState>();
  late BuildContext context;
  bool rememberMe = false;
  bool storeRememberMe = false;
  bool isPasswordScreen = false;
  bool isStorePasswordScreen = false;
  bool changeEmail = false;
  bool visiblePassword = true;
  bool storeVisiblePassword = true;
  TextEditingController phoneEmailController = TextEditingController();
  TextEditingController storePhoneEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController storePasswordController = TextEditingController();
  late List<Tab> tabList;
  late TabController tabController;
  int currentTabIndex = 1;

  @override
  void onInit() {
    Get.delete<ForgotOtpController>();
    Get.delete<ForgotPasswordController>();
    Get.delete<ResetPasswordController>();
    tabList = <Tab>[];
    tabList.add(new Tab(
      text: LocaleKeys.individual.tr,
    ));
    tabList.add(new Tab(
      text: LocaleKeys.storeOwner.tr,
    ));

    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isSplash)
        .then((value) async {
      isSplash = value ?? false;
    });
    initPlatformState();
    super.onInit();
  }

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        getAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        getIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  void getAndroidBuildData(AndroidDeviceInfo build) {
    uuid = build.androidId;
    deviceNo = build.id;
    deviceName = build.device;
    platform = "android";
    model = build.model;
    version = build.version.release;

    print('$uuid...$deviceNo...$deviceName...$model...$version');
    /*<String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };*/
  }

  void getIosDeviceInfo(IosDeviceInfo data) {
    uuid = "";
    deviceNo = "";
    deviceName = data.systemName;
    platform = "ios";
    model = data.model;
    version = data.utsname.version;
    /*return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };*/
  }

  void individuaLogin() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      isPasswordScreen = true;
      update();
    }
  }

  void storeLogin() {
    FocusScope.of(context).unfocus();
    isStorePasswordScreen = true;
    update();
  }

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    update();
  }

  void visibleStorePasswordIcon() {
    storeVisiblePassword = !storeVisiblePassword;
    update();
  }

  final api = Api();
  bool loading = false;
  bool storeLoading = false;

  doIndividualLoginWithPassword(language) async {
    FocusScope.of(context).unfocus();
    // navigateToDrawerScreen();
    if (formKey2.currentState!.validate()) {
      loading = true;
      update();
      await api
          .login(phoneEmailController.text, passwordController.text, uuid,
              deviceNo, deviceName, platform, model, version, language)
          .then((value) {
        if (value.statusCode == 200) {
          MySharedPreferences.instance.addIntToSF(
              SharedPreferencesKeys.loginLogId, value.data!.loginLogId);
          print('dfdfn........${value.data!.token}');
          Helper.isIndividual = true;
          MySharedPreferences.instance
              .addStringToSF(SharedPreferencesKeys.token, value.data!.token);
          MySharedPreferences.instance.addIntToSF(
              SharedPreferencesKeys.userId, value.data!.customerData!.id);
          navigateToDrawerScreen();
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
  }

  doIndividualLoginWithOtp(language, String from, String frm) async {
    FocusScope.of(context).unfocus();
    // navigateToDrawerScreen();

    update();
    loading = true;
    update();
    await api
        .generateMobileOtp(phoneEmailController.text,  language)
        .then((value) {
      if (value.statusCode == 200) {
        navigateToOTPScreen(value.data!.otp.toString(), from, frm);
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

  doLoginWithPassword(language) {
    // FocusScope.of(context).unfocus();
    Helper.isIndividual = false;
    navigateToDrawerScreen();
    //if (formKey.currentState!.validate()) {
    //doLogin(language);
    //}
  }

  void navigateToSignupScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpScreen(
                  from: currentTabIndex == 0
                      ? LocaleKeys.individual
                      : LocaleKeys.storeOwner,
                )));
  }

  void navigateToForgotPasswordScreen(String from, String frm) {
    // Get.delete<LoginController>();
    //Navigator.of(context).pop();
    var phoneEmail;
    if (from == AppConstants.individual) {
      phoneEmail = phoneEmailController.text;
    } else if (from == AppConstants.store) {
      phoneEmail = storePhoneEmailController.text;
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ForgotPasswordScreen(
                  mobile: phoneEmail,
                  from: from,
                  frm: frm,
                )));
  }

  void navigateToOTPScreen(String otp, String from, String frm) {
    // Get.delete<OtpController>();
/*
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginOtpScreen(
                phoneEmail: phoneEmailController.text.toString())));
*/

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginOtpScreen(
                  otp: otp,
                  phoneEmail: phoneEmailController.text.toString(),
                  from: from,
                  frm: frm,
                )));
  }

  void navigateToStoreOwnerOTPScreen(String from, String frm) {
    // Get.delete<StoreOtpController>();

    /* Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StoreOwnerOtpScreen(
                phoneEmail: storePhoneEmailController.text.toString())));*/
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => StoreOwnerOtpScreen(
                  phoneEmail: storePhoneEmailController.text.toString(),
                  from: from,
                  frm: frm,
                )));
  }

  void navigateToDrawerScreen() {
    Get.delete<LoginController>();

    rememberMe == true
        ? MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, true)
        : MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void exitScreen(String from, String? frm) {
    if (isPasswordScreen) {
      isPasswordScreen = false;
      update();
    } else if (isStorePasswordScreen) {
      isStorePasswordScreen = false;
      update();
    } else {
      Get.delete<LoginController>();

      if (frm == SharedPreferencesKeys.isDrawer &&
          from == AppConstants.forgotPassword) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => DrawerScreen()),
            (Route<dynamic> route) => false);
      } else if (from == SharedPreferencesKeys.isDrawer) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  void notifyCheckBox() {
    rememberMe = !rememberMe;
    update();
  }

  void notifyStoreCheckBox() {
    storeRememberMe = !storeRememberMe;
    update();
  }

/* void login() {
    // if (formKey.currentState!.validate()) {
    doLogin();
    //}
  }*/
}
