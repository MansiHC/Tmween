import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/notification_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/notification/notification_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../utils/views/circular_progress_bar.dart';
import '../../drawer_screen.dart';

class NotificationScreen extends StatelessWidget {
  late String language;

  final notificationController = Get.put(NotificationController());

  Future<bool> _onWillPop(NotificationController notificationController) async {
    notificationController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (contet) {
          notificationController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(notificationController),
              child: Scaffold(
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
                          notificationController.isLoading
                              ? Expanded(
                                  child: Center(child: CircularProgressBar()))
                              : notificationController.notifications.length > 0
                                  ? Expanded(
                                      child: SingleChildScrollView(
                                          child: _bottomView(
                                              notificationController)))
                                  : Expanded(
                                      child: Center(
                                          child: Text(
                                        LocaleKeys.noRecords.tr,
                                        style: TextStyle(
                                            color: Color(0xFF414141),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                        ],
                      ))));
        });
  }

  Widget _bottomView(NotificationController notificationController) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(LocaleKeys.readAll.tr,
                style: TextStyle(fontSize: 12, color: Colors.blue)),
          ),
          10.heightBox,
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: notificationController.notifications.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      if (notificationController
                              .notifications[index].redirectTo ==
                          0) {
                        notificationController.readNotifications(
                            notificationController.notifications[index].id,
                            language);
                        Get.deleteAll();
                        Get.offAll(DrawerScreen());
                      }
                    },
                    child: Slidable(
                        key: ValueKey(
                            notificationController.notifications[index]),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {
                            notificationController.deleteNotifications(
                                index,
                                notificationController.notifications[index].id,
                                language);
                          }),
                          children: [
                            SlidableAction(
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              onPressed: (BuildContext context) {
                                notificationController.deleteNotifications(
                                    index,
                                    notificationController
                                        .notifications[index].id,
                                    language);
                              },
                            ),
                          ],
                        ),
                        child: NotificationContainer(
                            notification:
                                notificationController.notifications[index],
                            index: index)));
              })
        ]));
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
