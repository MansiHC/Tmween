import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/login_controller.dart';
import 'package:tmween/controller/signup_controller.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class OtpController extends GetxController {
  late BuildContext context;
  String comingSms = 'Unknown';

  String? uuid, deviceNo, deviceName, platform, model, version;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Map<String, dynamic> deviceData;
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  final api = Api();
  bool loading = false;
  bool otpExpired = false;
  late String phone, otp, otpValue;

  verifyOTP() async {
    otp = otpController.text;

    //    navigateToDrawerScreen();
    Helper.showLoading();
    await api.verifyOTP(phone, otp).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        Get.delete<SignUpController>();
        Get.delete<OtpController>();
        MySharedPreferences.instance.addIntToSF(
            SharedPreferencesKeys.userId, value.data!.customerData!.id);
        exitScreen();
        //  navigateToDrawerScreen();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  @override
  void onInit() {
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

  verifyLoginOTP(String language) async {
    FocusScope.of(context).nextFocus();
    otp = otpController.text;
    Helper.showLoading();
    await api
        .verifyLoginOTP(phone, otp, uuid, deviceNo, deviceName, platform, model,
            version, language)
        .then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        MySharedPreferences.instance.addIntToSF(
            SharedPreferencesKeys.loginLogId, value.data!.loginLogId);
        MySharedPreferences.instance
            .addStringToSF(SharedPreferencesKeys.token, value.data!.token);
        MySharedPreferences.instance.addIntToSF(
            SharedPreferencesKeys.userId, value.data!.customerData!.id);
        MySharedPreferences.instance.addStringToSF(SharedPreferencesKeys.image,
            value.data!.customerData!.largeImageUrl);
        if (value.data!.customerAddressData != null) if (value
                .data!.customerAddressData!.length >
            0) if (value.data!.customerAddressData![0].cityName != null) {
          MySharedPreferences.instance.addStringToSF(
              SharedPreferencesKeys.address,
              "${value.data!.customerAddressData![0].cityName} - ${value.data!.customerAddressData![0].zip}");
          MySharedPreferences.instance.addStringToSF(
              SharedPreferencesKeys.addressId,
              value.data!.customerAddressData![0].id.toString());
        }
        Helper.isIndividual = true;
        navigateToDrawerScreen();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  reActivateLoginOTP(
      language, from, frm, isPasswordScreen, isStorePasswordScreen) async {
    FocusScope.of(context).nextFocus();
    otp = otpController.text;
    Helper.showLoading();
    await api.reactivateAccount(phone, otp, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        Get.delete<LoginController>();
        navigateToLoginScreen(
            from, frm, isPasswordScreen, isStorePasswordScreen);
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  resendOTP(String phone) async {
    print('hdf.....$phone');
    otpExpired = false;
    Helper.showLoading();
    await api.resendOTP(phone).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        otpValue = value.data!.otp.toString();
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
        update();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  individualLoginResendOTP(String phone) async {
    print('hdf.....$phone');
    otpExpired = false;
    Helper.showLoading();
    await api.resendLoginOTPLogin(phone).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        otpValue = value.data!.otp.toString();
        Helper.showGetSnackBar(value.message!,  AppColors.successColor);
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void navigateToDrawerScreen() {
    Get.deleteAll();
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.isLogin, true);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void exitScreen() {
    Navigator.of(context).pop(false);
  }

  void navigateToLoginScreen(
      String from, String frm, bool isPassword, bool isStorePassword) {
    //  Get.delete<OtpController>();
    otpController.clear();
    if (from ==  AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm:  AppConstants.individual,
                    isPassword: true,
                    isStorePassword: isStorePassword,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm:  AppConstants.store,
                    isPassword: isPassword,
                    isStorePassword: true,
                  )));
    }
  }

  void navigateToLoginEmailScreen(
      String from, String frm, bool isPassword, bool isStorePassword) {
    //Get.delete<OtpController>();
    otpController.clear();
    if (from ==  AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm:  AppConstants.individual,
                    isPassword: false,
                    isStorePassword: isStorePassword,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm:  AppConstants.store,
                    isPassword: isPassword,
                    isStorePassword: false,
                  )));
    }
  }
}
