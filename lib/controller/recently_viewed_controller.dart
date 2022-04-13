import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class RecentlyViewedController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<RecentlyViewProduct>? recentlyViewProduct = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;

  @override
  void onInit() {
    getData(Get.locale!.languageCode);
    super.onInit();
  }

  Future<void> getData(language) async {
    Helper.showLoading();
    await api.getRecentlyViewed("1", language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct = value.data!.recentlyViewProduct;

        update();
      } else {
        Helper.showGetSnackBar(value.message!);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> onRefresh(language) async {
    await api.getRecentlyViewed("1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
        value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct = value.data!.recentlyViewProduct;

        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> loadMore(language) async {
    update();
    await api.getRecentlyViewed(next, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recentlyViewProduct?.addAll(value.data!.recentlyViewProduct!);
        print('ydgsyudgfyuy.........${recentlyViewProduct!.length}');

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

  void exitScreen() {
    Get.delete<RecentlyViewedController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
