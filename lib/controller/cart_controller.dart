import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/cart_product_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class CartController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  bool freeChecked = false;
  int quntity = 1;

  List<CartProductModel> cartProducts = const <CartProductModel>[
    const CartProductModel(
        title: 'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        rating: '4.1',
        price: '1340',
        isFulFilled: true,
        specifications: [{'title':'Color','value':'black'},{'title':'Size','value':'XL'},],
        inStock: true,
        isFree: false,
        count: '5',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',

  ),const CartProductModel(
        title: 'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and Carry Case',
        rating: '4.1',
        price: '1340',
        isFulFilled: true,
      specifications: [{'title':'Color','value':'black'}],
        inStock: false,
        stockCount: '8',
        isFree: true,
        count: '5', image:
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    ),
  ];

  @override
  void onInit() {
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
