import 'package:flutter/material.dart';

class Helper {
  static void showSnackBar(BuildContext context, String message) {
    var snackBar = SnackBar(
      animation: null,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
        onPressed: () {},
        label: 'ok',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
