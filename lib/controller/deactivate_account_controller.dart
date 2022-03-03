import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DeactivateAccountController extends GetxController {
  late BuildContext context;
  TextEditingController passwordController = TextEditingController();

  void exitScreen() {
    Navigator.of(context).pop();
  }
}
