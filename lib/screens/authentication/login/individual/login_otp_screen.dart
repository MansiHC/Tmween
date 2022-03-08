import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/otp_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/otp_text_filed.dart';

import '../../../../controller/login_controller.dart';
import '../../../../utils/views/custom_button.dart';

class LoginOtpScreen extends StatelessWidget {
  final String phoneEmail;

  LoginOtpScreen({Key? key, required this.phoneEmail}) : super(key: key);

  late String language;
  final otpController = Get.put(OtpController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<OtpController>(
        init: OtpController(),
        builder: (contet) {
          otpController.context = context;
          otpController.phone = phoneEmail;
          return Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  constraints:
                      BoxConstraints(minWidth: double.infinity, maxHeight: 90),
                  color: AppColors.appBarColor,
                  padding: EdgeInsets.only(top: 20),
                  child: topView(otpController)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: bottomView(otpController),
              )
            ],
          )));
        });
  }

  Widget bottomView(OtpController otpController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${LocaleKeys.inText.tr} ${phoneEmail}',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            5.widthBox,
            GetBuilder<LoginController>(
                init: LoginController(),
                builder: (contet) {
                  loginController.context = otpController.context;
                  return InkWell(
                      onTap: () {
                        loginController.isPasswordScreen = false;
                        otpController.exitScreen();
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.change,
                            style: TextStyle(
                                fontSize: 16, color: AppColors.primaryColor),
                          ),
                          Icon(
                            Icons.edit,
                            color: AppColors.primaryColor,
                            size: 16,
                          )
                        ],
                      ));
                })
          ],
        ),
        10.heightBox,
        RichText(text:TextSpan(text:
        "We've sent an One Time Password (OTP) to the mobile number ",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF727272),
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(text:
              "+91 9876543210. ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),  TextSpan(text:
              "Please enter it below to complete verification.",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF727272),
                      fontWeight: FontWeight.bold)),
            ]
        )),
        10.heightBox,
        Text(
          LocaleKeys.enterOTP.tr,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        10.heightBox,
        buildTimer(),
        40.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OtpTextFormField(
                controller: otpController.num1Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    otpController.notifyClick1(true);
                    FocusScope.of(otpController.context).nextFocus();
                    otpController.notifyClick2(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(otpController.context).previousFocus();
                    otpController.notifyClick1(false);
                  }
                },
                clicked: otpController.click1,
                onTap: () {
                  otpController.notifyClick1(true);
                }),
            OtpTextFormField(
                controller: otpController.num2Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(otpController.context).nextFocus();
                    otpController.notifyClick3(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(otpController.context).previousFocus();
                    otpController.notifyClick2(false);
                  }
                },
                clicked: otpController.click2,
                onTap: () {
                  otpController.notifyClick2(true);
                }),
            OtpTextFormField(
                controller: otpController.num3Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(otpController.context).nextFocus();
                    otpController.notifyClick4(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(otpController.context).previousFocus();
                    otpController.notifyClick3(false);
                  }
                },
                clicked: otpController.click3,
                onTap: () {
                  otpController.notifyClick3(true);
                }),
            OtpTextFormField(
                controller: otpController.num4Controller,
                clicked: otpController.click4,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(otpController.context).nextFocus();
                    otpController.verifyLoginOTP();
                  }
                  if (value.length == 0) {
                    FocusScope.of(otpController.context).previousFocus();
                    otpController.notifyClick4(false);
                  }
                },
                onTap: () {
                  otpController.notifyClick4(true);
                }),
          ],
        ),
        Visibility(visible: otpController.loading, child: 5.heightBox),
        Visibility(
          visible: otpController.loading,
          child: Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryColor,
              )),
        ),
        Visibility(visible: otpController.loading, child: 5.heightBox),
        30.heightBox,
        Text(
          LocaleKeys.notReceivedOtp.tr,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        5.heightBox,
        InkWell(
            onTap: () {
              otpController.resendOTP();
            },
            child: Text(
              LocaleKeys.resendCode.tr,
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            )),
        10.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.widthBox,
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ))),
            10.widthBox,
            Text(
              LocaleKeys.or.tr,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            10.widthBox,
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ))),
            30.widthBox
          ],
        ),
        10.heightBox,
        CustomButton(
            text: LocaleKeys.loginWithPassword.tr,
            onPressed: () {
              otpController.exitScreen();
            })
      ],
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.otpExpire.tr,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        /*TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value!.toInt()}",
            style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
          ),
        ),*/
        TweenAnimationBuilder<Duration>(
            duration: Duration(minutes: 1),
            tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
            onEnd: () {
              print('Timer ended');
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)));
            }),
      ],
    );
  }

  Widget topView(OtpController otpController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                        otpController.exitScreen();
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
                LocaleKeys.phoneVerification.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
