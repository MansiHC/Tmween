import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/screens/authentication/signup/otp_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

class SignUpProvider extends ChangeNotifier {
  bool agree = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool visiblePassword = false, visibleConfirmPassword = false;
  final formKey = GlobalKey<FormState>();
  late BuildContext context;

  get agreeTo => agree ? "1" : "0";

  final api = Api();
  bool loading = false;

  doRequest() async {
    loading = true;
    notifyListeners();
    await api
        .request(
            context,
            firstNameController.text,
            lastNameController.text,
            "1",
            passwordController.text,
            emailController.text,
            phoneController.text,
            agreeTo,
            "en")
        .then((value) {
      loading = false;
      notifyListeners();
      print('value....${value.toString()}');
      Helper.showSnackBar(context, value.message!);
      /* if(value.message==AppConstants.success) {
        navigateToOtpScreen();
      }*/
      navigateToOtpScreen();
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void notifyCheckBox() {
    agree = !agree;
    notifyListeners();
  }

  void visiblePasswordIcon() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  void visibleConfirmPasswordIcon() {
    visibleConfirmPassword = !visibleConfirmPassword;
    notifyListeners();
  }

  void signUp() {
    if (formKey.currentState!.validate()) {
      if (agree) {
        //doRequest();
        navigateToOtpScreen();
      } else {
        Helper.showSnackBar(context, LocaleKeys.emptyAgreeTerms.tr());
      }
    }
  }

  void navigateToOtpScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                name:
                    "${firstNameController.text}+ +${lastNameController.text}",
                deviceType: "1",
                password: passwordController.text,
                email: emailController.text,
                phone: phoneController.text,
                agreeTerms: agreeTo,
                langCode: "en")));
  }
}
