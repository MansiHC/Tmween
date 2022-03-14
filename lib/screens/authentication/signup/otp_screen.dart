import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/otp_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../utils/views/otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final String? otp;

  OtpScreen({Key? key, this.otp, required this.phone}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OtpScreenState();
  }
}

class OtpScreenState extends State<OtpScreen> {
  late String language;
  final otpController = Get.put(OtpController());

  Future<void> initSmsListener(OtpController otpController) async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    otpController.comingSms = comingSms;
    print("====>Message: ${otpController.comingSms}");
    print("${otpController.comingSms[32]}");
    otpController.otpController.text = otpController.comingSms[32] +
        otpController.comingSms[33] +
        otpController.comingSms[34] +
        otpController.comingSms[35] +
        otpController.comingSms[36] +
        otpController.comingSms[
            37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    otpController.update();
  }

  @override
  void initState() {
    otpController.otpValue = widget.otp!;
    initSmsListener(otpController);
    super.initState();
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
        init: OtpController(),
        builder: (contet) {
          otpController.context = context;
          language = Get.locale!.languageCode;
          otpController.phone = widget.phone;
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
        Text(
          'Otp is : ${otpController.otpValue}',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        10.heightBox,
        RichText(
            text: TextSpan(
                text:
                    "We've sent an One Time Password (OTP) to the mobile number",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF727272),
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: ' ${widget.phone}. ',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "Please enter it below to complete verification.",
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
        buildTimer(),
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
                activeColor: AppColors.primaryColor,
                selectedColor: AppColors.primaryColor,
                selectedFillColor: AppColors.primaryColor,
                inactiveFillColor: AppColors.lightGrayColor,
                inactiveColor: AppColors.lightGrayColor,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              cursorColor: Colors.white,
              textStyle: TextStyle(color: Colors.white),
              controller: otpController.otpController,
              onCompleted: (v) {
                otpController.verifyOTP();
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
              otpController.resendOTP(widget.phone);
            },
            child: Text(
              LocaleKeys.resendCode.tr,
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            )),
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
