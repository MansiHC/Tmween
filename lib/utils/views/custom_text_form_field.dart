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
  final bool? autoFocus;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;

  CustomTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.errorText,
      this.enabled,
      this.onChanged,
      this.suffixIcon,
      this.autoFocus,
      this.obscureText,
      this.isDense,
      this.onTap,
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
      autofocus: autoFocus ?? false,
      enabled: enabled ?? true,
      onTap: onTap ?? () {},
      onChanged: onChanged ?? (text) {},
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
          isDense: isDense ?? false,
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
          prefixIconConstraints: BoxConstraints.loose(Size.square(36)),
          prefixIcon: Padding(padding:EdgeInsets.symmetric(horizontal: 10),child:prefixIcon)),
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
  final bool? filled;
  final int? maxLines;
  final Color? borderColor;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  CustomBoxTextFormField(
      {required this.controller,
      required this.keyboardType,
      required this.hintText,
      this.errorText,
      this.fillColor,
      this.filled,
      this.borderColor,
      this.maxLines,
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
      maxLines: maxLines ?? 1,
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
            borderSide:
                BorderSide(color: borderColor ?? AppColors.lightGrayColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? AppColors.lightGrayColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          filled: filled ?? false,
          fillColor: fillColor ?? Colors.grey,
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
          prefixIconConstraints: BoxConstraints.loose(Size.square(36)),
          suffixIcon: suffixIcon,
          prefixIcon: Padding(padding:EdgeInsets.symmetric(horizontal: 10),child:prefixIcon)),
    );
  }
}
