import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/best_seller_model.dart';
import '../model/dashboard_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class BestSellerController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<BestSellerData>? bestSellerData;
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    loading = true;
    update();
    await api.getBestSeller("1",'en').then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev = value.data!.previous.runtimeType == int?value.data!.previous:0;
        next = value.data!.next.runtimeType == int?value.data!.next:0;
        totalRecords = value.data!.totalRecords!;
        bestSellerData = value.data!.bestSellerData;
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

  Future<bool> loadMore() async {
    update();
    await api.getBestSeller(next,'en').then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev = value.data!.previous.runtimeType == int?value.data!.previous:0;
        next = value.data!.next.runtimeType == int?value.data!.next:0;
        totalRecords = value.data!.totalRecords!;
        bestSellerData = value.data!.bestSellerData;
        update();
        return true;
      }
      update();
    }).catchError((error) {
return false;
      update();
      print('error....$error');
    });
    return false;
  }

  void exitScreen() {
    Get.delete<BestSellerController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
