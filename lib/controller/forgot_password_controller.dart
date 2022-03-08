import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/global.dart';

import '../lang/locale_keys.g.dart';
import '../screens/authentication/login/login_screen.dart';

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

  void navigateToLoginScreen(String from,String frm) {
    if(from==AppConstants.individual) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          LoginScreen(
            from: frm,
            isPassword: true,
            isStorePassword: false,
          )));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          LoginScreen(
            from: frm,
            isPassword: false,
            isStorePassword: true,
          )));
    }
  }
}
