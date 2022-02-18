import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../global.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  CustomTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.errorText,
      this.suffixIcon,
      this.obscureText,
      this.isDense,
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
        isDense: isDense??false,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkblue),
          ),
          fillColor: Colors.grey,
          errorMaxLines: 2,
          hintText: hintText.tr,
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

class CustomBoxTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  CustomBoxTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.errorText,
      this.suffixIcon,
      this.obscureText,
      this.readOnly,
      this.inputFormatters,
      required this.validator,
      this.textInputAction,
      this.prefixIcon,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
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
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrayColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrayColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          fillColor: Colors.grey,
          errorMaxLines: 2,
          hintText: hintText.tr,
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
