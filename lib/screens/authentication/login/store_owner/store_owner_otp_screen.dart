import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../controller/login_controller.dart';
import '../../../../controller/store_otp_controller.dart';
import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/otp_text_field.dart';

class StoreOwnerOtpScreen extends StatelessWidget {
  final String phoneEmail;
  final String from;
  final String frm;

  StoreOwnerOtpScreen(
      {Key? key,
      required this.phoneEmail,
      required this.from,
      required this.frm})
      : super(key: key);

  late String language;
  final otpController = Get.put(StoreOtpController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<StoreOtpController>(
        init: StoreOtpController(),
        builder: (contet) {
          otpController.context = context;
          otpController.phone = phoneEmail;
          return GetBuilder<LoginController>(
              init: LoginController(),
              builder: (contet) {
                loginController.context = otpController.context;
                return WillPopScope(
                    onWillPop: () => _onWillPop(otpController, loginController),
                    child: Scaffold(
                        body: SingleChildScrollView(
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity, maxHeight: 90),
                            color: AppColors.appBarColor,
                            padding: EdgeInsets.only(top: 20),
                            child: topView(otpController)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: bottomView(otpController),
                        )
                      ],
                    ))));
              });
        });
  }

  Widget bottomView(StoreOtpController otpController) {
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
                        //  loginController.isStorePasswordScreen = false;
                        //  loginController.update();
                        //otpController.exitScreen();
                        otpController.navigateToLoginEmailScreen(
                            from,
                            frm,
                            loginController.isPasswordScreen,
                            loginController.isStorePasswordScreen);
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
        RichText(
            text: TextSpan(
                text: "${LocaleKeys.sentOTP.tr} ",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF727272),
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "${phoneEmail.tr}. ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: LocaleKeys.pleaseCompleteVerification.tr,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF727272),
                      fontWeight: FontWeight.bold)),
            ])),
        10.heightBox,
        Text(
          LocaleKeys.enterOTP.tr,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        10.heightBox,
        if (!otpController.loading && !otpController.otpExpired)
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
                    otpController.otpExpired = true;
                    otpController.update();
                  },
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text('$minutes:$seconds',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)));
                  }),
            ],
          ),
        if (otpController.otpExpired)
          Text(
            LocaleKeys.pleaseResendOtp.tr,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        40.heightBox,
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(otpController.context).size.width / 8),
            child: OtpTextField(
              length: 4,
              obscureText: false,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              cursorColor: Colors.white,
              textStyle: TextStyle(color: Colors.white),
              controller: otpController.otpController,
              onCompleted: (v) {
                // otpController.verifyLoginOTP();
              },
              onChanged: (value) {
                debugPrint(value);
                otpController.currentText = value;
                otpController.update();
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: otpController.context,
            )),
        Visibility(
          visible: loginController.loading,
          child: CircularProgressBar(),
        ),
        30.heightBox,
        Text(
          LocaleKeys.notReceivedOtp.tr,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        5.heightBox,
        if (otpController.otpExpired)
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
        GetBuilder<LoginController>(
            init: LoginController(),
            builder: (contet) {
              loginController.context = otpController.context;
              return CustomButton(
                  text: LocaleKeys.loginWithPassword.tr,
                  onPressed: () {
                    //  otpController.exitScreen();
                    otpController.navigateToLoginScreen(
                        from,
                        frm,
                        loginController.isPasswordScreen,
                        loginController.isStorePasswordScreen);
                  });
            })
      ],
    );
  }

  Future<bool> _onWillPop(
      StoreOtpController otpController, LoginController loginController) async {
    otpController.navigateToLoginScreen(
        from,
        frm,
        loginController.isPasswordScreen,
        loginController.isStorePasswordScreen);

    return true;
  }

  Widget topView(StoreOtpController otpController) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (contet) {
          loginController.context = otpController.context;
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
                              // otpController.exitScreen();
                              otpController.navigateToLoginScreen(
                                  from,
                                  frm,
                                  loginController.isPasswordScreen,
                                  loginController.isStorePasswordScreen);
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
        });
  }
}
