import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class DeactivateAccountController extends GetxController {
  late BuildContext context;
  TextEditingController passwordController = TextEditingController();


  void exitScreen() {
    Navigator.of(context).pop();
  }
}
