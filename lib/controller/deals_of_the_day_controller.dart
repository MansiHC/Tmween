import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/deals_of_the_day_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class DealsOfTheDayController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();
  final api = Api();
  bool loading = false;
  List<DailyDealsData>? dailyDealsData;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    loading = true;
    update();
    await api.getDealsOfTheDay('en').then((value) {
      if (value.statusCode == 200) {
        dailyDealsData = value.data!.dailyDealsData;

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
    Get.delete<DealsOfTheDayController>();
    Navigator.of(context).pop(false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
