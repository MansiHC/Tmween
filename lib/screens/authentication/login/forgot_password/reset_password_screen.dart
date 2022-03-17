import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../controller/reset_password_controller.dart';
import '../../../../lang/locale_keys.g.dart';
import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  late String language;
  final resetPasswordController = Get.put(ResetPasswordController());
  final formKey = GlobalKey<FormState>();
  final String from;
  final String frm;
  final String email;

  ResetPasswordScreen(
      {Key? key, required this.from, required this.frm, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ResetPasswordController>(
        init: ResetPasswordController(),
        builder: (contet) {
          resetPasswordController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(resetPasswordController),
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
                      child: topView(resetPasswordController)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: bottomView(resetPasswordController),
                  )
                ],
              ))));
        });
  }

  Future<bool> _onWillPop(
      ResetPasswordController resetPasswordController) async {
    resetPasswordController.exitScreen();
    return true;
  }

  Widget bottomView(ResetPasswordController resetPasswordController) {
    return Form(
        key: resetPasswordController.formKey,
        child: Column(
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
                hintText: 'Enter new password',
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.lockIcon,
                  color: AppColors.primaryColor,
                ),
                obscureText: resetPasswordController.visiblePassword,
                suffixIcon: IconButton(
                    icon: Icon(
                      resetPasswordController.visiblePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      resetPasswordController.visiblePasswordIcon();
                    }),
                borderColor: Color(0xFFDDDDDD),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emptyNewPassword.tr;
                  } else if (resetPasswordController
                          .newPasswordController.value.text.length <=
                      8) {
                    return LocaleKeys.validPasswordLength.tr;
                  } else if (!resetPasswordController
                      .newPasswordController.value.text
                      .validatePassword()) {
                    return LocaleKeys.validPassword.tr;
                  }
                  return null;
                }),
            5.heightBox,
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageConstanst.iIcon,
                  height: 13,
                  width: 13,
                ),
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
                obscureText: resetPasswordController.visibleConfirmPassword,
                hintText: 'Re-enter new password',
                textInputAction: TextInputAction.done,
                onSubmitted: (term) {
                  if (from == AppConstants.individual) {
                    resetPasswordController.resetPassword(
                        from, frm, email, language);
                  } else {
                    resetPasswordController.submit(from, frm);
                  }
                },
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.lock2Icon,
                  color: AppColors.primaryColor,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      resetPasswordController.visibleConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      resetPasswordController.visibleConfirmPasswordIcon();
                    }),
                borderColor: Color(0xFFDDDDDD),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emptyRetypePassword.tr;
                  } else if (resetPasswordController
                          .newPasswordController.value.text
                          .trim()
                          .compareTo(resetPasswordController
                              .confirmPasswordController.value.text
                              .trim()) !=
                      0) {
                    return LocaleKeys.newPasswordMatch.tr;
                  }
                  return null;
                }),
            10.heightBox,
            CustomButton(
                text: 'Continue',
                fontSize: 16,
                onPressed: () {
                  if (from == AppConstants.individual) {
                    resetPasswordController.resetPassword(
                        from, frm, email, language);
                  } else {
                    resetPasswordController.submit(from, frm);
                  }
                }),
            Visibility(
              visible: resetPasswordController.loading,
              child: CircularProgressBar(),
            ),
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
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0727272))))
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
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0727272))))
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
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0727272))))
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
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0727272))))
              ],
            ),
          ],
        ));
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
