import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/payment_option_controller.dart';
import 'package:tmween/screens/drawer/checkout/review_order_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class PaymentOptionScreen extends StatelessWidget {
  late String language;

  final paymentOptionController = Get.put(PaymentOptionController());

  Future<bool> _onWillPop(
      PaymentOptionController paymentOptionController) async {
    paymentOptionController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<PaymentOptionController>(
        init: PaymentOptionController(),
        builder: (contet) {
          paymentOptionController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(paymentOptionController),
              child: Scaffold(
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
                      ))));
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

            Expanded(
              child:  ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: paymentOptionController.paymentOptions.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){
                        paymentOptionController.radioCurrentValue = paymentOptionController.radioValue[index];
                        paymentOptionController.update();
                      },
                      child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Row(children: [
                      Container(
                        height: 40,
                        child: Radio(
                          value: paymentOptionController.radioValue[index],
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
                          child: Text(paymentOptionController.paymentOptions[index].methodName!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: 15,
                              ))),
                      paymentOptionController.paymentOptions[index].smallImageUrl!.isNotEmpty
                          ? CachedNetworkImage(
                        imageUrl:
                        paymentOptionController.paymentOptions[index].smallImageUrl!,
                          height: MediaQuery.of(context).size.width / 9,
                          width: MediaQuery.of(context).size.width / 9,
                        placeholder: (context, url) =>
                            Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      )
                          : Container(
                          height: MediaQuery.of(context).size.width / 9,
                          width: MediaQuery.of(context).size.width / 9,
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ))
                    ]),
                  ));
                }),
          ),
            10.heightBox,
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                       paymentOptionController.setPaymentOption(language);
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
