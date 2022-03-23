import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/forgot_password_controller.dart';
import 'package:tmween/service/api.dart';

import '../screens/authentication/login/forgot_password/reset_password_screen.dart';
import '../utils/helper.dart';

class ForgotOtpController extends GetxController {
  late BuildContext context;

  TextEditingController otpController = TextEditingController();
  String currentText = "";

  final api = Api();
  bool loading = false;
  bool otpExpired = false;
  late String phone, otp, otpValue;
  String? uuid, deviceNo, deviceName, platform, model, version;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Map<String, dynamic> deviceData;

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

  void submit(String from, String frm, String email) {
    navigateTo(ResetPasswordScreen(from: from, frm: frm, email: email));
  }

  verifyOTP(from, frm, language, email) async {
    FocusScope.of(context).unfocus();
    if (otpController.text.isEmpty) {
      Helper.showGetSnackBar('Please Enter Otp First.');
    } else {
      loading = true;
      update();
      await api
          .verifyForgotPasswordOTP(otpController.text, email, uuid, deviceNo,
              deviceName, platform, model, version, language)
          .then((value) {
        if (value.statusCode == 200) {
          submit(from, frm, email);
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

  resendOTP(from, frm, language, email) async {
    FocusScope.of(context).unfocus();
    otpExpired = false;
    loading = true;
    update();
    await api.resendForgotPasswordOTP(email, language).then((value) {
      if (value.statusCode == 200) {
        otpValue = value.data!.otp.toString();
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

  void exitScreen() {
    Navigator.of(context).pop(false);
  }

  void navigateToPasswordScreen() {
    Navigator.of(context).pop(true);
  }

  void navigateTo(Widget route) {
    //   Get.delete<LoginController>();
    Get.delete<ForgotPasswordController>();
    Get.delete<ForgotOtpController>();

    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
