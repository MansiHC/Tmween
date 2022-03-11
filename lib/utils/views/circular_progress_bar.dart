import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/utils/extensions.dart';

import '../global.dart';

class CircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      5.heightBox,
      Align(
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(
          backgroundColor:
          AppColors.primaryColor,
        )),
    5.heightBox,
    ],);
  }
}