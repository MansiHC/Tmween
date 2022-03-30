import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/popular_search_model.dart';
import 'package:tmween/screens/drawer/search_screen.dart';

import '../model/get_customer_address_list_model.dart';
import '../model/product_listing_model.dart';
import '../model/search_history_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/animations.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class ProductListingController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int val = 1;
  var searchedString = '';

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;
  bool searchLoading = false;
  List<Address> addressList = [];
  List<ProductData> productList = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
  void navigateToSearchScreen(String from) {
    Get.delete<ProductListingController>();
    Navigator.pushReplacement(context,CustomPageRoute( SearchScreen(from: from,searchText: searchedString,)));
  }

  bool isLogin = true;
  String image = "", address = "";

  @override
  void onInit() {

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

  Future<void> getProductList(searchString,language) async {
    productList = [];
    searchLoading = true;
    update();
    await api
        .topSearchSuggestionProductList(
            "1", searchString, userId, isLogin, language)
        .then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        productList = value.data!.productData!;
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

  Future<bool> loadMore(language) async {
    update();
    await api
        .topSearchSuggestionProductList(
            next, searchedString, userId, isLogin, language)
        .then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        productList.addAll(value.data!.productData!);
        update();
        return true;
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
      return false;
    });
    return false;
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
        Get.delete<ProductListingController>();
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
    Get.delete<ProductListingController>();
    Navigator.of(context).pop();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
