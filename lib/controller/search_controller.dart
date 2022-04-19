import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/popular_search_model.dart';
import 'package:tmween/screens/drawer/search/product_listing_screen.dart';
import 'package:tmween/utils/animations.dart';

import '../model/product_listing_model.dart';
import '../model/search_history_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class SearchController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;
  int val = 1;
  var searchedString = '';

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  final api = Api();
  bool historyLoading = false;
  List<SearchHistoryData> historyList = [];
  List<PopularSearches> popularList = [];
  List<ProductData> productList = [];
  List<String> searchList = [];

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  bool isLogin = true;
  String image = "", address = "";

  @override
  void onInit() {
    print('...........#############################');
    searchList = [];
    getPopularList(Get.locale!.languageCode);
    // getFilterData(Get.locale!.languageCode);
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

  Future<void> getFilterData(language) async {
    await api.getFilterData('1', 'fresh', language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> getHistoryList(language) async {
    historyList = [];
    searchList = [];

    await api.getSearchHistory(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        historyList = value.data!.searchHistoryData!;
        for (var i = 0; i < historyList.length; i++) {
          searchList.add(historyList[i].keyword!);
        }
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      // Helper.hideLoading();
      historyLoading = false;
      update();
    }).catchError((error) {
      // Helper.hideLoading();
      historyLoading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> clearHistoryList(language) async {
    await api.clearSearchHistory(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        historyList.clear();
        searchList.clear();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
    });
  }

  Future<void> getPopularList(language) async {
    popularList = [];
    //  Helper.showLoading();
    historyLoading = true;
    update();
    await api.getPopularSearch(language).then((value) {
      if (value.statusCode == 200) {
        popularList = value.data!.popularSearches!;
        if (isLogin)
          getHistoryList(Get.locale!.languageCode);
        else {
          // Helper.hideLoading();
          historyLoading = false;
          update();
        }
      }
    }).catchError((error) {
      // Helper.hideLoading();
      historyLoading = false;
      update();
      print('error....$error');
    });
  }

  void searchProduct(from, language) {
    visibleList = true;
    searchController.text = searchedString;
    update();
    Get.delete<SearchController>();
    print('...ff......${searchController.text}');
    Navigator.pushReplacement(
        context,
        CustomPageRoute(ProductListingScreen(
          from: from,
          searchString: searchController.text,
        )));
  }

  void popp() {
    Navigator.pop(context);
  }

  Future<List<String>> getProductList(searchString, language) async {
    productList = [];
    await api
        .topSearchSuggestionProductList(
            "1", searchString, userId, false, language)
        .then((value) {
      if (value.statusCode == 200) {
        productList = value.data!.productData!;

        for (var i = 0; i < productList.length; i++) {
          if (productList[i].productSlug == null) {
            //  productList.removeAt(i);
          } else {
            print(
                '....gffg...$searchString....${searchList.toSet().toList().toString()}');
            searchList.add(productList[i].productName!);
          }
        }

        print('......${searchList.toSet().toList().toString()}');

        return searchList.toSet().toList();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
    }).catchError((error) {});
    return searchList.toSet().toList();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exitScreen() {
    Get.delete<SearchController>();
    Navigator.of(context).pop(true);
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
