import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/otp_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/otp_text_filed.dart';

import '../../../utils/views/custom_button.dart';

class LoginOtpScreen extends StatefulWidget {
  final String phoneEmail;

  LoginOtpScreen({Key? key, required this.phoneEmail}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginOtpScreenState();
  }
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(builder: (context, otpProvider, _) {
      otpProvider.context = context;
      otpProvider.phone = widget.phoneEmail;
      return Scaffold(
          body: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              constraints:
                  BoxConstraints(minWidth: double.infinity, maxHeight: 90),
              color: Colors.black,
              padding: EdgeInsets.only(top: 20),
              child: topView(otpProvider)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: bottomView(otpProvider),
          )
        ],
      )));
    });
  }

  Widget bottomView(OtpProvider otpProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${LocaleKeys.inText.tr()} ${widget.phoneEmail}',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            5.widthBox,
            InkWell(
                onTap: () {
                  otpProvider.exitScreen();
                },
                child: Wrap(
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
        Text(
          LocaleKeys.sentOTPEmail.tr(),
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        10.heightBox,
        Text(
          LocaleKeys.enterOTP.tr(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        10.heightBox,
        buildTimer(),
        40.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OtpTextFormField(
                controller: otpProvider.num1Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    otpProvider.notifyClick1(true);
                    FocusScope.of(context).nextFocus();
                    otpProvider.notifyClick2(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(context).previousFocus();
                    otpProvider.notifyClick1(false);
                  }
                },
                clicked: otpProvider.click1,
                onTap: () {
                  otpProvider.notifyClick1(true);
                }),
            OtpTextFormField(
                controller: otpProvider.num2Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    otpProvider.notifyClick3(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(context).previousFocus();
                    otpProvider.notifyClick2(false);
                  }
                },
                clicked: otpProvider.click2,
                onTap: () {
                  otpProvider.notifyClick2(true);
                }),
            OtpTextFormField(
                controller: otpProvider.num3Controller,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    otpProvider.notifyClick4(true);
                  }
                  if (value.length == 0) {
                    FocusScope.of(context).previousFocus();
                    otpProvider.notifyClick3(false);
                  }
                },
                clicked: otpProvider.click3,
                onTap: () {
                  otpProvider.notifyClick3(true);
                }),
            OtpTextFormField(
                controller: otpProvider.num4Controller,
                clicked: otpProvider.click4,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                    otpProvider.verifyLoginOTP();
                  }
                  if (value.length == 0) {
                    FocusScope.of(context).previousFocus();
                    otpProvider.notifyClick4(false);
                  }
                },
                onTap: () {
                  otpProvider.notifyClick4(true);
                }),
          ],
        ),
        Visibility(visible: otpProvider.loading, child: 5.heightBox),
        Visibility(
          visible: otpProvider.loading,
          child: Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primaryColor,
              )),
        ),
        Visibility(visible: otpProvider.loading, child: 5.heightBox),
        30.heightBox,
        Text(
          LocaleKeys.notReceivedOtp.tr(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        5.heightBox,
        InkWell(
            onTap: () {
              otpProvider.resendOTP();
            },
            child: Text(
              LocaleKeys.resendCode.tr(),
              style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
            )),
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
        CustomButton(
            text: LocaleKeys.loginWithPassword,
            onPressed: () {
              otpProvider.navigateToPasswordScreen();
            })
      ],
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.otpExpire.tr(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        /*TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value!.toInt()}",
            style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
          ),
        ),*/
        TweenAnimationBuilder<Duration>(
            duration: Duration(minutes: 1),
            tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
            onEnd: () {
              print('Timer ended');
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)));
            }),
      ],
    );
  }

  Widget topView(OtpProvider otpProvider) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        otpProvider.exitScreen();
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
            50.widthBox,
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.phoneVerification.tr(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
