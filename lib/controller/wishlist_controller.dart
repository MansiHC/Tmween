import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_wishlist_details_model.dart';

import '../model/sold_by_tmween_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class WishlistController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  List<SoldByTmweenModel> soldByTmweens = const <SoldByTmweenModel>[
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_1.jpg'),
    const SoldByTmweenModel(
        title: 'New Apple iPhone 12 (64GB)-Black',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_2.jpg'),
    const SoldByTmweenModel(
        title: 'Lenovo V15 Intel Core i5 11th Gen 15.6 inches',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_3.jpg'),
    const SoldByTmweenModel(
        title: 'EDICT by Boat DynaBeats EWH01 Wireless Bluetooth',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_4.jpg'),
    const SoldByTmweenModel(
        title: 'D-Link DSL-2750U Wireless-N 300 ADSL2/2+ 4-Port Router',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_5.jpg'),
    const SoldByTmweenModel(
        title: 'Lenovo Casual Laptop Briefcase T210 (Toploader) 39.62 cm...',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/wish_lists_images/wishlist_img_6.jpg'),
  ];

  final api = Api();
  bool loading = false;
  List<WishlistData> wishListData = [];

  void exitScreen() {
    Get.delete<WishlistController>();
    Navigator.of(context).pop();
  }

  int userId = 0;
  String token = '';
  int loginLogId = 0;

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
        getWishListData(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> getWishListData(language) async {
    wishListData = [];
    loading = true;
    update();
    await api.getWishListDetails(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        wishListData = value.data!.wishlistData!;
        print('.................${wishListData.length}');
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
     //   Get.offAll(DrawerScreen());
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> removeWishlistProduct(id, language) async {
    //  if (Helper.isIndividual) {
    await api.deleteWishListDetails(token, id, userId, language).then((value) {
      if (value.statusCode == 200) {
        getWishListData(Get.locale!.languageCode);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
       Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      Helper.showGetSnackBar(value.message!);
      update();
    }).catchError((error) {
      print('error....$error');
    });
    //  }
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
