import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/payment_option_controller.dart';
import 'package:tmween/controller/review_order_controller.dart';
import 'package:tmween/screens/drawer/checkout/review_order_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class PaymentOptionScreen extends StatelessWidget {
  late String language;

  final paymentOptionController = Get.put(PaymentOptionController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<PaymentOptionController>(
        init: PaymentOptionController(),
        builder: (contet) {
          paymentOptionController.context = context;
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
                          child: topView(paymentOptionController)),
                      Expanded(child: _bottomView(paymentOptionController)),
                    ],
                  )));
        });
  }

  Widget _bottomView(PaymentOptionController paymentOptionController) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              10.heightBox,
              Text(
                'All other options',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            10.heightBox,
Expanded(child: Column(children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child:
                    Row(children: [
                      Container(
                        height: 40,
                        child: Radio(
                          value: 1,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),  groupValue: paymentOptionController.radioCurrentValue,
                          activeColor: Color(0xFF1992CE),
                          onChanged: (int? value) {
                            paymentOptionController.radioCurrentValue = value!;
                            paymentOptionController.update();
                          },
                        ),
                      ),
                      5.widthBox,
                      Expanded(
                          child: Text('Syber Pay',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 15,))),
                      SvgPicture.asset(
                        ImageConstanst.syberPay,
                        height: 24,
                        width: 24,
                      ),
                    ]) ,
                   ),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child:
                    Row(children: [
                      Container(
                        height: 40,
                        child: Radio(
                          value: 2,
                          visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity,
                          ),
                          groupValue: paymentOptionController.radioCurrentValue,
                          activeColor: Color(0xFF1992CE),
                          onChanged: (int? value) {
                            paymentOptionController.radioCurrentValue = value!;
                            paymentOptionController.update();
                          },
                        ),
                      ),
                      5.widthBox,
                      Expanded(
                          child: Text('Cash on Delivery',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 15))),
                      SvgPicture.asset(
                        ImageConstanst.cashOnDelivertIcon,
                        height: 24,
                        width: 24,
                      ),
                    ]) ,
                   ),
],)),
            10.heightBox,
            Align(
                alignment: Alignment.bottomCenter,
                child:Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Wrap(spacing: 10, children: [
                    Text(
                      'Proceed to Pay',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SvgPicture.asset(
                      ImageConstanst.payIcon,
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    )
                  ]),
                  onPressed: () {
                    paymentOptionController.navigateTo(ReviewOrderScreen());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF27AF61)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10)),
                  ),
                ))),
            15.heightBox,
          ],
        ));
  }

  Widget topView(PaymentOptionController paymentOptionController) {
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
                        paymentOptionController.exitScreen();
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
                'Payments',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
