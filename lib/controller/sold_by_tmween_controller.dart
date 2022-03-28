import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/utils/helper.dart';

import '../model/dashboard_model.dart';
import '../model/sold_by_tmween_model.dart';
import '../service/api.dart';

class SoldByTmweenController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<SoldByTmweenProductData>? soldByTmweenProductData;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    loading = true;
    update();
    await api.getSoldByTmween('en').then((value) {
      if (value.statusCode == 200) {
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

  void exitScreen() {
    Get.delete<SoldByTmweenController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
