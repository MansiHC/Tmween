import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/store_owner_signup_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/signup/otp_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/global.dart';
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
    Helper.showLoading();
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
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        Helper.isIndividual = true;
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
        navigateToOtpScreen(value.data!.otp);
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
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
    Get.delete<SignUpController>();
    Get.delete<StoreOwnerSignUpController>();
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
        Helper.showGetSnackBar(
            LocaleKeys.emptyAgreeTerms.tr, AppColors.errorColor);
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  otp: otp.toString(),
                  phone: phoneController.text,
                )));
  }
}
