import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/address_model.dart';

import '../model/get_customer_address_list_model.dart';
import '../model/product_listing_model.dart';
import '../model/recently_viewed_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class SearchController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  int val = 1;




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

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;
  bool searchLoading = false;
  List<Address> addressList = [];
  List<ProductData> productList = [];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
  bool isLogin = true;
  String image = "", address = "";

  @override
  void onInit() {
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      isLogin = value!;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      if (value != null) address = value;
      update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.image)
        .then((value) async {
      image = value!;
      update();
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
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  void searchProduct(suggestion,language){
    visibleList = true;
    searchController.text = suggestion;
update();
getProductList(language);
  }

  Future<void> getProductList(language) async {
    productList = [];
    searchLoading = true;
    update();
    await api.topSearchSuggestionProductList(searchController.text,userId,isLogin, language).then((value) {
      if (value.statusCode == 200) {

        productList = value.data!;
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
      }
      searchLoading = false;
      update();
    }).catchError((error) {
      searchLoading = false;
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
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
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
