import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmween/provider/signup_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class IndividualSignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndividualSignUpScreenState();
  }
}

class _IndividualSignUpScreenState extends State<IndividualSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      signUpProvider.context = context;
      return LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Form(
                            key: signUpProvider.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                  controller:
                                      signUpProvider.firstNameController,
                                  keyboardType: TextInputType.name,
                                  hintText: "First Name",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter First Name';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                    controller:
                                        signUpProvider.lastNameController,
                                    keyboardType: TextInputType.name,
                                    hintText: "Last Name",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Last Name';
                                      }
                                      return null;
                                    }),
                                CustomTextFormField(
                                    controller: signUpProvider.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: "Your Email",
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'[/\\]')),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Your Email';
                                      } else if (!signUpProvider
                                          .emailController.value.text
                                          .validateEmail()) {
                                        return 'Please Enter Valid Email';
                                      }
                                      return null;
                                    }),
                                CustomTextFormField(
                                    controller:
                                        signUpProvider.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: signUpProvider.visiblePassword,
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          signUpProvider.visiblePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          signUpProvider
                                              .visiblePasswordIcon();
                                        }),
                                    hintText: "Your Passowrd",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter Password';
                                      } else if (signUpProvider
                                              .passwordController
                                              .value
                                              .text
                                              .length <
                                          8) {
                                        return 'Password Length must be 8';
                                      }  else if (!signUpProvider
                                          .passwordController.value.text
                                          .validatePassword()) {
                                      return 'Password should Contain at least one UpperCase, one LowerCase, one Digit,one Special Character';
                                      }
                                      return null;
                                    }),
                                CustomTextFormField(
                                    controller: signUpProvider
                                        .confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: signUpProvider.visibleConfirmPassword,
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          signUpProvider.visibleConfirmPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          signUpProvider
                                              .visibleConfirmPasswordIcon();
                                        }),
                                    hintText: "Confirm Password",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'PLease Enter Confirm Password';
                                      } else if (signUpProvider
                                              .passwordController.value.text
                                              .trim()
                                              .compareTo(signUpProvider
                                                  .confirmPasswordController
                                                  .value
                                                  .text
                                                  .trim()) !=
                                          0) {
                                        return "Password and Confirm Password doesn't match";
                                      }
                                      return null;
                                    }),
                                CustomTextFormField(
                                    controller: signUpProvider.phoneController,
                                    keyboardType: TextInputType.phone,
                                    hintText: "Phone",
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (term) {
                                      FocusScope.of(context).unfocus();
                                      signUpProvider.signUp();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'emptyMobileNumber';
                                      } else if (signUpProvider.phoneController
                                              .value.text.length <
                                          10) {
                                        return 'validMobileNumber';
                                      }
                                      return null;
                                    }),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () =>
                                        signUpProvider.notifyCheckBox(),
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
                                                          signUpProvider.agree,
                                                      activeColor: AppColors
                                                          .primaryColor,
                                                      onChanged: (value) {
                                                        signUpProvider
                                                            .notifyCheckBox();
                                                      }))),
                                          10.widthBox,
                                          Text(
                                            "I agree to the terms of use",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          )
                                        ])),
                                15.heightBox,
                                CustomButton(
                                    text: "Create Account",
                                    onPressed: () {
                                      signUpProvider.signUp();
                                    }),
                                Visibility(visible: signUpProvider.loading, child: 5.heightBox),
                                Visibility(
                                  visible: signUpProvider.loading,
                                  child: Align(alignment: Alignment.topCenter,child:CircularProgressIndicator(
                                    backgroundColor: AppColors.primaryColor,
                                  )),
                                ),
                                Visibility(visible: signUpProvider.loading, child: 5.heightBox),
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
                                      'or',
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
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Have an account with us? Login Here",
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
                                                    "By clicking 'Create Account', you \nagree to our ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: 'Privacy Policy',
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
