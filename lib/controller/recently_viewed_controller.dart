import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/recently_viewed_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class RecentlyViewedController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<RecentlyViewProduct>? recentlyViewProduct;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    loading = true;
    update();
    await api.getRecentlyViewed('en').then((value) {
      if (value.statusCode == 200) {
        recentlyViewProduct = value.data!.recentlyViewProduct;

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

  void exitScreen() {
    Get.delete<RecentlyViewedController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
