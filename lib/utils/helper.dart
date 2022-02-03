import 'package:flutter/material.dart';

import 'global.dart';

class Helper {
  static List<String> supportedLanguages = [
    LanguageConstant.english,
    LanguageConstant.arabian
  ];

  static List<String> supportedLanguagesCodes = [
    "en",
    "ar",
  ];

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
