import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';

class IndividualLoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndividualLoginScreenState();
  }
}

class _IndividualLoginScreenState extends State<IndividualLoginScreen> {
  late LoginProvider loginProvider;
  var language;

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        loginProvider.getAndroidBuildData(
            await loginProvider.deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        loginProvider
            .getIosDeviceInfo(await loginProvider.deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      loginProvider.deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    language = context.locale.toString().split('_')[0];
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      loginProvider.context = context;
      return LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Form(
                            key: loginProvider.formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextFormField(
                                    controller: loginProvider.phoneController,
                                    keyboardType: TextInputType.phone,
                                    hintText: LocaleKeys.phoneNumber,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (term) {
                                      FocusScope.of(context).unfocus();
                                      loginProvider.login();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return LocaleKeys.emptyPhoneNumber.tr();
                                      } else if (loginProvider.phoneController
                                              .value.text.length <
                                          10) {
                                        return LocaleKeys.validPhoneNumber.tr();
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
                                        onPressed: () =>
                                            loginProvider.notifyCheckBox(),
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
                                                          activeColor: AppColors
                                                              .primaryColor,
                                                          value: loginProvider
                                                              .rememberMe,
                                                          onChanged: (value) {
                                                            loginProvider
                                                                .notifyCheckBox();
                                                          }))),
                                              10.widthBox,
                                              Text(
                                                LocaleKeys.keepMeSignedIn.tr(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              )
                                            ])),
                                    Expanded(
                                      child: Text(
                                          LocaleKeys.forgotPassword.tr(),
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
                                15.heightBox,
                                CustomButton(
                                    text: LocaleKeys.login,
                                    onPressed: () {
                                      loginProvider.login();
                                    }),
                                Visibility(
                                    visible: loginProvider.loading,
                                    child: 5.heightBox),
                                Visibility(
                                  visible: loginProvider.loading,
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: CircularProgressIndicator(
                                        backgroundColor: AppColors.primaryColor,
                                      )),
                                ),
                                Visibility(
                                    visible: loginProvider.loading,
                                    child: 5.heightBox),
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
                                      LocaleKeys.or.tr(),
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
                                      loginProvider.navigateToSignupScreen();
                                    },
                                    child: Text(
                                      LocaleKeys.createYourTmweenAccount.tr(),
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
                                                    "${LocaleKeys.agreeText.tr()} ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: LocaleKeys
                                                        .privacyPolicy
                                                        .tr(),
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
