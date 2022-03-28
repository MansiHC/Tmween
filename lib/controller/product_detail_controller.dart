import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/review_model.dart';
import 'package:tmween/model/seller_on_tmween_model.dart';
import 'package:tmween/screens/drawer/dashboard/product_detail_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/utils/global.dart';

import '../model/address_model.dart';
import '../model/get_customer_address_list_model.dart';
import '../model/recently_viewed_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'dashboard_controller.dart';
import 'drawer_controller.dart';

class ProductDetailController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  late bool isLiked = false;
  bool descTextShowFlag = false;

  int current = 0;
  int productId = 0;
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
  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;

  List<Address> addressList = [];
  bool isLogin = true;

  @override
  void onInit() {
    isLiked = false;
    selectedColor = colors[1];
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {

      isLogin = value!;
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
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

  Future<void> addToWishlist(language) async {
    addressList = [];
    print('add......$productId');
    await api.addDataToWishlist(token, userId, productId,language).then((value) {
      if (value.statusCode == 200) {
        isLiked = true;
        update();
        Helper.showGetSnackBar(value.message!);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }else{
        Helper.showGetSnackBar(value.message!);
      }

    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> removeWishlistProduct( language) async {
    //  if (Helper.isIndividual) {
    print('remove......');
    await api.deleteWishListDetails(token, productId, userId, language).then((value) {
      if (value.statusCode == 200) {
        isLiked = false;
        update();
        Helper.showGetSnackBar(value.message!);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }else{
        Helper.showGetSnackBar(value.message!);
      }
      Helper.showGetSnackBar(value.message!);
      update();
    }).catchError((error) {
      print('error....$error');
    });
    //  }
  }

  Future<void> getAddressList(language) async {
    addressList = [];
    loading = true;
    update();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        addressList = value.data!;

      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> editAddress(
      id,
      fullName,
      address1,
      address2,
      landmark,
      country,
      state,
      city,
      zip,
      mobile,
      addressType,
      deliveryInstruction,
      defaultValue,
      language) async {

    loading = true;
    update();
    await api
        .editCustomerAddress(
        token,
        id,
        userId,
        fullName,
        address1,
        address2,
        landmark,
        country,
        state,
        city,
        zip,
        mobile,
        addressType,
        deliveryInstruction,
        defaultValue,
        language)
        .then((value) {
      loading = false;
      update();
      if (value.statusCode == 200) {
        Get.delete<ProductDetailController>();
        Navigator.of(context).pop(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
            ProductDetailScreen()));
        update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }

    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
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

  List<RecentlyViewdModel> recentlVieweds = const <RecentlyViewdModel>[
    const RecentlyViewdModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: true,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_1.jpg',
    ),
    const RecentlyViewdModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: true,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_2.jpg',
    ),
    const RecentlyViewdModel(
      title: 'WOW Raw Apple Cider Vinegar 750 ml',
      fulfilled: false,
      offer: '35',
      rating: '4.1',
      price: '2450',
      beforePrice: '7000',
      image: 'asset/image/product_detail_page_images/similar_product_img_1.jpg',
    ),
    const RecentlyViewdModel(
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
    Get.delete<ProductDetailController>();
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
