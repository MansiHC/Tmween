import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/product_detail_controller.dart';
import 'package:tmween/model/address_model.dart';
import 'package:tmween/screens/drawer/search_screen.dart';

import '../model/get_customer_address_list_model.dart';
import '../model/recently_viewed_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'drawer_controller.dart';

class SearchController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  int val = 1;

  final List<String> items = ['Sofa', 'Bed'];

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
    'Computer and Gaming',
  ];
  final List<String> popularSearchList = [
    'Watches',
    'Sunglasses',
    'Furniture',
    'Outdoor',
    'Sport,Fitness and Outdoor',
    'Jewelry',
    'Computer and Gaming',
  ];

  List<RecentlyViewedModel> recentlVieweds = const <RecentlyViewedModel>[
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: true,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
    const RecentlyViewedModel(
        title: 'WOW Raw Apple Cider Vinegar 750 ml',
        fulfilled: false,
        offer: '35',
        rating: '4.1',
        price: '2450',
        beforePrice: '7000',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
  ];

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;
  List<Address> addressList = [];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  @override
  void onInit() {
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
        Get.delete<DrawerControllers>();
        Get.offAll(DrawerScreen());
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
        Get.delete<SearchController>();
        Navigator.of(context).pop(true);
     update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.delete<DrawerControllers>();
        Get.offAll(DrawerScreen());
      }
      Helper.showGetSnackBar(value.message!);
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  void popp() {
    Navigator.pop(context);
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exitScreen() {
    Get.delete<SearchController>();
    Navigator.of(context).pop();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
