import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/forgot_otp_controller.dart';
import 'package:tmween/controller/otp_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/otp_text_filed.dart';

import '../../../controller/forgot_password_controller.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';

class ForgotOtpScreen extends StatelessWidget {

  late String language;
  final forgotOtpController = Get.put(ForgotOtpController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ForgotOtpController>(
        init: ForgotOtpController(),
        builder: (contet) {
          forgotOtpController.context = context;
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
                  child: topView(forgotOtpController)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: bottomView(forgotOtpController),
              )
            ],
          )));
        });
  }

  Widget bottomView(ForgotOtpController forgotOtpController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.heightBox,
        Text(
          'To continue, complete this verification step.',
          style: TextStyle(fontSize: 13, color: Color(0xFF727272),fontWeight: FontWeight.bold),
        ),
        Text(
          "We've sent an OTP to the mobile number \n+91 9876543210. Please enter it below to complete verification." ,
          style: TextStyle(fontSize: 13, color: Color(0xFF727272),fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: forgotOtpController.otpController,
            keyboardType: TextInputType.number,
            hintText: 'Enter OTP',
            textInputAction: TextInputAction.done,
            borderColor: Color(0xFFDDDDDD),

            validator: (value) {}),
        10.heightBox,
        CustomButton(
            text: 'Continue',
            fontSize: 16,
            onPressed: () {
               }),
        20.heightBox,
        Align(alignment:Alignment.topCenter,child:Text(
          'Resend OTP',
          style: TextStyle(fontSize: 14, color: Color(0xFF2192CA),fontWeight: FontWeight.bold),
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
