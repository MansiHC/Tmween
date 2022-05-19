import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/cart_controller.dart';
import 'package:tmween/controller/payment_gateway_controller.dart';
import 'package:tmween/screens/drawer/profile/order/your_order_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../lang/locale_keys.g.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final int? paymentId;

  PaymentGatewayScreen({Key? key, this.paymentId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentGatewayStateScreen();
  }
}

class PaymentGatewayStateScreen extends State<PaymentGatewayScreen> {
  late String language;

  final paymentGatewayController = Get.put(PaymentGatewayController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    paymentGatewayController.paymentMethodId = widget.paymentId!;
    super.initState();
  }

  Future<bool> _onWillPop(
      PaymentGatewayController paymentGatewayController) async {
    paymentGatewayController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    if (paymentGatewayController.orderPlaced == 1) {
      cartController.cartCount = 0;
    }
    return GetBuilder<PaymentGatewayController>(
        init: PaymentGatewayController(),
        builder: (contet) {
          paymentGatewayController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(paymentGatewayController),
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
                              child: topView(paymentGatewayController)),
                          if (paymentGatewayController.checkoutData != null)
                            if (paymentGatewayController.orderPlaced != 4)
                            Expanded(
                                child: paymentGatewayController
                                        .checkoutData!.paymentUrl!.isNotEmpty
                                    ? paymentGatewayController.orderPlaced == 0
                                        ? openWebView(paymentGatewayController)
                                        : paymentGatewayController
                                                    .orderPlaced ==
                                                1
                                            ? orderPlace(
                                                paymentGatewayController)
                                            : paymentFail(
                                                paymentGatewayController,
                                                LocaleKeys
                                                    .paymentFailedText1.tr)
                                    : paymentGatewayController.orderPlaced == 1
                                        ? orderPlace(paymentGatewayController)
                                        : paymentGatewayController
                                                    .orderPlaced ==
                                                2
                                            ? paymentFail(
                                                paymentGatewayController,
                                                LocaleKeys
                                                    .paymentFailedText1.tr)
                                            : paymentFail(
                                                paymentGatewayController,
                                                LocaleKeys
                                                    .paymentFailedText2.tr)),
                          if (paymentGatewayController.orderPlaced == 3)
                            Expanded(
                                child: paymentFail(paymentGatewayController,
                                    LocaleKeys.paymentFailedText2.tr)) ,
                          if (paymentGatewayController.orderPlaced == 4)
                            Expanded(
                                child: Container())
                        ],
                      ))));
        });
  }

  Widget openWebView(PaymentGatewayController paymentGatewayController) {
    return WebView(
      initialUrl: paymentGatewayController.checkoutData!.paymentUrl!,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (request) {
        print('...url.......${request.url}');
        return NavigationDecision.navigate;
      },
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'messageHandler',
            onMessageReceived: (JavascriptMessage message) {
              print('msg........${message.message}');
            })
      ]),
      onWebViewCreated: (WebViewController webViewController) {
        paymentGatewayController.webViewController = webViewController;
      },
      onPageFinished: (data) {
        print('....$data');
        if (data.contains('http://tmween.com/en/syberpay')) {
           paymentGatewayController.orderPlaced = 4;
           paymentGatewayController.update();
          paymentGatewayController.getOrderStatus(language);
        }
        paymentGatewayController.update();
      },
    );
  }

  Widget orderPlace(PaymentGatewayController paymentGatewayController) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(paymentGatewayController.context).size.width / 9),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          AppColors.blueGradient1,
          AppColors.blueGradient2,
          AppColors.blueGradient3,
          AppColors.blueGradient3,
          AppColors.blueGradient3,
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.checkmark_circle_fill,
            color: Colors.green,
            size: 62,
          ),
          10.heightBox,
          Text(
            LocaleKeys.orderPlaced.tr,
            style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          10.heightBox,
          Text(
            LocaleKeys.orderPlacedText1.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
          ),
          Text(
            LocaleKeys.orderPlacedText2.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black45,
            ),
          ),
          30.heightBox,
          CustomButton(
              width: 180,
              horizontalPadding: 10,
              text: LocaleKeys.myOrders,
              onPressed: () {
                paymentGatewayController.navigateTo(YourOrderScreen());
              })
        ],
      ),
    );
  }

  Widget paymentFail(
      PaymentGatewayController paymentGatewayController, String messsage) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(paymentGatewayController.context).size.width / 4.5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          AppColors.redGradient1,
          AppColors.redGradient2,
          AppColors.redGradient3,
          AppColors.redGradient3,
          AppColors.redGradient3,
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         /* paymentGatewayController.orderPlaced == 3
         ?*/ SvgPicture.asset(
            ImageConstanst.pageNotFoundIcon,
            height: 80,
            width: 80,
          )/*:
          Icon(
            CupertinoIcons.info_circle_fill,
            color: Colors.red,
            size: 62,
          )*/,
          10.heightBox,
          Text(
            paymentGatewayController.orderPlaced == 3
                ? language == 'ar'
                    ? '!${LocaleKeys.pageNotFound.tr}'
                    : '${LocaleKeys.pageNotFound.tr}!'
                : language == 'ar'
                    ? '!${LocaleKeys.paymentFailed.tr}'
                    : '${LocaleKeys.paymentFailed.tr}!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          10.heightBox,
          if (paymentGatewayController.orderPlaced != 3)
            Text(
              messsage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
          30.heightBox,
          CustomButton(
              width: 180,
              horizontalPadding: 10,
              text: LocaleKeys.tryAgain,
              backgroundColor: Colors.red,
              onPressed: () {
                paymentGatewayController.exitScreen();
              })
        ],
      ),
    );
  }

  Widget topView(PaymentGatewayController paymentGatewayController) {
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
                        paymentGatewayController.exitScreen();
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
                LocaleKeys.deliveryPayment.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
