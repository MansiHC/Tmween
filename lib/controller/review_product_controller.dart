import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ReviewProductController extends GetxController {
  late BuildContext context;

  final formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();

  double currentRating = 0;

  bool isCreditChecked = false;

  List<String> walletActivitys = const <String>[
    'December 2021',
    'November 2021',
    'October 2021'
  ];

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  int productId=0;
  final api = Api();
  bool loading = false;

  @override
  void onInit() {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> rateProduct(language) async {
    loading = true;
    update();
    await api.addCustomerReview(token, userId,productId,commentController.text,currentRating, language).then((value) {
      if (value.statusCode == 200) {
        Helper.showGetSnackBar(value.message!);
        Get.delete<ReviewProductController>();
        Navigator.of(context).pop(true);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }


  void exitScreen() {
    Get.delete<ReviewProductController>();
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
