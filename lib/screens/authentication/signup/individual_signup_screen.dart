import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/signup_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/circular_progress_bar.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class IndividualSignUpScreen extends StatelessWidget {
  final signUpController = Get.put(SignUpController());
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;

    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (contet) {
          signUpController.context = context;
          return LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Form(
                                key: signUpController.formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                      controller:
                                          signUpController.firstNameController,
                                      keyboardType: TextInputType.name,
                                      hintText: LocaleKeys.firstName,
                                      prefixIcon: SvgPicture.asset(
                                        ImageConstanst.userIcon,
                                        color: AppColors.primaryColor,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LocaleKeys.emptyFirstName.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextFormField(
                                        controller:
                                            signUpController.lastNameController,
                                        keyboardType: TextInputType.name,
                                        hintText: LocaleKeys.lastName,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.userIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys.emptyLastName.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller:
                                            signUpController.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.emailIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        hintText: LocaleKeys.yourEmail,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'[/\\]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys.emptyYourEmail.tr;
                                          } else if (!signUpController
                                              .emailController.value.text
                                              .validateEmail()) {
                                            return LocaleKeys.validYourEmail.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller:
                                            signUpController.passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText:
                                            signUpController.visiblePassword,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.lockIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              signUpController.visiblePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              signUpController
                                                  .visiblePasswordIcon();
                                            }),
                                        hintText: LocaleKeys.yourPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys.emptyPassword.tr;
                                          } else if (signUpController
                                                  .passwordController
                                                  .value
                                                  .text
                                                  .length <=
                                              8) {
                                            return LocaleKeys
                                                .validPasswordLength.tr;
                                          } else if (!signUpController
                                              .passwordController.value.text
                                              .validatePassword()) {
                                            return LocaleKeys.validPassword.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller: signUpController
                                            .confirmPasswordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: signUpController
                                            .visibleConfirmPassword,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.lock2Icon,
                                          color: AppColors.primaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              signUpController
                                                      .visibleConfirmPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              signUpController
                                                  .visibleConfirmPasswordIcon();
                                            }),
                                        hintText: LocaleKeys.confirmPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys
                                                .emptyConfirmPassword.tr;
                                          } else if (signUpController
                                                  .passwordController.value.text
                                                  .trim()
                                                  .compareTo(signUpController
                                                      .confirmPasswordController
                                                      .value
                                                      .text
                                                      .trim()) !=
                                              0) {
                                            return LocaleKeys.passwordMatch.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller:
                                            signUpController.phoneController,
                                        keyboardType: TextInputType.phone,
                                        hintText: LocaleKeys.phoneNumber,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.phoneCallIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(12),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        /* textInputAction: TextInputAction.done,
                                        onSubmitted: (term) {
                                          FocusScope.of(context).unfocus();
                                          signUpController.signUp();
                                        },*/
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys
                                                .emptyPhoneNumber.tr;
                                          } else if (signUpController
                                                  .phoneController
                                                  .value
                                                  .text
                                                  .length <
                                              10) {
                                            return LocaleKeys
                                                .validPhoneNumber.tr;
                                          }
                                          return null;
                                        }),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () =>
                                            signUpController.notifyCheckBox(),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        unselectedWidgetColor:
                                                            Colors.grey,
                                                      ),
                                                      child: Checkbox(
                                                          value:
                                                              signUpController
                                                                  .agree,
                                                          activeColor: AppColors
                                                              .primaryColor,
                                                          onChanged: (value) {
                                                            signUpController
                                                                .notifyCheckBox();
                                                          }))),
                                              10.widthBox,
                                              RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      text: 'I agree to the ',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                      children: [
                                                        TextSpan(
                                                          text: 'terms of use ',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ]))
                                            ])),
                                    15.heightBox,
                                    CustomButton(
                                        text: LocaleKeys.createAccount,
                                        onPressed: () {
                                          signUpController
                                              .signUpIndividual(language);
                                        }),
                                    Visibility(
                                      visible: signUpController.loading,
                                      child: CircularProgressBar(),
                                    ),
                                    10.heightBox,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        30.widthBox,
                                        Expanded(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
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
                                                padding:
                                                    EdgeInsets.only(top: 5),
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
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          LocaleKeys.haveAccount.tr,
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
                                                    text:
                                                        "${LocaleKeys.agreeText.tr} ",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black26,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: LocaleKeys
                                                            .privacyPolicy.tr,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )
                                                    ]))))
                                  ],
                                ))))));
          });
        });
  }
}
