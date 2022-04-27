import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class DashboardController extends GetxController {
  late BuildContext context;

  int current = 0;
  final CarouselController topBannerController = CarouselController();
  final CarouselController centerBannerController = CarouselController();
  final CarouselController centerUpBannerController = CarouselController();
  final CarouselController centerDownBannerController = CarouselController();

  void changPage(int index) {
    current = index;
    update();
  }

  final api = Api();
  bool loading = false;
  List<SoldByTmweenProductData>? soldByTmweenProductData = [];
  List<TopSelectionData>? topSelectionData = [];
  List<BestSellerData>? bestSellerData = [];
  List<DailyDealsData>? dailyDealsData = [];
  List<RecentlyViewProduct>? recentlyViewProduct = [];
  List<ShopByCategory>? shopByCategory = [];
  List<TOP>? topBanners = [];
  List<CENTER>? centerBanners = [];
  List<CENTERUP>? centerUpBanners = [];
  List<CENTERDOWN>? centerDownBanners = [];
  int userId = 0;

  @override
  void onInit() {
    MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
          if(value!=null) {
            userId = value;
          }
      getDashboardData(Get.locale!.languageCode);
    });
    super.onInit();
  }

  Future<void> onRefresh(language) async {
    await api.getHomePageMobileData(userId,language).then((value) {
      if (value.statusCode == 200) {
        recentlyViewProduct = value.data!.recentlyViewProduct;
        topSelectionData = value.data!.topSelectionData;
        soldByTmweenProductData = value.data!.soldByTmweenProductData;
        bestSellerData = value.data!.bestSellerData;
        dailyDealsData = value.data!.dailyDealsData;
        shopByCategory = value.data!.shopByCategory;
        topBanners = value.data!.banners!.tOP;
        centerBanners = value.data!.banners!.cENTER;
        centerUpBanners = value.data!.banners!.cENTERUP;
        centerDownBanners = value.data!.banners!.cENTERDOWN;
        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> getDashboardData(language) async {
    //Helper.showLoading();
    loading = true;
    update();
    await api.getHomePageMobileData(userId,language).then((value) {
      if (value.statusCode == 200) {
        recentlyViewProduct = value.data!.recentlyViewProduct;
        topSelectionData = value.data!.topSelectionData;
        soldByTmweenProductData = value.data!.soldByTmweenProductData;
        bestSellerData = value.data!.bestSellerData;
        dailyDealsData = value.data!.dailyDealsData;
        shopByCategory = value.data!.shopByCategory;
        topBanners = value.data!.banners!.tOP;
        centerBanners = value.data!.banners!.cENTER;
        centerUpBanners = value.data!.banners!.cENTERUP;
        centerDownBanners = value.data!.banners!.cENTERDOWN;
        update();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      // Helper.hideLoading();
      loading = false;
      update();
    }).catchError((error) {
      //Helper.hideLoading();
      loading = false;
      update();
      print('error....$error');
    });
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
