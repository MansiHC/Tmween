import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/get_sub_category_model.dart';
import '../screens/drawer/category/category_product_listing_screen.dart';
import '../screens/drawer/category/sub_categories_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';

class CategoriesController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = true;
  List<ShopByCategory>? shopByCategory = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;
  List<SubCategoryData>? subCategoryData = [];

  @override
  void onInit() {

    super.onInit();
  }

  Future<void> getCategories(language) async {
    //Helper.showLoading();
    loading = true;
  //  update();
    await api.getAllCategories("1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        shopByCategory = value.data!.productAllCategory;

        update();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      //Helper.hideLoading();
      loading = false;
      update();
    }).catchError((error) {
      // Helper.hideLoading();
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> onRefresh(language) async {
    await api.getAllCategories("1", language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        shopByCategory = value.data!.productAllCategory;
        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<bool> loadMore(language) async {
    update();
    await api.getAllCategories(next, language).then((value) {
      if (value.statusCode == 200) {
        totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;
        shopByCategory?.addAll(value.data!.productAllCategory!);
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
    Get.delete<CategoriesController>();
    Navigator.of(context).pop(false);
  }

  Future<void> getSubCategories(categoryId,categoryName,categorySlug,language) async {
    //Helper.showLoading();
    loading = true;
    update();
    await api.getSubCategories(categoryId, language).then((value) {
      if (value.statusCode == 200) {
        /*   totalPages = value.data!.totalPages!;
        prev =
            value.data!.previous.runtimeType == int ? value.data!.previous : 0;
        next = value.data!.next.runtimeType == int ? value.data!.next : 0;
        totalRecords = value.data!.totalRecords!;*/
        subCategoryData = value.data!.subCategoryData;
        if(subCategoryData!.length==0){
          print('....cateSlug......$categorySlug');
          navigateTo(CategoryProductListingScreen
            ( categorySlug: categorySlug,categoryName: categoryName,fromSubCategory: false,
          categoryId: categoryId,));

        }else{
          navigateTo(SubCategoriesScreen(subCategoryData:subCategoryData!,categoryName: categoryName,categorySlug: categorySlug,));
        }
        update();
      } else {
        Helper.showGetSnackBar(value.message!,  AppColors.errorColor);
      }
      //Helper.hideLoading();
      loading = false;
      update();
    }).catchError((error) {
      // Helper.hideLoading();
      loading = false;
      update();
      print('error....$error');
    });
  }


  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
