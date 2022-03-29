import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/utils/helper.dart';

import '../model/dashboard_model.dart';
import '../service/api.dart';

class SoldByTmweenController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<SoldByTmweenProductData>? soldByTmweenProductData = [];
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
    loading = true;
    update();
    await api.getSoldByTmween("1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        soldByTmweenProductData = value.data!.soldByTmweenProductData;

        update();
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
  Future<void> onRefresh(language) async {
    await api.getSoldByTmween("1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
        value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        soldByTmweenProductData = value.data!.soldByTmweenProductData;
        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> loadMore(language) async {
    update();
    await api.getSoldByTmween(next, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        soldByTmweenProductData?.addAll(value.data!.soldByTmweenProductData!);
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
    Get.delete<SoldByTmweenController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
