import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/best_seller_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/recently_viewed_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/top_selection_model.dart';

import '../model/dashboard_model.dart';
import '../model/select_category_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

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



  final List<String> imgList = [
    'asset/image/home_page_slider_images/slider_1.jpg',
    'asset/image/home_page_slider_images/slider_2.jpg',
    'asset/image/home_page_slider_images/slider_3.jpg',
    'asset/image/home_page_slider_images/slider_4.jpg',
    'asset/image/home_page_slider_images/slider_5.jpg',
  ];

  List<SelectCategoryModel> categories = const <SelectCategoryModel>[
    const SelectCategoryModel(
        title: 'Furniture',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
    const SelectCategoryModel(
        title: 'Watches',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_2.jpg'),
    const SelectCategoryModel(
        title: 'Sunglasses',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_3.jpg'),
    const SelectCategoryModel(
        title: 'Electronics',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_4.jpg'),
    const SelectCategoryModel(
        title: 'Sports, Fitness & Outdoor',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_5.jpg'),
    const SelectCategoryModel(
        title: 'Computers & Gaming',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_6.jpg'),
    const SelectCategoryModel(
        title: 'Belts',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_7.jpg'),
    const SelectCategoryModel(
        title: 'Wallets & Clutches',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_8.jpg'),
    const SelectCategoryModel(
        title: 'Jewelry',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_9.jpg'),
    const SelectCategoryModel(
        title: 'Beauty',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_10.jpg'),
    const SelectCategoryModel(
        title: 'Outdoor',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_11.jpg'),
    const SelectCategoryModel(
        title: 'Daily Needs',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_12.jpg'),
  ];

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

  @override
  void onInit() {
    getDashboardData();
    super.onInit();
  }


  Future<void> onRefresh() async{

    await api.getHomePageMobileData('en').then((value) {
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
  Future<void> getDashboardData() async {
    loading = true;
    update();
    await api.getHomePageMobileData('en').then((value) {
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
        Helper.showGetSnackBar(value.message!);
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
