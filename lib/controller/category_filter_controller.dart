import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/category/category_product_listing_screen.dart';

import '../lang/locale_keys.g.dart';
import '../model/get_filter_data_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class League {
  String leagueName;
  List<Club> listClubs;

  League(this.leagueName, this.listClubs);
}

class Club {
  String clubName;
  List<Player> listPlayers;

  Club(this.clubName, this.listPlayers);
}

class Player {
  String playerName;

  Player(this.playerName);
}

class CategoryFilterController extends GetxController {
  late BuildContext context;
  late String catSlug;
  late int catId;
  late String catName;

  final List<Map> showOnlyList = [
    {
      'title': '${LocaleKeys.fulfilledBy.tr} ${LocaleKeys.appTitle.tr}',
      'isChecked': false
    },
    {
      'title': '${LocaleKeys.deal.tr}&${LocaleKeys.ofTheDay.tr}',
      'isChecked': true
    },
  ];

  bool isShowOnlyExpanded = true;
  bool isCategoryExpanded = true;

  bool isBrandExpanded = true;
  bool isSellerExpanded = true;
  bool isPriceExpanded = true;

  double priceRange = 0;
  late RangeValues currentRangeValues;

   List<Map> categoryList = [];
   List<Map> brandList = [];
   List<Map> sellerList = [];
  List<String> productCatIdList = [];
  List<String> brandIdList = [];
  List<String> sellerIdList = [];


  final List<Map> collectionList = [
    {'title': 'Other', 'isChecked': false},
    {'title': 'Puro', 'isChecked': false},
    {'title': 'Samsung', 'isChecked': true},
    {'title': 'Apple', 'isChecked': false},
  ];

  bool isCollectionExpanded = true;

  final api = Api();
  bool loading = true;
   GetFilterData? filteredData;
  int fromPrice=0,toPrice=0,fullFillByTmween=0;
bool called=false;
  @override
  void onInit() {
//    getFilterData(Get.locale!.languageCode);
    super.onInit();
  }

  Future<void> getFilterData(language) async {
    // Helper.showLoading();
    loading = true;
    categoryList=[];
    brandList=[];
    sellerList=[];
    await api
        .getCategoryMobileFilterData(catSlug,language)
        .then((value) {
      if (value.statusCode == 200) {
        called=true;
        filteredData = value.data!;
        if (filteredData!.productCategory != null)
        for (var i = 0; i < filteredData!.productCategory!.length; i++) {
          categoryList.add({
            'title': filteredData!.productCategory![i].categoryName,
            'id': filteredData!.productCategory![i].id,
            'count': filteredData!.productCategory![i].count,
            'isChecked': false
          });
        }
        if (filteredData!.brand != null)
        for (var i = 0; i < filteredData!.brand!.length; i++) {
          brandList.add({
            'title': filteredData!.brand![i].brandName,
            'id': filteredData!.brand![i].id,
            'count': filteredData!.brand![i].count,
            'isChecked': false
          });
        }
        if (filteredData!.suppliersData != null)
        for (var i = 0; i < filteredData!.suppliersData!.length; i++) {
          sellerList.add({
            'title': filteredData!.suppliersData![i].supplierName,
            'id': filteredData!.suppliersData![i].supplierId,
            'count': 0,
            'isChecked': false
          });
        }
        currentRangeValues =
            RangeValues(0, double.parse(filteredData!.maxPrice!.toString()));
        fromPrice =0;
        toPrice = filteredData!.maxPrice!;
      }
      loading = false;
      //  Helper.hideLoading(context);
      update();
    }).catchError((error) {
      //   Helper.hideLoading(context);
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> setFilter(language) async {
    Navigator.of(context).pop(false);
    productCatIdList=[];
    brandIdList=[];
    sellerIdList=[];
    var catList = categoryList.where((i) => i['isChecked']).toList();
    for (var i in catList) {
      productCatIdList.add(i['id'].toString());
    }
    var brList = brandList.where((i) => i['isChecked']).toList();
    for (var i in brList) {
      brandIdList.add(i['id'].toString());
    }
    var selList = sellerList.where((i) => i['isChecked']).toList();
    for (var i in selList) {
      sellerIdList.add(i['id'].toString());
    }
   fromPrice =currentRangeValues.start.round();
   toPrice =currentRangeValues.end.round();
    var showOnlyCheckedList = showOnlyList.where((i) => i['isChecked']).toList();
    if(showOnlyCheckedList.contains(LocaleKeys.fulfilledBy.tr)){
      fullFillByTmween =1;
    }

    print('object.....$productCatIdList...$brandIdList....$sellerIdList....$fromPrice....$toPrice...$fullFillByTmween');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
        CategoryProductListingScreen(categorySlug: catSlug, categoryName: catName,
        categoryId: catId,
        fromFilter: true,catIdList: productCatIdList,
        brandIdList: brandIdList,sellerIdList: sellerIdList,fromPrice: fromPrice,toPrice: toPrice,fullFillByTmween:fullFillByTmween)));

  }

  void updateShowOnlyExpanded() {
    isShowOnlyExpanded = !isShowOnlyExpanded;
    update();
  }

  void updateCategoryExpanded() {
    isCategoryExpanded = !isCategoryExpanded;
    update();
  }

  void updateBrandExpanded() {
    isBrandExpanded = !isBrandExpanded;
    update();
  }

  void updatePrice(double value) {
    priceRange = value;
    update();
  }

  void updateSellerExpanded() {
    isSellerExpanded = !isSellerExpanded;
    update();
  }

  void updatePriceExpanded() {
    isPriceExpanded = !isPriceExpanded;
    update();
  }

  void updateCollectionExpanded() {
    isCollectionExpanded = !isCollectionExpanded;
    update();
  }

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

  void exitScreen() {
    //Get.delete<CategoryFilterController>();
    Navigator.of(context).pop(false);
  }
}
