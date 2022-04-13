import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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

class FilterController extends GetxController {
  late BuildContext context;
  late int catId;

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

  void updateShowOnlyExpanded() {
    isShowOnlyExpanded = !isShowOnlyExpanded;
    update();
  }
  final api = Api();
  bool loading = false;
  late GetFilterData filteredData;

  Future<void> getFilterData(language) async {
    Helper.showLoading();
    await api.getFilterData("1", catId, language).then((value) {

      if (value.statusCode == 200) {
filteredData = value.data!;
      }
      Helper.hideLoading(context);
      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }


  final List<Map> categoryList = [
    {'title': 'Mobile Phone Accessories', 'isChecked': false},
    {'title': 'HeadPhone & Headsets', 'isChecked': false},
    {'title': 'Screen Protectors', 'isChecked': true},
    {'title': 'Cabel', 'isChecked': false},
  ];

  bool isCategoryExpanded = true;

  void updateCategoryExpanded() {
    isCategoryExpanded = !isCategoryExpanded;
    update();
  }

  final List<Map> brandList = [
    {'title': 'Other', 'isChecked': false},
    {'title': 'Puro', 'isChecked': false},
    {'title': 'Samsung', 'isChecked': true},
    {'title': 'Apple', 'isChecked': false},
  ];

  bool isBrandExpanded = true;

  void updateBrandExpanded() {
    isBrandExpanded = !isBrandExpanded;
    update();
  }

  final List<Map> sellerList = [
    {'title': 'ABC', 'isChecked': false},
    {'title': 'XYZ', 'isChecked': true},
  ];

  bool isSellerExpanded = true;
  bool isPriceExpanded = true;

  double priceRange = 0;
  RangeValues currentRangeValues = const RangeValues(0, 200);

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

  final List<Map> collectionList = [
    {'title': 'Other', 'isChecked': false},
    {'title': 'Puro', 'isChecked': false},
    {'title': 'Samsung', 'isChecked': true},
    {'title': 'Apple', 'isChecked': false},
  ];

  bool isCollectionExpanded = true;

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
}
