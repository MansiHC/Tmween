import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/order_model.dart';

class YourOrderController extends GetxController {
  late BuildContext context;
  double currentRating = 3;

  int userId = 0;
  int loginLogId = 0;
  bool noOrders = false;
  TextEditingController searchController = TextEditingController();
  List<OrderModel> orders = const <OrderModel>[
    const OrderModel(
        title: 'Book name - author name details of book',
        image: 'asset/image/my_cart_images/book.png',
        deliveryStatus: 'Delivered Today',
        rating: 0,
        ratingStatus: 'Rate this product now',
        isRating: true),
    const OrderModel(
        title: 'Book name - author name details of book',
        image: 'asset/image/my_cart_images/book.png',
        deliveryStatus: 'Delivered Today',
        rating: 3,
        ratingStatus: 'Write Review',
        isRating: true),
    const OrderModel(
        title: 'Book name - author name details of book',
        image: 'asset/image/my_cart_images/book.png',
        deliveryStatus: 'Refund Completed',
        isRating: false),
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
