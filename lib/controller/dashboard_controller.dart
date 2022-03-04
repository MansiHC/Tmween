import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/best_seller_model.dart';
import 'package:tmween/model/deals_of_the_day_model.dart';
import 'package:tmween/model/recently_viewed_model.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/model/top_selection_model.dart';

import '../model/select_category_model.dart';

class DashboardController extends GetxController {
  late BuildContext context;

  bool isLoading = false;

  int current = 0;
  final CarouselController controller = CarouselController();

  void changPage(int index) {
    current = index;
    update();
  }

  late final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Image.asset(item, fit: BoxFit.fill, width: double.maxFinite),
          ))
      .toList();

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

  List<DealsOfTheDayModel> deals = const <DealsOfTheDayModel>[
    const DealsOfTheDayModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const DealsOfTheDayModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const DealsOfTheDayModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const DealsOfTheDayModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];
  List<BestSellerModel> bestSellers = const <BestSellerModel>[
    const BestSellerModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const BestSellerModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const BestSellerModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const BestSellerModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];
  List<SoldByTmweenModel> soldByTmweens = const <SoldByTmweenModel>[
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const SoldByTmweenModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];
  List<TopSelectionModel> topSelections = const <TopSelectionModel>[
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];
  List<RecentlyViewedModel> recentlVieweds = const <RecentlyViewedModel>[
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
