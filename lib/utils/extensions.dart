import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NumExtension on num {
  Widget get widthBox => SizedBox(
        width: toDouble(),
      );

  Widget get heightBox => SizedBox(
        height: toDouble(),
      );
}

extension StringExtension on String {
  String firstLetterUpperCase() => length > 1
      ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}"
      : this;

  String get eliminateFirst => length > 1 ? "${substring(1, length)}" : "";

  String get eliminateLast => length > 1 ? "${substring(0, length - 1)}" : "";

  bool get isEmpty => trimLeft().isEmpty;

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}
