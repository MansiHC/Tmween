import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChangePasswordController extends GetxController {
  late BuildContext context;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  bool visiblePassword = true, visibleConfirmPassword = true;

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    update();
  }

  void visibleConfirmPasswordIcon() {
    visibleConfirmPassword = !visibleConfirmPassword;
    update();
  }

  void save() {}

  void resend() {}
}
