import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  doRegister() async {
    loading = true;
    notifyListeners();
    await api
        .register(context, firstNameController.text, lastNameController.text, "1",
            passwordController.text, emailController.text,phoneController.text, agreeTo, "en")
        .then((value) {
      loading = false;
      notifyListeners();
      print('value....${value.toString()}');
      Helper.showSnackBar(context, value.message!);
     /* if(value.message==AppConstants.success) {
        navigateToOtpScreen();
      }*/
    }).catchError((error){
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
        //doRegister();
        navigateToOtpScreen();
      } else {
        Helper.showSnackBar(context, "Please Agree to the Terms of Use");
      }
    }
  }

  void navigateToOtpScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(phone: phoneController.text)));
  }
}
