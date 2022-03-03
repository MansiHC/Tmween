import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/reset_password_controller.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  late String language;
  final resetPasswordController = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ResetPasswordController>(
        init: ResetPasswordController(),
        builder: (contet) {
          resetPasswordController.context = context;
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
                  child: topView(resetPasswordController)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: bottomView(resetPasswordController),
              )
            ],
          )));
        });
  }

  Widget bottomView(ResetPasswordController resetPasswordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        5.heightBox,
        Text(
          "We'll ask for this password whenever you sign in.",
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF727272),
              fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: resetPasswordController.newPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Enter new password',
            textInputAction: TextInputAction.done,
            prefixIcon: SvgPicture.asset(ImageConstanst.lockIcon,color: AppColors.primaryColor,),
            borderColor: Color(0xFFDDDDDD),
            validator: (value) {}),
        5.heightBox,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgPicture.asset(ImageConstanst.iIcon,height: 13,width: 13,),
            2.widthBox,
            Text(
              "Passwords must be at least 8 Characters.",
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF727272),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: resetPasswordController.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Re-enter new password',
            textInputAction: TextInputAction.done,
            prefixIcon: SvgPicture.asset(ImageConstanst.lock2Icon,color: AppColors.primaryColor,),
            borderColor: Color(0xFFDDDDDD),
            validator: (value) {}),
        10.heightBox,
        CustomButton(text: 'Continue', fontSize: 16, onPressed: () {}),
        30.heightBox,
        Text(
          'Secure password tips:',
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFF575757),
              fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
            ),
            10.widthBox,
            Expanded(
                child: Text(
                    'Use at least 8 characters, a combination of numbers and letters is best.',
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Color(0xFF0727272))))
          ],
        ),
        5.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
            ),
            10.widthBox,
            Expanded(
                child: Text(
                    'Do not use the same password you have used with us previously.',
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Color(0xFF0727272))))
          ],
        ),
        5.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
            ),
            10.widthBox,
            Expanded(
                child: Text(
                    'Do not use dictionary words, your name, e-mail address, mobile phone number or other personal information that can be easily obtained.',
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Color(0xFF0727272))))
          ],
        ),
        5.heightBox,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
            ),
            10.widthBox,
            Expanded(
                child: Text(
                    'Do not use the same password for multiple online accounts.',
                    style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Color(0xFF0727272))))
          ],
        ),
      ],
    );
  }

  Widget topView(ResetPasswordController resetPasswordController) {
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
                        resetPasswordController.exitScreen();
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
