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
      //  getWishListData(Get.locale!.languageCode);
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
      //  print('.................${wishListData.length}');
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
