import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/review_model.dart';
import 'package:tmween/model/seller_on_tmween_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/utils/global.dart';

import '../model/address_model.dart';
import '../model/recently_viewed_model.dart';

class ProductDetailController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  late bool isLiked = false;
  bool descTextShowFlag = false;

  int current = 0;
  final CarouselController controller = CarouselController();
  final List<Map> colors = [
    {
      'name': 'Grey',
      'color': 0xFFBCBCBC,
    },
    {
      'name': 'Black',
      'color': 0xFF000000,
    },
    {
      'name': 'BlueGrey',
      'color': 0xFFCCD6D4,
    },
    {
      'name': 'LightPink',
      'color': 0xFFE6DBC8,
    }
  ];
  late Map selectedColor;

  @override
  void onInit() {
    selectedColor = colors[1];

    super.onInit();
  }

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

  void changPage(int index) {
    current = index;
    update();
  }

  final List<String> items = ['Sofa', 'Bed'];

  List<SellerOnTmweenModel> sellerOnTmweens = const <SellerOnTmweenModel>[
    const SellerOnTmweenModel(
      amount: '26,500.00',
      charge: '95.00',
      brand: 'LIFESTYLES',
    ),
    const SellerOnTmweenModel(
      amount: '26,500.00',
      charge: '95.00',
      brand: 'LIFESTYLES',
    ),
  ];

  List<ReviewModel> reviews = const <ReviewModel>[
    const ReviewModel(
        rating: '4.1',
        name: 'Alberto Brando',
        date: '21 January 2019',
        desc:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
            'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation '
            'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in '
            'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
            ' sunt in culpa qui officia deserunt mollit anim id est laborum.'),
    const ReviewModel(
        rating: '4.1',
        name: 'Alberto Brando',
        date: '21 January 2019',
        desc:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
            'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation '
            'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in '
            'voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
            ' sunt in culpa qui officia deserunt mollit anim id est laborum.')
  ];

  int val = 1;

  bool isQuantityDiscountExpanded = true;

  void updateQuantityDiscountExpanded() {
    isQuantityDiscountExpanded = !isQuantityDiscountExpanded;
    update();
  }

  bool isProductInfoExpanded = true;

  void updateProductInfoExpanded() {
    isProductInfoExpanded = !isProductInfoExpanded;
    update();
  }

  bool isSpecificationExpanded = false;

  void updateSpecificationExpanded() {
    isSpecificationExpanded = !isSpecificationExpanded;
    update();
  }

  bool isSizeSpecificationExpanded = false;

  void updateSizeSpecificationExpanded() {
    isSizeSpecificationExpanded = !isSizeSpecificationExpanded;
    update();
  }

  bool isDeliveryReturnExpanded = false;

  void updateDeliveryReturnExpanded() {
    isDeliveryReturnExpanded = !isDeliveryReturnExpanded;
    update();
  }

  late final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Image.asset(item, fit: BoxFit.contain),
          ))
      .toList();

  final List<String> imgList = [
    'asset/image/product_detail_page_images/slider_thumb_1.jpg',
    'asset/image/product_detail_page_images/slider_thumb_2.jpg',
    'asset/image/product_detail_page_images/slider_thumb_3.jpg',
    'asset/image/product_detail_page_images/slider_thumb_4.jpg',
    'asset/image/product_detail_page_images/slider_thumb_5.jpg',
  ];

  int quntity = 1;

  List<RecentlyViewedModel> recentlVieweds = const <RecentlyViewedModel>[
    const RecentlyViewedModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: true,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_1.jpg',
    ),
    const RecentlyViewedModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: true,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_2.jpg',
    ),
    const RecentlyViewedModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: false,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_1.jpg',
    ),
    const RecentlyViewedModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: false,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_2.jpg',
    ),
  ];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void navigateToCartScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => DrawerScreen(
                  from: AppConstants.productDetail,
                )),
        (Route<dynamic> route) => false);
  }

  void closeDrawer() {
    Navigator.pop(context);
  }

  void exitScreen() {
    Navigator.of(context).pop();
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
