import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/recently_viewed_controller.dart';

import '../model/dashboard_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class RecentlyViewedProductController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<RecentlyViewProduct>? recentlyViewProduct = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;
  List<int> wishListedProduct = [];
  int userId = 0;
  String token = '';
  int loginLogId = 0;
  bool isLogin = true;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getData(language) async {
    //Helper.showLoading();
    loading = true;
    wishListedProduct = [];
    update();
    await api.getRecentlyViewed(userId, "1", language).then((value) {
      //  Helper.hideLoading(context);
      loading = false;
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct = value.data!.recentlyViewProduct;
        for (var i = 0; i < recentlyViewProduct!.length; i++) {
          if (recentlyViewProduct![i].isWishlist == 1)
            wishListedProduct.add(recentlyViewProduct![i].id!);
        }
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }

      update();
    }).catchError((error) {
      // Helper.hideLoading(context);
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> onRefresh(language) async {
    await api.getRecentlyViewed(userId, "1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct = value.data!.recentlyViewProduct;

        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> loadMore(language) async {
    update();
    await api.getRecentlyViewed(userId, next, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct?.addAll(value.data!.recentlyViewProduct!);
        print('ydgsyudgfyuy.........${recentlyViewProduct!.length}');
        for (var i = 0; i < recentlyViewProduct!.length; i++) {
          if (recentlyViewProduct![i].isWishlist == 1)
            wishListedProduct.add(recentlyViewProduct![i].productId!);
        }

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

  Future<void> removeWishlistProduct(productId, language) async {
    //  if (Helper.isIndividual) {
    print('remove......');
    await api
        .deleteWishListDetails(token, productId, userId, language)
        .then((value) {
      if (value.statusCode == 200) {
        wishListedProduct.remove(productId);
        update();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
      update();
    }).catchError((error) {
      print('error....$error');
    });
    //  }
  }

  Future<void> addToWishlist(productId, language) async {
    Helper.showLoading();
    await api
        .addDataToWishlist(token, userId, productId, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        wishListedProduct.add(productId);
        update();
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        wishListedProduct.add(productId);
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.errorColor);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void exitScreen() {
    Get.delete<RecentlyViewedController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
