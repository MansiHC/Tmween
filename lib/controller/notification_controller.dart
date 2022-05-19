import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/notification_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';

class NotificationController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;

  List<NotificationsData> notifications = [];
  bool isLoading = true;

  final api = Api();

  Future<void> getNotifications(language) async {
    // Helper.showLoading();
    // update();
    await api.getNotifications(language).then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        //  Helper.hideLoading(context);
        notifications = value.data!.notificationsData!;
      } else {
        isLoading = false;
        //  Helper.hideLoading(context);
      }
      update();
    }).catchError((error) {
      // Helper.hideLoading(context);
      isLoading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> readNotifications(notificationId, language) async {
    // Helper.showLoading();
    // update();
    await api.readNotifications(notificationId, language).then((value) {
      //  update();
    }).catchError((error) {
      // Helper.hideLoading(context);
      isLoading = false;
      // update();
      print('error....$error');
    });
  }

  Future<void> deleteNotifications(index, notificationId, language) async {
    // Helper.showLoading();
    // update();
    await api.deleteNotifications(notificationId, language).then((value) {
      if (value.statusCode == 200) {
        notifications.removeAt(index);
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
        update();
      }
      //  update();
    }).catchError((error) {
      // Helper.hideLoading(context);
      // isLoading = false;
      // update();
      print('error....$error');
    });
  }

  void exitScreen() {
    Get.delete<NotificationController>();
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  @override
  void onInit() {
    getNotifications(Get.locale!.languageCode);
    super.onInit();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
