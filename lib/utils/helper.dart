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

  static void showLoading() {
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
              padding: EdgeInsets.all(10),
              /*  decoration: BoxDecoration(
                color: Colors.white,
              shape: BoxShape.circle
            ),*/
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryColor,
              )),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading(context) {
    //Get.back();
    Navigator.of(context).pop();
  }

  /*static void showSnackBar(BuildContext context, String message) {
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

  }*/

  static bool isIndividual = false;

  static void showGetSnackBar(String message) {
    Get.snackbar(
      message,
      "",
      animationDuration: 100.milliseconds,
      duration: 1.seconds,
      snackPosition: SnackPosition.BOTTOM,
      showProgressIndicator: false,
      isDismissible: false,
      backgroundColor: AppColors.appBarColor,
      colorText: Colors.white,
    );
  }

  static void showGetSnackBar2(String message) {
    Get.snackbar(
      message,
      "",
      duration: 6.seconds,
      snackPosition: SnackPosition.BOTTOM,
      showProgressIndicator: false,
      isDismissible: false,
      backgroundColor: AppColors.appBarColor,
      colorText: Colors.white,
    );
  }
}
