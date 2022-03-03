import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/login_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class IndividualLoginPasswordScreen extends StatelessWidget {
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
            return WillPopScope(
                onWillPop: () => _onWillPop(loginController),
            child:SingleChildScrollView(
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
                                    Row(
                                      children: [
                                        Text(
                                          '${LocaleKeys.inText.tr} ${loginController.phoneEmailController.text}',
                                          style: TextStyle(fontSize: 14, color: Colors.black),
                                        ),
                                        5.widthBox,
                                        InkWell(
                                            onTap: () {
                                              loginController.isPasswordScreen = false;
                                              loginController.update();
                                            },
                                            child: Wrap(
                                              crossAxisAlignment: WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  LocaleKeys.change,
                                                  style: TextStyle(
                                                      fontSize: 16, color: AppColors.primaryColor),
                                                ),
                                                Icon(
                                                  Icons.edit,
                                                  color: AppColors.primaryColor,
                                                  size: 16,
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
                                     10.heightBox,
                                     CustomTextFormField(
                                         prefixIcon: SvgPicture.asset(ImageConstanst.lockIcon,color: AppColors.primaryColor,),
                                            controller: loginController
                                                .passwordController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            obscureText:
                                                loginController.visiblePassword,
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                  loginController
                                                          .visiblePassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  loginController
                                                      .visiblePasswordIcon();
                                                }),
                                            hintText: LocaleKeys.yourPassword,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return LocaleKeys
                                                    .emptyPassword.tr;
                                              } else if (loginController
                                                      .passwordController
                                                      .value
                                                      .text
                                                      .length <
                                                  8) {
                                                return LocaleKeys
                                                    .validPasswordLength.tr;
                                              } else if (!loginController
                                                  .passwordController.value.text
                                                  .validatePassword()) {
                                                return LocaleKeys
                                                    .validPassword.tr;
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
                                        Expanded(
                                          child: Text(
                                              LocaleKeys.forgotPassword.tr,
                                              textAlign: language == 'ar'
                                                  ? TextAlign.left
                                                  : TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                   _loginWithPassword()
                                  ],
                                )))))));
          });
        });
  }


  _loginWithPassword() {
    return Column(
      children: [
        15.heightBox,
        CustomButton(
            text: LocaleKeys.login,
            onPressed: () {
              loginController.doLoginWithPassword();
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
        CustomButton(
            text: LocaleKeys.loginWithOTP,
            onPressed: () {
              loginController.navigateToOTPScreen();
            })
      ],
    );
  }

  _onWillPop(LoginController loginController) {
    loginController.isPasswordScreen = false;
    loginController.update();
  }
}
