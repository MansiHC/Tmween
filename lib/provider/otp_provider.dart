import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/authentication/login/login_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/service/api.dart';
import 'package:tmween/utils/helper.dart';

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

  verifyOTP(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    otp = num1Controller.text +
        num2Controller.text +
        num3Controller.text +
        num4Controller.text;

    navigateToDrawerScreen();
    /*
    loading = true;
    notifyListeners();
    await api.verifyOTP(context, 1, phone, otp).then((value) {
      loading = false;
      notifyListeners();
      Helper.showSnackBar(context, value.status_message!);
      if(value.message==AppConstants.success) {
      doRegister( name, email, phone, password,deviceType,langCode,agreeTerms);
      }
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });*/
  }

  verifyLoginOTP(){
    otp = num1Controller.text +
        num2Controller.text +
        num3Controller.text +
        num4Controller.text;

    navigateToDrawerScreen();
  }

  doRegister(String name, String email, String phone, String password,
      String deviceType, String langCode, String agreeTerms) async {
    loading = true;
    notifyListeners();
    await api
        .register(context, name, deviceType, password, email, phone, agreeTerms,
            langCode)
        .then((value) {
      loading = false;
      notifyListeners();
      print('value....${value.toString()}');
      Helper.showSnackBar(context, value.message!);
      /* if(value.message==AppConstants.success) {
        navigateToOtpScreen();
      }*/
      navigateToDrawerScreen();
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });
  }

  resendOTP() async {
    /* loading = true;
    notifyListeners();

    await api.resendOTP(context, "1", phone).then((value) {
      loading = false;
      notifyListeners();
      Helper.showSnackBar(context, value.status_message!);
      if (value.message == AppConstants.success) {}
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });*/
  }

  void navigateToDrawerScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DrawerScreen()));
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
