import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/notification_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

class NotificationController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;

  List<NotificationModel> notifications = const <NotificationModel>[
    const NotificationModel(
      title: 'Tmween - Wallet Credited',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      date: '22 January 2021',
      time: '4:25 PM',
    ),
    const NotificationModel(
      title: 'Tmween - Get an additional SAR 500 OFF',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      date: '15 January 2021',
      time: '10:25 AM',
    ),
    const NotificationModel(
      title: 'Tmween - Checkout your Products',
      desc:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      date: '01 January 2021',
      time: '8:25 PM',
    ),
  ];

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
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
