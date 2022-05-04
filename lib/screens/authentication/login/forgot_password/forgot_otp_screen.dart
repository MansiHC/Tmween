import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/forgot_otp_controller.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../lang/locale_keys.g.dart';
import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/otp_text_field.dart';

class ForgotOtpScreen extends StatefulWidget {
  final String from;
  final String frm;
  final String otp;
  final String email;

  ForgotOtpScreen(
      {Key? key,
      required this.from,
      required this.frm,
      required this.otp,
      required this.email})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotOtpScreenState();
  }
}

class ForgotOtpScreenState extends State<ForgotOtpScreen> {
  late String language;
  final forgotOtpController = Get.put(ForgotOtpController());

  Future<void> initSmsListener(ForgotOtpController otpController) async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = LocaleKeys.failedToGetSMS.tr;
    }
    if (!mounted) return;
    if (comingSms.contains(LocaleKeys.appTitle.tr)) {
      otpController.comingSms = comingSms;
      print("====>Message: ${otpController.comingSms}");
      final intInStr = RegExp(r'\d+');
      otpController.otpController.text = intInStr
          .allMatches(otpController.comingSms)
          .map((m) => m.group(0))
          .toString()
          .replaceAll('(', '')
          .replaceAll(')', '');
      otpController.update();
    }
  }

  @override
  void initState() {
    forgotOtpController.otpValue = widget.otp;
    initSmsListener(forgotOtpController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ForgotOtpController>(
        init: ForgotOtpController(),
        builder: (contet) {
          forgotOtpController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(forgotOtpController),
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
                      child: topView(forgotOtpController)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: bottomView(forgotOtpController),
                  )
                ],
              ))));
        });
  }

  Future<bool> _onWillPop(ForgotOtpController forgotOtpController) async {
    forgotOtpController.exitScreen();
    return true;
  }

  Widget bottomView(ForgotOtpController forgotOtpController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${LocaleKeys.otpIs.tr} ${forgotOtpController.otpValue}',
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF727272),
              fontWeight: FontWeight.bold),
        ),
        5.heightBox,
        Text(
          LocaleKeys.completeVerification.tr,
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF727272),
              fontWeight: FontWeight.bold),
        ),
        RichText(
            text: TextSpan(
                text:
                '${LocaleKeys.sentOTP.tr} ',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF727272),
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "${widget.email}. ",
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
        if (!forgotOtpController.loading && !forgotOtpController.otpExpired)
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
                    forgotOtpController.otpExpired = true;
                    forgotOtpController.update();
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
        if (forgotOtpController.otpExpired)
          Text(
            LocaleKeys.pleaseResendOtp.tr,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        10.heightBox,
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(forgotOtpController.context).size.width / 8),
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
              controller: forgotOtpController.otpController,
              onCompleted: (v) {
                if (widget.from == AppConstants.individual) {
                  forgotOtpController.verifyOTP(
                      widget.from, widget.frm, language, widget.email);
                } else {
                  forgotOtpController.submit(
                      widget.from, widget.frm, widget.email);
                }
              },
              onChanged: (value) {
                debugPrint(value);
                forgotOtpController.currentText = value;
                forgotOtpController.update();
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: forgotOtpController.context,
            )),
        10.heightBox,
        CustomButton(
            text: LocaleKeys.continueText.tr,
            fontSize: 16,
            onPressed: () {
              if (widget.from == AppConstants.individual) {
                forgotOtpController.verifyOTP(
                    widget.from, widget.frm, language, widget.email);
              } else {
                forgotOtpController.submit(
                    widget.from, widget.frm, widget.email);
              }
            }),
        Visibility(
          visible: forgotOtpController.loading,
          child: CircularProgressBar(),
        ),
        20.heightBox,
        if (forgotOtpController.otpExpired)
          InkWell(
              onTap: () {
                if (widget.from == AppConstants.individual) {
                  forgotOtpController.resendOTP(
                      widget.from, widget.frm, language, widget.email);
                }
              },
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    LocaleKeys.resendOtp.tr,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF2192CA),
                        fontWeight: FontWeight.bold),
                  ))),
      ],
    );
  }

  Widget topView(ForgotOtpController forgotOtpController) {
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
                        forgotOtpController.exitScreen();
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
                LocaleKeys.verificationRequired.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
