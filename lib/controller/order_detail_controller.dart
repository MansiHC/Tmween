import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/order_detail_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class OrderDetailController extends GetxController {
  late BuildContext context;
  double currentRating = 3;

  int userId = 0;
  int loginLogId = 0;
  bool noOrders = true;
  String token = '';
  String? orderId;

  TextEditingController searchController = TextEditingController();

  OrderData? orderData = null;
  String? invoiceUrl;

  final api = Api();

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

  bool isLoading = true;

  Future<void> getOrderDetail(language) async {
    Helper.showLoading();
    // update();
    await api.getOrderDetail(userId, token, orderId, language).then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        Helper.hideLoading(context);
        orderData = value.data!.orderData![0];
      } else {
        isLoading = false;
        Helper.hideLoading(context);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      isLoading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> getInvoice(language) async {
    Helper.showLoading();
    // update();
    await api.getInvoice(userId, token, orderId, language).then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        Helper.hideLoading(context);
        invoiceUrl = value.data!;
      } else {
        isLoading = false;
        Helper.hideLoading(context);
      }
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      isLoading = false;
      update();
      print('error....$error');
    });
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
