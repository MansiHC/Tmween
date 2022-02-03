import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/provider/otp_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/otp_text_filed.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(builder: (context, otpProvider, _) {
      otpProvider.context = context;
      return Scaffold(
          body: Column(
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
      ));
    });
  }

  Widget bottomView(OtpProvider otpProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your OTP code here',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        40.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OtpTextFormField(
                onChanged: (value) {
                  if (value.length == 1) {
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
                clicked: otpProvider.click4,
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
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
        30.heightBox,
        Text(
          "Didn't you received any code?",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        5.heightBox,
        Text(
          "Resend a new code.",
          style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
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
                'Phone Verification',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
