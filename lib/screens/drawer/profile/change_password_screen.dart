import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import '../../../controller/change_password_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  late String language;
  final changePasswordController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (contet) {
          changePasswordController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(changePasswordController)),
                      _bottomView(changePasswordController),
                    ],
                  )));
        });
  }

  Widget _bottomView(ChangePasswordController changePasswordController) {
    return Expanded(
        child:  SingleChildScrollView(
                child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
    child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.heightBox,
                Text(
                      LocaleKeys.email.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                5.heightBox,
                     Text(
                      'salim.akka@tmween.com',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                15.heightBox,
                 Text(
                      LocaleKeys.mobileNumber.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                5.heightBox,
               Text(
                      '+249 9822114455',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                20.heightBox,
                 CustomTextFormField(
                        controller:
                            changePasswordController.newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        hintText: LocaleKeys.newPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.emptyNewPassword.tr;
                          } else if (changePasswordController
                                  .newPasswordController.value.text.length <
                              8) {
                            return LocaleKeys.validPasswordLength.tr;
                          } else if (!changePasswordController
                              .newPasswordController.value.text
                              .validatePassword()) {
                            return LocaleKeys.validPassword.tr;
                          }
                          return null;
                        }),
                5.heightBox,
               CustomTextFormField(
                        controller:
                            changePasswordController.retypePasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        hintText: LocaleKeys.retypePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.emptyRetypePassword.tr;
                          } else if (changePasswordController
                                  .newPasswordController.value.text
                                  .trim()
                                  .compareTo(changePasswordController
                                      .retypePasswordController.value.text
                                      .trim()) !=
                              0) {
                            return LocaleKeys.newPasswordMatch.tr;
                          }
                          return null;
                        }),
                25.heightBox,
                 Text(
                    '${LocaleKeys.enterOtpSentTo.tr} salim.akka@tmween.com',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                10.heightBox,
                CustomTextFormField(
                    controller: changePasswordController.otpController,
                    keyboardType: TextInputType.number,
                    hintText: LocaleKeys.otp,
                    textInputAction: TextInputAction.done,
                    suffixIcon: InkWell(
                        onTap: () {},
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Text(
                              LocaleKeys.resend.tr,
                              style: TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ))),
                    validator: (value) {}),
                15.heightBox,
                Row(
                    children: [
                      Expanded(child: TextButton(onPressed: () {
                      },
                        child: Text(
                          LocaleKeys.cancel.tr,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ) ,
                      )),
                      Expanded(child:TextButton(onPressed: () {  },
                        child: Text(
                          LocaleKeys.save.tr,
                          style: TextStyle(
                              color: AppColors.darkblue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                50.heightBox,
              ],
            ))));
  }

  Widget topView(ChangePasswordController changePasswordController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        changePasswordController.exitScreen();
                      },
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.changePassword.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
