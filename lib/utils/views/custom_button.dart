import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;

  CustomButton({required this.text, required this.onPressed, this.width,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? double.infinity,
        child: ElevatedButton(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize:fontSize?? 20),
          ).tr(),
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
          ),
        ));
  }
}
