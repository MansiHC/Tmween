import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/authentication/signup/otp_screen.dart';
import 'package:tmween/utils/helper.dart';

class SignUpProvider extends ChangeNotifier {
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
        navigateToOtpScreen();
      } else {
        Helper.showSnackBar(context, "Please Agree to the Terms of Use");
      }
    }
  }

  void navigateToOtpScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OtpScreen()));
  }
}
