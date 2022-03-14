import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/forgot_otp_controller.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/otp_text_field.dart';

class ForgotOtpScreen extends StatelessWidget {
  late String language;
  final forgotOtpController = Get.put(ForgotOtpController());
  final String from;
  final String frm;

  ForgotOtpScreen({Key? key, required this.from, required this.frm})
      : super(key: key);

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
        5.heightBox,
        Text(
          'To continue, complete this verification step.',
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF727272),
              fontWeight: FontWeight.bold),
        ),
        RichText(
            text: TextSpan(
                text:
                    "We've sent an One Time Password (OTP) to the mobile number ",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF727272),
                    fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "+91 9876543210. ",
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
              controller: forgotOtpController.otpController,
              onCompleted: (v) {
                forgotOtpController.submit(
                  from,
                  frm,
                );
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
            text: 'Continue',
            fontSize: 16,
            onPressed: () {
              forgotOtpController.submit(
                from,
                frm,
              );
            }),
        Visibility(
          visible: forgotOtpController.loading,
          child: CircularProgressBar(),
        ),
        20.heightBox,
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Resend OTP',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2192CA),
                  fontWeight: FontWeight.bold),
            )),
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
                'Verification required',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
