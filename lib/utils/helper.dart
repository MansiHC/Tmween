import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/global.dart';

class Helper {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 14.0);
  }

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
        textColor: Colors.white,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  static void showGetSnackBar(String message) {
    /*var snackBar = SnackBar(
      animation: null,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
        onPressed: () {},
        label: 'ok',
        textColor: Colors.white,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/
    Get.snackbar(
      message,
      "",
      duration: 2.seconds,
      snackPosition: SnackPosition.BOTTOM,
      showProgressIndicator: false,
      isDismissible: false,
      backgroundColor: AppColors.appBarColor,
      colorText: Colors.white,
    );
  }
}
