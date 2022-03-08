import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/forgot_password_controller.dart';
import 'package:tmween/controller/login_controller.dart';
import 'package:tmween/service/api.dart';

class ForgotOtpController extends GetxController {
  late BuildContext context;

  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  TextEditingController num3Controller = TextEditingController();
  TextEditingController num4Controller = TextEditingController();


  TextEditingController otpController = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

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

  void notifyClick1(bool click) {
    click1 = click;
    update();
  }

  void notifyClick2(bool click) {
    click2 = click;
    update();
  }

  void notifyClick3(bool click) {
    click3 = click;
    update();
  }

  void notifyClick4(bool click) {
    click4 = click;
    update();
  }
}
