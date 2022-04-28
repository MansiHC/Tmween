import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/get_recommended_product_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';

class RecommendedProductController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<RecommendationProducts>? recommendedProductData = [];
List<String> productIdList=[];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;

  @override
  void onInit() {

    super.onInit();
  }

  Future<void> getData(language) async {
   // Helper.showLoading();
    loading =true;
    update();
    await api.getRecommendedProduct(productIdList,"1", language).then((value) {
      if (value.statusCode == 200) {

        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous!.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next!.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recommendedProductData = value.data!.recommendationProducts;
       // Helper.hideLoading(context);
        loading=false;

      } else {
       // Helper.hideLoading(context);
        loading=false;

        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }

      update();
    }).catchError((error) {
    //  Helper.hideLoading(context);
      loading=false;
      update();
      print('error....$error');
    });
  }

  Future<void> onRefresh(language) async {
    await api.getRecommendedProduct(productIdList,"1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recommendedProductData = value.data!.recommendationProducts;
        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> loadMore(language) async {
    update();
    await api.getRecommendedProduct(productIdList,next, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        recommendedProductData?.addAll(value.data!.recommendationProducts!);
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
    Get.delete<RecommendedProductController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}