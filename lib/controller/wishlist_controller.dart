import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/sold_by_tmween_model.dart';

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
        image:
        'asset/image/wish_lists_images/wishlist_img_1.jpg'),   const SoldByTmweenModel(
        title: 'New Apple iPhone 12 (64GB)-Black',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/wish_lists_images/wishlist_img_2.jpg'),   const SoldByTmweenModel(
        title: 'Lenovo V15 Intel Core i5 11th Gen 15.6 inches',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/wish_lists_images/wishlist_img_3.jpg'), const SoldByTmweenModel(
        title: 'EDICT by Boat DynaBeats EWH01 Wireless Bluetooth',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/wish_lists_images/wishlist_img_4.jpg'),const SoldByTmweenModel(
        title: 'D-Link DSL-2750U Wireless-N 300 ADSL2/2+ 4-Port Router',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/wish_lists_images/wishlist_img_5.jpg'),const SoldByTmweenModel(
        title: 'Lenovo Casual Laptop Briefcase T210 (Toploader) 39.62 cm...',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'asset/image/wish_lists_images/wishlist_img_6.jpg'), ];

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
