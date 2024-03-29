import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/controller/filter_controller.dart';
import 'package:tmween/screens/drawer/search/search_screen.dart';

import '../model/get_customer_address_list_model.dart';
import '../model/product_listing_model.dart';
import '../model/sub_category_product_listing_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../screens/drawer/productDetail/product_detail_screen.dart';
import '../service/api.dart';
import '../utils/animations.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ProductListingController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int val = 1;
  var searchedString = '';
  var from = '';
  bool fromFilter = false;

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool loading = false;
  bool searchLoading = false;
  bool addressFromCurrentLocation = false;
  List<Address> addressList = [];
  List<SearchProductData> productList = [];
  List<ProductData> productFilterList = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;
  int? fromPrice;
  int? toPrice;
  int? fullFillByTmween;
  List<String>? catIdList;
  List<String>? brandIdList;
  List<String>? sellerIdList;

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void navigateToSearchScreen(String from) {
    Get.delete<ProductListingController>();
    Navigator.pushReplacement(
        context,
        CustomPageRoute(SearchScreen(
          from: from,
          searchText: searchedString,
        )));
  }

  void navigateToProductDetailScreen(int productId, String productSlug) {
    Get.delete<ProductListingController>();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                productId: productId, productslug: productSlug))).then((value) {
      if (value) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
      }
    });
  }

  bool isLogin = true;
  String image = "", address = "";

  @override
  void onInit() {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      if (value != null) address = value;
      print('......$value');
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
    Helper.showLoading();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        addressList = value.data!;
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getFilterResult(language) async {
    productFilterList = [];
    Helper.showLoading();
    print('.............${searchedString}....$fromPrice....$toPrice');

    await api
        .setSearchMobileFilterData(
            "1",
            searchedString,
            catIdList,
            brandIdList,
            sellerIdList,
            fromPrice.toString(),
            toPrice.toString(),
            fullFillByTmween.toString(),
            language)
        .then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        productFilterList = value.data!.productData!;
      }
      Helper.hideLoading(context);
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getBestMatchResult(sortBy, sortOrder, language) async {
    productFilterList = [];
    fromFilter = true;
    Helper.showLoading();
    print('.............${searchedString}....$sortBy....$sortOrder');

    await api
        .getSearchMobileBestMatchData(
            "1",
            searchedString,
            sortBy,
            sortOrder,
            catIdList,
            brandIdList,
            sellerIdList,
            fromPrice.toString(),
            toPrice.toString(),
            fullFillByTmween.toString(),
            language)
        .then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        productFilterList = value.data!.productData!;
      }
      Helper.hideLoading(context);
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getProductList(searchString, language) async {
    productList = [];
    Helper.showLoading();
    await api
        .topSearchSuggestionProductList(
            "1", searchString, userId, isLogin, language)
        .then((value) {
      Helper.hideLoading(context);
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
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
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

  Future<bool> loadMoreFilter(language) async {
    update();
    await api
        .setSearchMobileFilterData(
            next,
            searchedString,
            catIdList,
            brandIdList,
            sellerIdList,
            fromPrice.toString(),
            toPrice.toString(),
            fullFillByTmween.toString(),
            language)
        .then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        productFilterList.addAll(value.data!.productData!);
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
    Helper.showLoading();
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
      Helper.hideLoading(context);
      update();
      if (value.statusCode == 200) {
        // Get.delete<ProductListingController>();
        Navigator.of(context).pop(true);
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListingScreen(
                  from: from,
                  searchString: searchedString,
                )));
        update();*/
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.address)
            .then((value) async {
          address = value!;
          update();
        });
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
    }).catchError((error) {
      Helper.hideLoading(context);
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
    Get.delete<FilterController>();
    Navigator.of(context).pop();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
