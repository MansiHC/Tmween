import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/store_owner_signup_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../utils/global.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';

class StoreOwnerSignUpScreen extends StatelessWidget {
  final storeOwnerSignUpController = Get.put(StoreOwnerSignUpController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreOwnerSignUpController>(
        init: StoreOwnerSignUpController(),
        builder: (contet) {
          storeOwnerSignUpController.context = context;
          return LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Form(
                                key: storeOwnerSignUpController.formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                      controller: storeOwnerSignUpController
                                          .firstNameController,
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
                                        controller: storeOwnerSignUpController
                                            .lastNameController,
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
                                        controller: storeOwnerSignUpController
                                            .emailController,
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
                                          } else if (!storeOwnerSignUpController
                                              .emailController.value.text
                                              .validateEmail()) {
                                            return LocaleKeys.validYourEmail.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller: storeOwnerSignUpController
                                            .passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: storeOwnerSignUpController
                                            .visiblePassword,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.lockIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              storeOwnerSignUpController
                                                      .visiblePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              storeOwnerSignUpController
                                                  .visiblePasswordIcon();
                                            }),
                                        hintText: LocaleKeys.yourPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys.emptyPassword.tr;
                                          } else if (storeOwnerSignUpController
                                                  .passwordController
                                                  .value
                                                  .text
                                                  .length <
                                              8) {
                                            return LocaleKeys
                                                .validPasswordLength.tr;
                                          } else if (!storeOwnerSignUpController
                                              .passwordController.value.text
                                              .validatePassword()) {
                                            return LocaleKeys.validPassword.tr;
                                          }
                                          return null;
                                        }),
                                    CustomTextFormField(
                                        controller: storeOwnerSignUpController
                                            .confirmPasswordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: storeOwnerSignUpController
                                            .visibleConfirmPassword,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.lock2Icon,
                                          color: AppColors.primaryColor,
                                        ),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                              storeOwnerSignUpController
                                                      .visibleConfirmPassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              storeOwnerSignUpController
                                                  .visibleConfirmPasswordIcon();
                                            }),
                                        hintText: LocaleKeys.confirmPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys
                                                .emptyConfirmPassword.tr;
                                          } else if (storeOwnerSignUpController
                                                  .passwordController.value.text
                                                  .trim()
                                                  .compareTo(
                                                      storeOwnerSignUpController
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
                                        controller: storeOwnerSignUpController
                                            .phoneController,
                                        keyboardType: TextInputType.phone,
                                        hintText: LocaleKeys.phoneNumber,
                                        prefixIcon: SvgPicture.asset(
                                          ImageConstanst.phoneCallIcon,
                                          color: AppColors.primaryColor,
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        //   textInputAction: TextInputAction.done,
                                        /* onSubmitted: (term) {
                                          FocusScope.of(context).unfocus();
                                          storeOwnerSignUpController.signUp();
                                        },*/
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LocaleKeys
                                                .emptyPhoneNumber.tr;
                                          } else if (storeOwnerSignUpController
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
                                            storeOwnerSignUpController
                                                .notifyCheckBox(),
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
                                                              storeOwnerSignUpController
                                                                  .agree,
                                                          activeColor: AppColors
                                                              .primaryColor,
                                                          onChanged: (value) {
                                                            storeOwnerSignUpController
                                                                .notifyCheckBox();
                                                          }))),
                                              10.widthBox,
                                              Text(
                                                LocaleKeys.agreeTerms.tr,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              )
                                            ])),
                                    15.heightBox,
                                    CustomButton(
                                        text: LocaleKeys.createAccount,
                                        onPressed: () {
                                          storeOwnerSignUpController.signUp();
                                        }),
                                    Visibility(
                                        visible:
                                            storeOwnerSignUpController.loading,
                                        child: 5.heightBox),
                                    Visibility(
                                      visible:
                                          storeOwnerSignUpController.loading,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: CircularProgressIndicator(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                          )),
                                    ),
                                    Visibility(
                                        visible:
                                            storeOwnerSignUpController.loading,
                                        child: 5.heightBox),
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
