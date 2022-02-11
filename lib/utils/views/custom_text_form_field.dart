import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  CustomTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.suffixIcon,
      this.obscureText,
      this.inputFormatters,
      required this.validator,
      this.textInputAction,
      this.prefixIcon,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      validator: validator,
      onFieldSubmitted: onSubmitted ??
          (term) {
            FocusScope.of(context).nextFocus();
          },
      textInputAction: textInputAction ?? TextInputAction.next,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          fillColor: Colors.grey,
          errorMaxLines: 2,
          hintText: hintText.tr(),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
    );
  }
}
