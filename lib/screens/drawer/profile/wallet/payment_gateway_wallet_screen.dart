import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/cart_controller.dart';
import 'package:tmween/controller/payment_gateway_wallet_controller.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../lang/locale_keys.g.dart';
import '../../../../utils/my_shared_preferences.dart';
import '../../../../utils/views/custom_button.dart';

class PaymentGatewayWalletScreen extends StatefulWidget {
  final String? paymentAmount;

  PaymentGatewayWalletScreen({Key? key, this.paymentAmount}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentGatewayWalletStateScreen();
  }
}

class PaymentGatewayWalletStateScreen
    extends State<PaymentGatewayWalletScreen> {
  late String language;

  final paymentGatewayController = Get.put(PaymentGatewayWalletController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    paymentGatewayController.amount = widget.paymentAmount!;
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      paymentGatewayController.token = value!;
      print('dhsh.....${paymentGatewayController.token}');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        paymentGatewayController.userId = value!;
        paymentGatewayController.addWallet(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          paymentGatewayController.loginLogId = value!;
        });
      });
    });
    super.initState();
  }

  Future<bool> _onWillPop(
      PaymentGatewayWalletController paymentGatewayController) async {
    paymentGatewayController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    if (paymentGatewayController.orderPlaced == 1) {
      cartController.cartCount = 0;
    }
    return GetBuilder<PaymentGatewayWalletController>(
        init: PaymentGatewayWalletController(),
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
                           if (paymentGatewayController.addWalletData != null)
                            if (paymentGatewayController.orderPlaced != 4)
                            Expanded(
                                child: paymentGatewayController
                                        .addWalletData!.paymentUrl!.isNotEmpty
                                    ? paymentGatewayController.orderPlaced == 0
                                        ? openWebView(paymentGatewayController)
                                        : paymentGatewayController
                                                    .orderPlaced ==
                                                1
                                            ? orderPlace(
                                                paymentGatewayController,true)
                                            : orderPlace(
                                                paymentGatewayController,
                                              false)
                                    : paymentGatewayController.orderPlaced == 1
                                        ? orderPlace(paymentGatewayController,true)
                                        : paymentGatewayController
                                                    .orderPlaced ==
                                                2
                                            ? orderPlace(
                                                paymentGatewayController,
                                               false)
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

  Widget openWebView(PaymentGatewayWalletController paymentGatewayController) {
    return WebView(
      initialUrl: paymentGatewayController.addWalletData!.paymentUrl!,
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
        if (data.contains('http://tmween.com/')) {
          paymentGatewayController.orderPlaced = 4;
          paymentGatewayController.update();
           paymentGatewayController.getOrderStatus(language);
        }
        paymentGatewayController.update();
      },
    );
  }

  Widget paymentFail(
      PaymentGatewayWalletController paymentGatewayController, String messsage) {
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
          paymentGatewayController.orderPlaced == 3
              ? SvgPicture.asset(
            ImageConstanst.pageNotFoundIcon,
            height: 80,
            width: 80,
          ):
          Icon(
            CupertinoIcons.info_circle_fill,
            color: Colors.red,
            size: 62,
          ),
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

  Widget orderPlace(
      PaymentGatewayWalletController paymentGatewayController, bool isSuccess) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          20.heightBox,
          Align(
              alignment: Alignment.topCenter,
              child: isSuccess
                  ?  Image.asset(ImageConstanst.moneySuccessIcon,height: 90,width: 90,)
                  :  Image.asset(ImageConstanst.moneyFailedIcon,height: 90,width: 90,)

          ),
          20.heightBox,
          Text(
            LocaleKeys.paymentDetail.tr,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          10.heightBox,
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(
              10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.paymentStatus.tr,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  isSuccess ? LocaleKeys.successful.tr : LocaleKeys.failed.tr,
                  style: TextStyle(
                      color: isSuccess ? Colors.green : Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.rechargeAmount.tr,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${LocaleKeys.sar.tr} 500',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  Widget topView(PaymentGatewayWalletController paymentGatewayController) {
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
                  paymentGatewayController.orderPlaced==1?
                LocaleKeys.moneyAdded.tr
                :LocaleKeys.payments.tr
                ,
                style: TextStyle(fontSize: paymentGatewayController.orderPlaced==1?18:20
                   , color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
