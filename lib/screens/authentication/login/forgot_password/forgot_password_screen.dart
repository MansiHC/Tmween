import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../controller/forgot_password_controller.dart';
import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_button.dart';
import '../../../../utils/views/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String from;
  final String mobile;
  final String frm;

  ForgotPasswordScreen(
      {Key? key, required this.mobile, required this.from, required this.frm})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late String language;
  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  void initState() {
    forgotPasswordController.emailMobileController.text = widget.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (contet) {
          forgotPasswordController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(forgotPasswordController),
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
                      child: topView(forgotPasswordController)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: bottomView(forgotPasswordController),
                  )
                ],
              ))));
        });
  }

  Future<bool> _onWillPop(ForgotPasswordController forgotOtpController) async {
    Get.delete<ForgotPasswordController>();
    forgotPasswordController.navigateToLoginScreen(widget.from, widget.frm);
    return true;
  }

  Widget bottomView(ForgotPasswordController forgotPasswordController) {
    return Form(
        key: forgotPasswordController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.heightBox,
            RichText(
                text: TextSpan(
                    text: '${LocaleKeys.enterThe.tr} ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0727272),
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: '${LocaleKeys.emailAddress.tr} ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${LocaleKeys.or.tr} ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0727272),
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${LocaleKeys.phoneNumberCap.tr} ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: LocaleKeys.associateWithTmween.tr,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0727272),
                        fontWeight: FontWeight.bold),
                  ),
                ])),
            10.heightBox,
            CustomBoxTextFormField(
                controller: forgotPasswordController.emailMobileController,
                keyboardType: TextInputType.text,
                hintText: LocaleKeys.phoneNumberEmail,
                textInputAction: TextInputAction.done,
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.phoneEmailIcon,
                  color: AppColors.primaryColor,
                ),
                onSubmitted: (term) {
                  if (widget.from == AppConstants.individual) {
                    forgotPasswordController.generateOTP(
                        widget.from, widget.frm, language);
                  } else {
                    forgotPasswordController.submit(
                        widget.from, widget.frm, '');
                  }
                },
                borderColor: Color(0xFFDDDDDD),
                suffixIcon: IconButton(
                    onPressed: () {
                      forgotPasswordController.emailMobileController.clear();
                    },
                    icon: Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: Color(0xFFC7C7C7),
                      size: 24,
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emptyPhoneNumberEmail.tr;
                  }
                  return null;
                }),
            10.heightBox,
            CustomButton(
                text: LocaleKeys.continueText.tr,
                fontSize: 16,
                onPressed: () {
                  if (widget.from == AppConstants.individual) {
                    forgotPasswordController.generateOTP(
                        widget.from, widget.frm, language);
                  } else {
                    forgotPasswordController.submit(
                        widget.from, widget.frm, '');
                  }
                }),
            Visibility(
              visible: forgotPasswordController.loading,
              child: CircularProgressBar(),
            ),
            20.heightBox,
            Text(
              LocaleKeys.hasYrEmailChanged.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575757),
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text:
                        '${LocaleKeys.ifNoLongerUse.tr} ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0727272)),
                    children: <InlineSpan>[
                      TextSpan(
                          text: '${LocaleKeys.customerService.tr} ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF61ABD1),
                          )),
                      TextSpan(
                        text: LocaleKeys.restoringAccount.tr,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0727272),
                        ),
                      )
                    ])),
          ],
        ));
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
                        Get.delete<ForgotPasswordController>();
                        forgotPasswordController.navigateToLoginScreen(
                            widget.from, widget.frm);
                        // forgotPasswordController.exitScreen();
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
                LocaleKeys.passwordAssistance.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
