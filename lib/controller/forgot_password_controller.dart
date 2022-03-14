import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/global.dart';

import '../screens/authentication/login/forgot_password/forgot_otp_screen.dart';
import '../screens/authentication/login/login_screen.dart';
import 'forgot_otp_controller.dart';

class ForgotPasswordController extends GetxController {
  late BuildContext context;

  TextEditingController emailMobileController = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void navigateToPasswordScreen() {
    Navigator.of(context).pop(true);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void submit(String from, String frm) {
    FocusScope.of(context).unfocus();
    navigateTo(ForgotOtpScreen(from: from, frm: frm));
  }

  void navigateToLoginScreen(String from, String frm) {
    Get.delete<ForgotOtpController>();
    if (from == AppConstants.individual) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.individual,
                    isPassword: true,
                    isStorePassword: false,
                  )));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    from: frm,
                    frm: AppConstants.store,
                    isPassword: false,
                    isStorePassword: true,
                  )));
    }
  }
}
