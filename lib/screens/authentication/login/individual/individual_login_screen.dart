import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/login_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class IndividualLoginScreen extends StatelessWidget {
  var language;
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (contet) {
          loginController.context = context;
          return LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Form(
                                key: loginController.formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                        controller: loginController
                                            .phoneEmailController,
                                        keyboardType: TextInputType.text,
                                        hintText: LocaleKeys.phoneNumberEmail,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.phoneEmailIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        onSubmitted: (term) {
                                          loginController.individuaLogin();
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys
                                                .emptyPhoneNumberEmail.tr;
                                          }
                                          return null;
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                            ),
                                            onPressed: () => loginController
                                                .notifyCheckBox(),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: 24.0,
                                                      width: 24.0,
                                                      child: Theme(
                                                          data:
                                                              Theme.of(context)
                                                                  .copyWith(
                                                            unselectedWidgetColor:
                                                                Colors.grey,
                                                          ),
                                                          child: Checkbox(
                                                              activeColor: AppColors
                                                                  .primaryColor,
                                                              value:
                                                                  loginController
                                                                      .rememberMe,
                                                              onChanged:
                                                                  (value) {
                                                                loginController
                                                                    .notifyCheckBox();
                                                              }))),
                                                  10.widthBox,
                                                  Text(
                                                    LocaleKeys
                                                        .keepMeSignedIn.tr,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey),
                                                  )
                                                ])),
                                        /*Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                loginController
                                                    .navigateToForgotPasswordScreen();
                                              },
                                              child: Text(
                                                  LocaleKeys.forgotPassword.tr,
                                                  textAlign: language == 'ar'
                                                      ? TextAlign.left
                                                      : TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        )*/
                                      ],
                                    ),
                                    Expanded(child: _loginWithEmail()),
                                  ],
                                ))))));
          });
        });
  }

  _loginWithEmail() {
    return Column(
      children: [
        15.heightBox,
        CustomButton(
            text: LocaleKeys.login,
            onPressed: () {
              loginController.individuaLogin();
            }),
        Visibility(visible: loginController.loading, child: 5.heightBox),
        Visibility(
          visible: loginController.loading,
          child: Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryColor,
              )),
        ),
        Visibility(visible: loginController.loading, child: 5.heightBox),
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
        InkWell(
            onTap: () {
              loginController.navigateToSignupScreen();
            },
            child: Text(
              LocaleKeys.createYourTmweenAccount.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            )),
        50.heightBox,
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "${LocaleKeys.agreeText.tr} ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: LocaleKeys.privacyPolicy.tr,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]))))
      ],
    );
  }
}
