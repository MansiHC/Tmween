import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/order_listing_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class YourOrderController extends GetxController {
  late BuildContext context;
  double currentRating = 3;

  int userId = 0;
  int loginLogId = 0;
  String token = '';
  bool noOrders = false;
  TextEditingController searchController = TextEditingController();
  List<OrderData>? orders = [];
  List<OrderData>? orderItems = [];

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
        getOrderList(Get.locale!.languageCode);

        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  bool isLoading = true;
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;
  final api = Api();

  Future<void> getOrderList(language) async {
    orders = [];
    orderItems = [];
    Helper.showLoading();
    totalPages = 0;
     prev = 0;
     next = 0;
     totalRecords = 0;
    // update();
    await api.getOrderList('1', userId, token, language).then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        Helper.hideLoading(context);
        orders = value.data!.orderData!;
        orderItems = value.data!.orderData!;
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
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

  Future<void> getSearchOrderList(keyword, language) async {
    orders = [];
    Helper.showLoading();
    // update();
    await api
        .getSearchOrderList('1', userId, token, keyword, language)
        .then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        Helper.hideLoading(context);
        orders = value.data!.orderData!;
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
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

  Future<bool> loadMore(language) async {
    update();
    await api.getOrderList(next, userId, token, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        orders?.addAll(value.data!.orderData!);
        orderItems?.addAll(value.data!.orderData!);
        update();
        return true;
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
      return false;
    });
    return false;
  }

  void exitScreen() {
    Get.delete<YourOrderController>();
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
