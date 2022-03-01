import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/address_model.dart';
import 'package:tmween/model/language_model.dart';
import 'package:tmween/screens/authentication/login/login_screen.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/dashboard_screen.dart';
import 'package:tmween/screens/drawer/search_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';
import 'package:tmween/service/api.dart';

import '../lang/locale_keys.g.dart';
import '../model/recently_viewed_model.dart';
import '../screens/drawer/cart_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class SearchController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList= false;
  int val = 1;

  final List<String> items = [
    'Sofa',
    'Bed'
  ];


  List<AddressModel> addresses = const <AddressModel>[
    const AddressModel(
        name: 'Salim Akka',
        addressLine1: '34 Brooke Place,',
        addressLine2: '',
        city: 'Farmington',
        state: 'nm',
        country: 'Unites States',
        pincode: '83401',
        isDefault: true),
    const AddressModel(
      name: 'Salim Akka',
      addressLine1: '34 Brooke Place,',
      addressLine2: '',
      city: 'Farmington',
      state: 'nm',
      country: 'Unites States',
      pincode: '83401',
    )
  ];

  final List<String> historyList = [
    'Watches',
    'Sunglasses',
    'Furniture',
    'Outdoor',
    'Sport,Fitness and Outdoor',
    'Jewelry',
    'COmputer and Gaming',
  ];


  List<RecentlyViewedModel> recentlVieweds = const <RecentlyViewedModel>[
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
  ];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }



  void closeDrawer() {
    Navigator.pop(context);
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }

}
