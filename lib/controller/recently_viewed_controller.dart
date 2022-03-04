import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/recently_viewed_model.dart';

class RecentlyViewedController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

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
