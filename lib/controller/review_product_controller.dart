import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

class ReviewProductController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;

  final formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();

  double currentRating = 3;

  bool isCreditChecked = false;

  List<String> walletActivitys = const <String>[
    'December 2021',
    'November 2021',
    'October 2021'
  ];

  @override
  void onInit() {
    /*MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value!;
      });
    });*/
    super.onInit();
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
