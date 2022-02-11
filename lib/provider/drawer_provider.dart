import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmween/screens/authentication/login/login_screen.dart';
import 'package:tmween/screens/drawer/CartScreen.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/dashboard_screen.dart';
import 'package:tmween/screens/drawer/search_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';
import 'package:tmween/service/api.dart';

class DrawerProvider extends ChangeNotifier {
  late BuildContext context;
  int pageIndex = 0;

  final pages = [
    DashboardScreen(),
    CategoriesScreen(),
    SearchScreen(),
    WishlistScreen(),
    CartScreen()
  ];

  void changePage(int pageNo) {
    pageIndex = pageNo;
    notifyListeners();
  }

  void pop() {
    Navigator.of(context).pop(false);
    notifyListeners();
  }

  void exit() {
    SystemNavigator.pop();
    notifyListeners();
  }

  final api = Api();
  bool loading = false;

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

  void navigateToLoginScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
