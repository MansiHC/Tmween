import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/signup/otp_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

import 'otp_controller.dart';

class SignUpController extends GetxController {
  bool agree = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool visiblePassword = true, visibleConfirmPassword = true;
  final formKey = GlobalKey<FormState>();
  late BuildContext context;

  get agreeTo => agree ? "1" : "0";

  final api = Api();
  bool loading = false;

  doRequest(language) async {
    loading = true;
    update();
    await api
        .request(
            firstNameController.text,
            lastNameController.text,
            passwordController.text,
            emailController.text,
            phoneController.text,
            agreeTo,
            language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.isIndividual = true;
        Helper.showGetSnackBar(value.message!);
        navigateToOtpScreen(value.data!.otp);
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

  late List<Tab> tabList;

  @override
  void onInit() {
    Get.delete<OtpController>();
    tabList = <Tab>[];
    tabList.add(new Tab(
      text: LocaleKeys.individual.tr,
    ));
    tabList.add(new Tab(
      text: LocaleKeys.storeOwner.tr,
    ));
    super.onInit();
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void notifyCheckBox() {
    agree = !agree;
    update();
  }

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    update();
  }

  void visibleConfirmPasswordIcon() {
    visibleConfirmPassword = !visibleConfirmPassword;
    update();
  }

  void signUpIndividual(language) {
    if (formKey.currentState!.validate()) {
      if (agree) {
        doRequest(language);
      } else {
        Helper.showGetSnackBar(LocaleKeys.emptyAgreeTerms.tr);
      }
    }
  }

  void signUp(language) {
    navigateToOtpScreen(1234);
    // if (formKey.currentState!.validate()) {
    // if (agree) {
    // doRequest(language);
    // } else {
    //  Helper.showSnackBar(context, LocaleKeys.emptyAgreeTerms.tr);
    //  }
    //   }
  }

  void navigateToOtpScreen(int? otp) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  otp: otp.toString(),
                  phone: phoneController.text,
                )));
  }
}
