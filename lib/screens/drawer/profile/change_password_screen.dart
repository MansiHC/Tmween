import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/change_password_controller.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';
import '../../../utils/views/otp_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  late String language;
  final changePasswordController = Get.put(ChangePasswordController());

  final String? email;
  final String? mobile;

  ChangePasswordScreen({Key? key, this.email, this.mobile}) : super(key: key);

  Future<bool> _onWillPop(
      ChangePasswordController changePasswordController) async {
    changePasswordController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (contet) {
          changePasswordController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(changePasswordController),
              child: Scaffold(
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
                      ))));
        });
  }

  Widget _bottomView(ChangePasswordController changePasswordController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!changePasswordController.loading)
                      Text(
                        'Otp is : ${changePasswordController.otpValue}',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    15.heightBox,
                    Text(
                      LocaleKeys.email.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    5.heightBox,
                    Text(
                      email!,
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
                      mobile!,
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
                        obscureText: changePasswordController.visiblePassword,
                        hintText: LocaleKeys.newPassword,
                        prefixIcon: SvgPicture.asset(
                          ImageConstanst.lockIcon,
                          color: AppColors.primaryColor,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              changePasswordController.visiblePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              changePasswordController.visiblePasswordIcon();
                            }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.emptyNewPassword.tr;
                          } else if (changePasswordController
                                  .newPasswordController.value.text.length <=
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
                        obscureText:
                            changePasswordController.visibleConfirmPassword,
                        prefixIcon: SvgPicture.asset(
                          ImageConstanst.lock2Icon,
                          color: AppColors.primaryColor,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                              changePasswordController.visibleConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              changePasswordController
                                  .visibleConfirmPasswordIcon();
                            }),
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
                    RichText(
                        text: TextSpan(
                            text: '${LocaleKeys.enterOtpSentTo.tr} ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                            text: email!,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                    15.heightBox,
                    if (!changePasswordController.loading &&
                        !changePasswordController.otpExpired)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.otpExpire.tr,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          5.widthBox,
                          TweenAnimationBuilder<Duration>(
                              duration: Duration(seconds: AppConstants.timer),
                              tween: Tween(
                                  begin: Duration(seconds: AppConstants.timer),
                                  end: Duration.zero),
                              onEnd: () {
                                changePasswordController.otpExpired = true;
                                changePasswordController.update();
                              },
                              builder: (BuildContext context, Duration value,
                                  Widget? child) {
                                final minutes = value.inMinutes;
                                final seconds = value.inSeconds % 60;
                                return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('$minutes:$seconds',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)));
                              }),
                        ],
                      ),
                    if (changePasswordController.otpExpired)
                      Text(
                        'Please Resend the Otp.',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    10.heightBox,
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: OtpTextField(
                          length: 4,
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: AppColors.primaryColor,
                            activeColor: Colors.grey[300],
                            selectedColor: Colors.grey[300],
                            selectedFillColor: AppColors.primaryColor,
                            inactiveFillColor: AppColors.lightGrayColor,
                            inactiveColor: Colors.grey[300],
                          ),
                          textInputAction: TextInputAction.done,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          cursorColor: Colors.white,
                          textStyle: TextStyle(color: Colors.white),
                          controller: changePasswordController.otpController,
                          onCompleted: (v) {},
                          onChanged: (value) {
                            debugPrint(value);
                            changePasswordController.currentText = value;
                            changePasswordController.update();
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: changePasswordController.context,
                        )),
                    10.heightBox,
                    Text(
                      LocaleKeys.notReceivedOtp.tr,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    5.heightBox,
                    InkWell(
                        onTap: () {
                          changePasswordController.resendOtp(language);
                        },
                        child: Text(
                          LocaleKeys.resendCode.tr,
                          style: TextStyle(
                              fontSize: 15, color: AppColors.primaryColor),
                        )),
                    Visibility(
                      visible: changePasswordController.loading,
                      child: CircularProgressBar(),
                    ),
                    15.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            width: 150,
                            horizontalPadding: 5,
                            backgroundColor: Color(0xFF0188C8),
                            text: LocaleKeys.cancel,
                            fontSize: 16,
                            onPressed: () {
                              changePasswordController.exitScreen();
                            }),
                        CustomButton(
                            width: 150,
                            horizontalPadding: 5,
                            backgroundColor: Color(0xFF0188C8),
                            text: LocaleKeys.save,
                            fontSize: 16,
                            onPressed: () {
                              changePasswordController.changePassword(language);
                            }),
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
