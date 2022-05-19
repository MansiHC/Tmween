import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/model/notification_model.dart';
import 'package:tmween/utils/extensions.dart';

class NotificationContainer extends StatelessWidget {
  NotificationContainer(
      {Key? key, required this.notification, required this.index})
      : super(key: key);
  final NotificationsData notification;
  final int index;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: notification.isRead == 1 ? Color(0xFFF7F7F7) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            5.heightBox,
            Text(
              notification.title!,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF393939)),
            ),
            10.heightBox,
            Text(
              notification.message!,
              style: TextStyle(fontSize: 14, color: Color(0xFF7D7D7D)),
            ),
            5.heightBox,
            Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      notification.createdAtDisplay!,
                      style: TextStyle(fontSize: 12, color: Color(0xFF7D7D7D)),
                    ),
                    /*5.widthBox,
                    Text(
                      notification.time,
                      style: TextStyle(fontSize: 12, color: Color(0xFF7D7D7D)),
                    ),*/
                  ],
                )),
            /*5.heightBox,
            Align(
              alignment: Alignment.centerRight,
              child: Text(LocaleKeys.readMore.tr,
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
            ),*/
          ]),
    );
  }
}
