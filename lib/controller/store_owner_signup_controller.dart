import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/signup/otp_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

import 'otp_controller.dart';

class StoreOwnerSignUpController extends GetxController {
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

  doRequest() async {
    loading = true;
    update();
    await api
        .request(
            context,
            firstNameController.text,
            lastNameController.text,
            passwordController.text,
            emailController.text,
            phoneController.text,
            agreeTo,
            "en")
        .then((value) {
      loading = false;
      update();
      print('value....${value.toString()}');
      Helper.showSnackBar(context, value.message!);
      /* if(value.message==AppConstants.success) {
        navigateToOtpScreen();
      }*/
      navigateToOtpScreen();
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

  void signUp() {
    // if (formKey.currentState!.validate()) {
    // if (agree) {
    //doRequest();
    navigateToOtpScreen();
    //} else {
    // Helper.showSnackBar(context, LocaleKeys.emptyAgreeTerms.tr);
    //}
    //}
  }

  void navigateToOtpScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  otp: "",
                  phone: phoneController.text,
                )));
  }
}
