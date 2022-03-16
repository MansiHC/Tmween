import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/service/api.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/helper.dart';
import 'forgot_otp_controller.dart';

class ResetPasswordController extends GetxController {
  late BuildContext context;
  final formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

  void exitScreen() {
    Navigator.of(context).pop(false);
  }

  resetPassword(from,frm,email,token,language) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      loading = true;
      update();
      await api
          .resetPassword( email,confirmPasswordController.text,token, language)
          .then((value) {
        if (value.statusCode == 200) {
          submit(from, frm);
        }
        loading = false;
        update();
        Helper.showGetSnackBar( value.message!);
      }).catchError((error) {
        loading = false;
        update();
        print('error....$error');
      });
    }
  }


  void submit(String from, String frm) {
    FocusScope.of(context).unfocus();
    navigateToLoginScreen(from, frm);
  }

  void navigateToLoginScreen(String from, String frm) {
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
