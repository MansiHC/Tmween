import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/service/api.dart';

import '../screens/authentication/login/login_screen.dart';
import 'forgot_otp_controller.dart';

class ResetPasswordController extends GetxController {
  late BuildContext context;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

  void exitScreen() {
    Navigator.of(context).pop(false);
  }

  void submit(String from,String frm) {
    FocusScope.of(context).unfocus();
    navigateToLoginScreen(from,frm);
  }

  void navigateToLoginScreen(String from,String frm) {
    Get.delete<ForgotOtpController>();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  from: LocaleKeys.forgotPassword,
                  frm: frm,
              frmReset: from,
                )),
        (Route<dynamic> route) => false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
