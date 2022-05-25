import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/checkout_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class PaymentGatewayController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  int paymentMethodId = 0;
  String token = '';
  final api = Api();
  int orderPlaced = 0;
  late CheckoutData? checkoutData = null;
  var webViewController;

  @override
  void onInit([Address? address]) {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        getCheckoutDetail(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> getCheckoutDetail(language) async {
    Helper.showLoading();
    // update();
    await api.getCheckoutDetail(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        checkoutData = value.data!;
        if (checkoutData!.paymentUrl!.isEmpty) {
          orderPlaced = 1;
        }
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        orderPlaced = 3;
        Helper.hideLoading(context);
        // Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      orderPlaced = 3;
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getOrderStatus(language) async {
    print('.....${checkoutData!.salesOrderId}....');
    Helper.showLoading();
    // update();
    await api
        .getOrderStatus(token, userId, checkoutData!.salesOrderId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        orderPlaced = 1;
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        orderPlaced = 2;
        Helper.hideLoading(context);
        // Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      orderPlaced = 3;
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

//0
  //1 order placed
  //2 payment failure
  //3 bad request
  //4 response from syberpay
  void exitScreen() {
    if (orderPlaced != 1) {
      Get.delete<PaymentGatewayController>();
      Navigator.of(context).pop(false);
    } else {
      Get.deleteAll();
      Get.offAll(DrawerScreen());
    }
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