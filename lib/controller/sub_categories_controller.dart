import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_sub_category_model.dart';

import '../service/api.dart';

class SubCategoriesController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<SubCategoryData>? subCategoryData = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;
  late String categoryName;
  late String categorySlug;

  @override
  void onInit() {
    super.onInit();
  }

  void exitScreen() {
    Get.delete<SubCategoriesController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
