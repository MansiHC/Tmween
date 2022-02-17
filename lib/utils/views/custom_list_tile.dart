import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String leadingIcon;

  CustomListTile(
      {required this.title, required this.onTap, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    /* return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 15),
      title: Text(
        title.tr(),
        style: TextStyle(fontSize: 15),
      ),
      minLeadingWidth: 24,
      leading: SvgPicture.asset(
        leadingIcon,
        height: 24,
        width: 24,
      ),
    );*/
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                SvgPicture.asset(
                  leadingIcon,
                  height: 24,
                  width: 24,
                ),
                20.widthBox,
                Text(
                  title.tr,
                  style: TextStyle(fontSize: 15),
                )
              ],
            )));
  }
}
