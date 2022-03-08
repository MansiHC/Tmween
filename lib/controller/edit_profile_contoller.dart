import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  late BuildContext context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  TextEditingController num3Controller = TextEditingController();
  TextEditingController num4Controller = TextEditingController();

  bool enablePhone = true;
  bool enableEmail = true;
  final formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? image;
  File? sample;
  File? lastCropped;
  File? finalImage;
  final cropKey = GlobalKey<CropState>();
  String imageString = "";

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void getProfileDetails() {
    nameController.text = 'Salim';
    lastNameController.text = 'Akka';
    mobileNumberController.text = '+249 9822114455';
    emailController.text = 'salim.akka@tmween.com';
  }

  void enableMobileNumber() {
    enablePhone = false;
    update();
  }

  void enableEmailAddress() {
    enableEmail = false;
    update();
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void notifyClick1(bool click) {
    click1 = click;
    update();
  }

  void notifyClick2(bool click) {
    click2 = click;
    update();
  }

  void notifyClick3(bool click) {
    click3 = click;
    update();
  }

  void notifyClick4(bool click) {
    click4 = click;
    update();
  }
}
