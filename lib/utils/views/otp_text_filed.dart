import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global.dart';

class OtpTextFormField extends StatelessWidget {
  final bool clicked;
  final GestureTapCallback onTap;
  final ValueChanged<String>? onChanged;

  OtpTextFormField(
      {required this.clicked, required this.onTap, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: true,
        onChanged: onChanged,
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, color: clicked ? Colors.white : Colors.black),
        keyboardType: TextInputType.number,
        onTap: onTap,
        maxLength: 1,
        decoration: InputDecoration(
          counter: Offstage(),
          fillColor:
              clicked ? AppColors.primaryColor : AppColors.lightGrayColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
