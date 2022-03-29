import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/select_category_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class CategoriesController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();


  final api = Api();
  bool loading = false;
  List<ShopByCategory>? shopByCategory = [];
  int totalPages = 0;
  int prev = 0;
  int next = 0;
  int totalRecords = 0;

  @override
  void onInit() {
    getCategories(Get.locale!.languageCode);
    super.onInit();
  }

  Future<void> getCategories(language) async {
    loading = true;
    update();
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
}
