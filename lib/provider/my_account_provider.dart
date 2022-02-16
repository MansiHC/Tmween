import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';

import '../screens/authentication/login/login_screen.dart';

class MyAccountProvider extends ChangeNotifier{
  late BuildContext context;


  void doLogout(int userId, int loginLogId) async {
    navigateToLoginScreen();
    /*loading = true;
    notifyListeners();
    await api
        .logout(context, 1, userId, loginLogId )
        .then((value) {
      if (value.message == AppConstants.success) {
        loading = false;
        notifyListeners();
        navigateToLoginScreen();
      } else {
        Helper.showSnackBar(context, value.message!);
      }
    }).catchError((error) {
      loading = false;
      notifyListeners();
      print('error....$error');
    });*/
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }
  void pop() {
    Navigator.of(context).pop(false);
    notifyListeners();
  }
  void navigateToLoginScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
  }

  void navigateToUpdateProfileScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
  }

}