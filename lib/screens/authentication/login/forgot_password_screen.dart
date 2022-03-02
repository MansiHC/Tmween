import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/otp_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/login/forgot_otp_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/otp_text_filed.dart';

import '../../../controller/forgot_password_controller.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {

  late String language;
  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (contet) {
          forgotPasswordController.context = context;
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
                  child: topView(forgotPasswordController)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: bottomView(forgotPasswordController),
              )
            ],
          )));
        });
  }

  Widget bottomView(ForgotPasswordController forgotPasswordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.heightBox,
        Text(
          'Enter the email address or mobile phone number associated with your Tmween account.',
          style: TextStyle(fontSize: 13, color: Color(0xFF0727272),fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: forgotPasswordController.emailMobileController,
            keyboardType: TextInputType.text,
            hintText: LocaleKeys.phoneNumberEmail,
            textInputAction: TextInputAction.done,
            borderColor: Color(0xFFDDDDDD),
            suffixIcon: IconButton(
                        onPressed: () {
                          forgotPasswordController.emailMobileController.clear();
                          forgotPasswordController.update();
                        },
                        icon: Icon(
                          CupertinoIcons.clear_circled_solid,
                          color: Color(0xFFC7C7C7),
                          size: 24,
                        )),
            validator: (value) {}),
        10.heightBox,
        CustomButton(
            text: 'Continue',
            fontSize: 16,
            onPressed: () {
              forgotPasswordController.navigateTo(ForgotOtpScreen());
               }),
        20.heightBox,
        Text(
          'Has your email address or mobile phone number changed?',
          style: TextStyle(fontSize: 14, color: Color(0xFF575757),fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
                text: 'If you no longer use the e-mail address associated with your Tmween account, you may contact ',
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF0727272)),
                children: <InlineSpan>[
                  TextSpan(
                    text:'${LocaleKeys.customerService.tr} ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF61ABD1),
                    )),
                    TextSpan(
                    text: 'for help restoring access to your account.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0727272),
                    ),)
                ])),
      ],
    );
  }

  Widget topView(ForgotPasswordController forgotPasswordController) {
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
                        forgotPasswordController.exitScreen();
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
                'Password Assistance',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
