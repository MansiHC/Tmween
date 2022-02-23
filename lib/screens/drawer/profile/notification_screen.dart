import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/controller/notification_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/screens/drawer/profile/notification_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/add_address_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


class NotificationScreen extends StatelessWidget {
  late String language;

  final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (contet) {
          notificationController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(notificationController)),
                      _bottomView(notificationController),
                    ],
                  )));
        });
  }

  Widget _bottomView(NotificationController notificationController) {
    return Expanded(
        child:Container(
                margin: EdgeInsets.all(
                  15,
                ),
                child: ListView.builder(
                    itemCount: notificationController.notifications.length,
                    itemBuilder: (context, index) {
                      return NotificationContainer(
                          notification:
                          notificationController.notifications[index],index:index);
                    })));
  }

  Widget topView(NotificationController notificationController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        notificationController.exitScreen();
                      },
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.notifications.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
