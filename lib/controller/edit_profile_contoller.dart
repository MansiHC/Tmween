import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

import '../model/get_customer_data_model.dart';
import '../screens/drawer/drawer_screen.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';
import 'drawer_controller.dart';

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

  int userId = 0;
  int loginLogId = 0;
  String token = '';
  late String  otpValue;

  final api = Api();
  bool loading = false;
  bool loadingImageName = false;
  bool loadingDialog = false;

  @override
  void onInit() {
   // if (Helper.isIndividual)
      MySharedPreferences.instance
          .getStringValuesSF(SharedPreferencesKeys.token)
          .then((value) async {
        token = value!;
        print('dhsh.....$token');
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.userId)
            .then((value) async {
          userId = value!;
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.loginLogId)
              .then((value) async {
            loginLogId = value!;
          });
        });
      });
    super.onInit();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  generateOTP(emailMobile,language) async {
    FocusScope.of(context).unfocus();
    // navigateToDrawerScreen();
    update();
    loadingDialog = true;
    update();
    await api
        .generateMobileOtp(emailMobile,  language)
        .then((value) {
      if (value.statusCode == 200) {
        otpValue = value.data!.otp.toString();
      }
        Helper.showGetSnackBar(value.message!);

      loadingDialog = false;
      update();
    }).catchError((error) {
      loadingDialog = false;
      update();
      print('error....$error');
    });
  }

  resendOTP(emailMobile) async {
    loadingDialog = true;
    update();
    await api.resendLoginOTP(emailMobile).then((value) {
      if (value.statusCode == 200) {
        otpValue = value.data!.otp.toString();
      }
        Helper.showGetSnackBar(value.message!);

      loadingDialog = false;
      update();
    }).catchError((error) {
      loadingDialog = false;
      update();
      print('error....$error');
    });
  }

  Future<void> updateNameImage(oldImage,language) async{
    loadingImageName = true;
    FocusScope.of(context).unfocus();
    update();
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;

          await api.updateProfileMobile(token, userId,
              '${nameController.text} ${lastNameController.text}',
              oldImage,
              finalImage, language).then((value) {
            if (value.statusCode == 200) {
              Helper.showGetSnackBar(value.message!);
              exitScreen();
            } else if (value.statusCode == 401) {
              MySharedPreferences.instance
                  .addBoolToSF(SharedPreferencesKeys.isLogin, false);
              Get.delete<EditProfileController>();
              Get.delete<DrawerControllers>();
              Get.offAll(DrawerScreen());
            } else {
              Helper.showGetSnackBar(value.message!);
            }
            loadingImageName = false;
            update();
          }).catchError((error) {
            loadingImageName = false;
            update();
            print('error....$error');
          });
    });
    });

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

  Future<void> updateMobileNumber(mobile,langCode) async {
    loadingDialog = true;
    update();
    await api.updateMobile(token,userId,mobile,otpValue,langCode).then((value) {
      if (value.statusCode == 200) {
        pop();
        exitScreen();
      }
      Helper.showGetSnackBar(value.message!);
      loadingDialog = false;
      update();
    }).catchError((error) {
      loadingDialog = false;
      update();
      print('error....$error');
    });

  }

  Future<void> updateEmail(email,langCode) async {
    loadingDialog = true;
    update();
    await api.updateEmail(token,userId,email,otpValue,langCode).then((value) {
      if (value.statusCode == 200) {
        pop();
        exitScreen();
      }
      Helper.showGetSnackBar(value.message!);
      loadingDialog = false;
      update();
    }).catchError((error) {
      loadingDialog = false;
      update();
      print('error....$error');
    });

  }


  void enableEmailAddress() {
    enableEmail = false;
    update();
  }

  void exitScreen() {
    Get.delete<EditProfileController>();
    Navigator.of(context).pop(true);
  }

  void pop() {
    emailOTPController.clear();
    mobileOTPController.clear();
    Navigator.of(context).pop(false);
  }
}
