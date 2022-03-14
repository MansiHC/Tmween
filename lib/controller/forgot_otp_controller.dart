import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/forgot_password_controller.dart';
import 'package:tmween/service/api.dart';

import '../screens/authentication/login/forgot_password/reset_password_screen.dart';

class ForgotOtpController extends GetxController {
  late BuildContext context;

  TextEditingController otpController = TextEditingController();
  String currentText = "";

  final api = Api();
  bool loading = false;
  late String phone, otp;

  void submit(String from, String frm) {
    navigateTo(ResetPasswordScreen(
      from: from,
      frm: frm,
    ));
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
