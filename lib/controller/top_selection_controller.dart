import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/top_selection_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class TopSelectionController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();

  final api = Api();
  bool loading = false;
  List<TopSelectionData>? topSelectionData;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    loading = true;
    update();
    await api.getTopSelection('en').then((value) {
      if (value.statusCode == 200) {
        topSelectionData = value.data!.topSelectionData;

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
    Get.delete<TopSelectionController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
