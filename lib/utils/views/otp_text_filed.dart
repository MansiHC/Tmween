import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global.dart';

class OtpTextFormField extends StatelessWidget {
  final bool clicked;
  final GestureTapCallback onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  OtpTextFormField(
      {required this.clicked,
      required this.onTap,
        this.onSubmitted,
      required this.onChanged,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 50,
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: onChanged,
        showCursor: false,

        readOnly: false,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24, color: clicked ? Colors.white : Colors.black),
        keyboardType: TextInputType.number,
        onTap: onTap,
        maxLength: 1,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
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
