import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  late BuildContext context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController emailOTPController = TextEditingController();
  TextEditingController mobileOTPController = TextEditingController();
  String currentText = "";

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

  void updateNameImage() {
    FocusScope.of(context).unfocus();
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

  void updateMobileNumber() {
   // pop();
  }

  void updateEmail() {
   // pop();
  }

  void resendEmailOTP() {}

  void resendMobileNumberOTP() {}

  void enableEmailAddress() {
    enableEmail = false;
    update();
  }

  void exitScreen() {
    Get.delete<EditProfileController>();
    Navigator.of(context).pop();
  }

  void pop() {
    emailOTPController.clear();
    mobileOTPController.clear();
    Navigator.of(context).pop(false);
  }
}
