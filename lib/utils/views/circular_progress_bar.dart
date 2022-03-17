import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/utils/extensions.dart';

import '../global.dart';

class CircularProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // _showDialog(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        5.heightBox,
        Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
            )),
        5.heightBox,
      ],
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
