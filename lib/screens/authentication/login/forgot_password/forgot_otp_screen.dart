import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/forgot_otp_controller.dart';
import 'package:tmween/screens/authentication/login/forgot_password/reset_password_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/custom_text_form_field.dart';
import '../../../../utils/views/otp_text_filed.dart';

class ForgotOtpScreen extends StatelessWidget {
  late String language;
  final forgotOtpController = Get.put(ForgotOtpController());
  final String frm;

  ForgotOtpScreen({Key? key, required this.frm}) : super(key: key);

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
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF727272),
              fontWeight: FontWeight.bold),
        ),
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
       /* CustomBoxTextFormField(
            controller: forgotOtpController.otpController,
            keyboardType: TextInputType.number,
            hintText: 'Enter OTP',
            textInputAction: TextInputAction.done,
            prefixIcon: SvgPicture.asset(
              ImageConstanst.otpIcon,
              color: AppColors.primaryColor,
            ),
            borderColor: Color(0xFFDDDDDD),
            validator: (value) {}),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OtpTextFormField(
                controller: forgotOtpController.num1Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    forgotOtpController.notifyClick1(true);
                    FocusScope.of(forgotOtpController.context).nextFocus();
                    forgotOtpController.notifyClick2(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(forgotOtpController.context).previousFocus();
                    forgotOtpController.notifyClick1(false);
                  }
                },
                clicked: forgotOtpController.click1,
                onTap: () {
                  forgotOtpController.notifyClick1(true);
                }),
            OtpTextFormField(
                controller: forgotOtpController.num2Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(forgotOtpController.context).nextFocus();
                    forgotOtpController.notifyClick3(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(forgotOtpController.context).previousFocus();
                    forgotOtpController.notifyClick2(false);
                  }
                },
                clicked: forgotOtpController.click2,
                onTap: () {
                  forgotOtpController.notifyClick2(true);
                }),
            OtpTextFormField(
                controller: forgotOtpController.num3Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(forgotOtpController.context).nextFocus();
                    forgotOtpController.notifyClick4(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(forgotOtpController.context).previousFocus();
                    forgotOtpController.notifyClick3(false);
                  }
                },
                onSubmitted: (term){
                  print('jfgjkfghj  $term');
                },
                clicked: forgotOtpController.click3,
                onTap: () {
                  forgotOtpController.notifyClick3(true);
                }),
            OtpTextFormField(
                controller: forgotOtpController.num4Controller,
                clicked: forgotOtpController.click4,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(forgotOtpController.context).nextFocus();

                  }
                  if (value.length == 0) {
                    FocusScope.of(forgotOtpController.context).previousFocus();
                    forgotOtpController.notifyClick4(false);
                  }
                },
                onTap: () {
                  forgotOtpController.notifyClick4(true);
                }),
          ],
        ),
        10.heightBox,
        CustomButton(
            text: 'Continue',
            fontSize: 16,
            onPressed: () {
              forgotOtpController.navigateTo(ResetPasswordScreen(frm: frm,));
            }),
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
