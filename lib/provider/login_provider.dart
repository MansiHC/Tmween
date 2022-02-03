import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/authentication/signup/signup_screen.dart';

class LoginProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late BuildContext context;

  bool rememberMe = false;
  TextEditingController phoneController = TextEditingController();

  void navigateToSignupScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void notifyCheckBox() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  void login() {
    if (formKey.currentState!.validate()) {}
  }
}
