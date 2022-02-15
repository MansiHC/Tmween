import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/authentication/login/login_otp_screen.dart';
import 'package:tmween/screens/authentication/signup/signup_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/my_shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late BuildContext context;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Map<String, dynamic> deviceData;
  String? uuid, deviceNo, deviceName, platform, model, version;

  bool rememberMe = false;
  bool loginEmail = true;
  bool visiblePhoneEmail = true;
  bool isPhoneEmailEmpty = false;
  bool visiblePassword = false;
  TextEditingController phoneEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    notifyListeners();
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

  final api = Api();
  bool loading = false;

  doLogin() async {
    loginEmail = false;
    notifyListeners();
    /*loading = true;
    notifyListeners();
   await api
        .login(context, 1, phoneController.text, uuid, deviceNo, deviceName,
            platform, model, version)
        .then((value) {
      if (value.message == AppConstants.success) {

        loading = false;
        notifyListeners();
        MySharedPreferences.instance
            .addIntToSF(SharedPreferencesKeys.loginLogId, value.data!.loginLogId);
        MySharedPreferences.instance
            .addIntToSF(SharedPreferencesKeys.userId, value.data!.customerData!.id);
        navigateToDrawerScreen();
      } else {
        Helper.showSnackBar(context, value.message!);
      }
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });*/
  }

  doLoginWithPassword() {
    if (formKey.currentState!.validate()) {
      navigateToDrawerScreen();
    }
  }

  void navigateToSignupScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void navigateToOTPScreen() {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginOtpScreen(
                    phoneEmail: phoneEmailController.text.toString())))
        .then((value) {
      if (value) {
        visiblePhoneEmail = false;
      } else {
        visiblePhoneEmail = true;
      }
      notifyListeners();
    });
  }

  void navigateToDrawerScreen() {
    rememberMe == true
        ? MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, true)
        : MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DrawerScreen()));
  }

  void exitScreen() {
    loginEmail = true;
    visiblePhoneEmail = true;
    Navigator.of(context).pop();
  }

  void notifyCheckBox() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      doLogin();
    }
  }
}
