import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;
  final Color? backgroundColor;
  final double? horizontalPadding;

  CustomButton(
      {required this.text, required this.onPressed, this.width, this.fontSize,this.backgroundColor,this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? double.infinity,
        child: ElevatedButton(
          child: Text(
            text.tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: fontSize ?? 20),
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor??AppColors.primaryColor),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: horizontalPadding??50, vertical: 10)),
          ),
        ));
  }
}
