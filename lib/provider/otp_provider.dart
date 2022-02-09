import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/authentication/login/login_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import '../screens/drawer/drawer_screen.dart';

class OtpProvider extends ChangeNotifier {
  late BuildContext context;

  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  TextEditingController num3Controller = TextEditingController();
  TextEditingController num4Controller = TextEditingController();

  final api = Api();
  bool loading = false;
  late String phone, otp;

  verifyOTP() async {
    loading = true;
    notifyListeners();

    otp = num1Controller.text +
        num2Controller.text +
        num3Controller.text +
        num4Controller.text;

    navigateToLoginScreen();
   /* await api.verifyOTP(context, 1, phone, otp).then((value) {
      loading = false;
      notifyListeners();
      Helper.showSnackBar(context, value.status_message!);
      if(value.message==AppConstants.success) {}
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });*/
  }

  resendOTP() async {
    loading = true;
    notifyListeners();

    await api.resendOTP(context, "1", phone).then((value) {
      loading = false;
      notifyListeners();
      Helper.showSnackBar(context, value.status_message!);
      if(value.message==AppConstants.success) {}
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });
  }

  void navigateToLoginScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void notifyClick1(bool click) {
    click1 = click;
    notifyListeners();
  }

  void notifyClick2(bool click) {
    click2 = click;
    notifyListeners();
  }

  void notifyClick3(bool click) {
    click3 = click;
    notifyListeners();
  }

  void notifyClick4(bool click) {
    click4 = click;
    notifyListeners();
  }
}
