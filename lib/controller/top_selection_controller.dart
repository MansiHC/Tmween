import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/top_selection_model.dart';

class TopSelectionController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  List<TopSelectionModel> topSelections = const <TopSelectionModel>[
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/deals_of_the_day_home/deals_img.jpg'),
    const TopSelectionModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/deals_of_the_day_home/deals_img.jpg'),
  ];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
