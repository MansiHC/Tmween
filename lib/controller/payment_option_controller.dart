import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_payment_option_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../screens/drawer/checkout/review_order_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class PaymentOptionController extends GetxController {
  late BuildContext context;

  int userId = 0;
  String token = '';
  int loginLogId = 0;

  final api = Api();
  bool loading = false;
  List<PaymentMethod> paymentOptions = [];
  List<int> radioValue = [];
  int radioCurrentValue = 1;

  @override
  void onInit() {
    print('....${Get.locale!.languageCode}');
    // if (Helper.isIndividual) {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        getPaymentOptions(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    // }
    super.onInit();
  }

  Future<void> getPaymentOptions(language) async {
    Helper.showLoading();
    loading = true;
    update();
    await api.getPaymentOptions(userId, language).then((value) {
      Helper.hideLoading(context);
      loading = false;
      paymentOptions = value.data!.paymentMethod!;
      for(int i=0;i<paymentOptions.length;i++){
        radioValue.add(paymentOptions[i].id!);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> setPaymentOption(language) async {
    Helper.showLoading();
    loading = true;
    update();
    await api.setPaymentOptions(token,userId, radioCurrentValue,language).then((value) {
      Helper.hideLoading(context);
      loading = false;
   navigateTo(ReviewOrderScreen());
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      loading = false;
      update();
      print('error....$error');
    });
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void exitScreen() {
    Get.delete<PaymentOptionController>();
    Navigator.of(context).pop(true);
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
}
