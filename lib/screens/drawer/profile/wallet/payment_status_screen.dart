import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_wallet_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import '../../../../controller/payment_status_controller.dart';
import '../../../../utils/number_to_words.dart';

class PaymentStatusScreen extends StatefulWidget {
  final MonthData? monthData;

  PaymentStatusScreen({Key? key, required this.monthData}) : super(key: key);

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
                      '${LocaleKeys.sar.tr} ${widget.monthData!.amount!}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    5.widthBox,
                    SvgPicture.asset(
                      getIcon(widget.monthData!.paymentStatus!),
                      height: 24,
                      width: 24,
                    ),
                    5.widthBox,
                    Text(
                      getStatus(widget.monthData!.paymentStatus!),
                      style: TextStyle(
                          fontSize: 14,
                          color: getColor(widget.monthData!.paymentStatus!)),
                    ),
                  ],
                )),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  NumberToWord().convert(language, widget.monthData!.amount!),
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
                child: widget.monthData!.paymentTransactionId != null
                    ? Row(
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
                      )
                    : Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                LocaleKeys.admin.tr,
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
                  '${LocaleKeys.addedAt.tr} ${widget.monthData!.createdAt!.formattedDateTime}',
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                )),
            if(widget.monthData!.paymentTransactionId!=null)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                    text: TextSpan(
                        text:
                            '${LocaleKeys.walletRefNo.tr}: ${widget.monthData!.paymentTransactionId} ',
                        style: TextStyle(fontSize: 13, color: Colors.black45),
                        children: [
                      /*TextSpan(
                        text: LocaleKeys.copy.tr,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Clipboard.setData(new ClipboardData(
                                text: widget.monthData!.paymentTransactionId!));
                            Helper.showToast(LocaleKeys.copiedToClipBoard.tr);
                          },
                        style: TextStyle(fontSize: 13, color: AppColors.blue),
                      )*/
                    ]))),
            10.heightBox
          ],
        ));
  }

  Color getColor(int paymentStatus) {
    if (paymentStatus == 1)
      return Colors.orange;
    else if (paymentStatus == 2)
      return Color(0xFFffc107);
    else if (paymentStatus == 3)
      return Colors.green;
    else
      return Colors.red;
  }


  String getStatus(int paymentStatus) {
    if (paymentStatus == 1)
      return LocaleKeys.pending.tr;
    else if (paymentStatus == 2)
      return LocaleKeys.processing.tr;
    else if (paymentStatus == 3)
      return LocaleKeys.paymentSuccess.tr;
    else
      return LocaleKeys.paymentFailed.tr;
  }

  String getIcon(int paymentStatus) {
    if (paymentStatus == 1)
      return ImageConstanst.walletPendingIcon;
    else if (paymentStatus == 2)
      return ImageConstanst.walletProcessingIcon;
    else if (paymentStatus == 3)
      return ImageConstanst.walletTickMarkIcon;
    else
      return ImageConstanst.walletCrossIcon;
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
                widget.monthData!.message!,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
