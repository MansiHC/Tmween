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
  ///Returns first letter of the string as Caps eg -> Flutter
  String firstLetterUpperCase() => length > 1
      ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}"
      : this;

  ///Removes first element
  String get eliminateFirst => length > 1 ? "${substring(1, length)}" : "";

  ///Removes last element
  String get eliminateLast => length > 1 ? "${substring(0, length - 1)}" : "";

  /// Return a bool if the string is null or empty
  bool get isEmpty => trimLeft().isEmpty;

  ///
  /// Uses regex to check if the provided string is a valid email address or not
  ///
  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}
