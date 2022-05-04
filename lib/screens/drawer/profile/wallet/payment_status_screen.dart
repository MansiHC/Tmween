import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../controller/payment_status_controller.dart';

class PaymentStatusScreen extends StatefulWidget {
  final bool? isSuccess;
  final String? successText;

  PaymentStatusScreen(
      {Key? key, required this.isSuccess, required this.successText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentStatusScreenState();
  }
}

class PaymentStatusScreenState extends State<PaymentStatusScreen> {
  late String language;

  final paymentStatusController = Get.put(PaymentStatusController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<PaymentStatusController>(
        init: PaymentStatusController(),
        builder: (contet) {
          paymentStatusController.context = context;
          return Scaffold(
              body: Container(
                  color: Color(0xFFF2F2F2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(paymentStatusController)),
                      _bottomView(paymentStatusController),
                    ],
                  )));
        });
  }

  Widget _bottomView(PaymentStatusController paymentStatusController) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.all(
          15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  LocaleKeys.amount.tr,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      '${LocaleKeys.sar.tr} 1,990',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    5.widthBox,
                    SvgPicture.asset(
                      widget.isSuccess!
                          ? ImageConstanst.walletTickMarkIcon
                          : ImageConstanst.walletCrossIcon,
                      height: 24,
                      width: 24,
                    ),
                    5.widthBox,
                    Text(
                      widget.isSuccess! ? LocaleKeys.paymentSuccess.tr : LocaleKeys.paymentFailed.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: widget.isSuccess! ? Colors.green : Colors.red),
                    ),
                  ],
                )),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'One Thousand Nine Hundred Ninety Only',
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                )),
            10.heightBox,
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[200],
            ),
            10.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  LocaleKeys.to.tr,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  LocaleKeys.otherAccount.tr,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
            10.heightBox,
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[200],
            ),
            10.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                 LocaleKeys.from.tr,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageConstanst.syberPay,
                      height: 24,
                      width: 24,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          LocaleKeys.syberPay.tr,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        )),
                  ],
                )),
            10.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${LocaleKeys.addedAt.tr} 11:56AM, 20 Mar 2022',
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                    text: TextSpan(
                        text: '${LocaleKeys.walletRefNo.tr}: 3876543215 ',
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                        children: [
                      TextSpan(
                        text: LocaleKeys.copy.tr,
                        style: TextStyle(fontSize: 13, color: AppColors.blue),
                      )
                    ]))),
            10.heightBox
          ],
        ));
  }

  Widget topView(PaymentStatusController paymentStatusController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        paymentStatusController.exitScreen();
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
                widget.successText!,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
