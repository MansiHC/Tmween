import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/fund_wallet_controller.dart';
import '../../../lang/locale_keys.g.dart';

class FundWalletScreen extends StatelessWidget {
  late String language;

  final fundWalletController = Get.put(FundWalletController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<FundWalletController>(
        init: FundWalletController(),
        builder: (contet) {
          fundWalletController.context = context;
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
                          child: topView(fundWalletController)),
                      _bottomView(fundWalletController),
                    ],
                  )));
        });
  }

  Widget _bottomView(FundWalletController fundWalletController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recharge Amount',
                            style: TextStyle(
                              color: Color(0xFF7D7D7D),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${LocaleKeys.sar.tr} 100',
                            style: TextStyle(
                              color: Color(0xFF7D7D7D),
                              fontSize: 14,
                            ),
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
                            'Total Amount Payable',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${LocaleKeys.sar.tr} 100',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    Text(
                      'Payment Option',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            10.heightBox,
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(children: [
                                      SvgPicture.asset(
                                        ImageConstanst.upiIcon,
                                        height: 24,
                                        width: 24,
                                      ),
                                      15.widthBox,
                                      Text(
                                        'UPI',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.grey[600],
                                    )
                                  ],
                                )),
                            10.heightBox,
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE6E6E6),
                            ),
                            10.heightBox,
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(children: [
                                      SvgPicture.asset(
                                        ImageConstanst.creditCardIcon,
                                        height: 24,
                                        width: 24,
                                      ),
                                      15.widthBox,
                                      Text(
                                        'Credit/Debit Card',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.grey[600],
                                    )
                                  ],
                                )),
                            10.heightBox,
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE6E6E6),
                            ),
                            10.heightBox,
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(children: [
                                      SvgPicture.asset(
                                        ImageConstanst.internetBankingIcon,
                                        height: 24,
                                        width: 24,
                                      ),
                                      15.widthBox,
                                      Text(
                                        'Net Banking',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.grey[600],
                                    )
                                  ],
                                )),
                            10.heightBox,
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFE6E6E6),
                            ),
                          ],
                        ))
                  ],
                ))));
  }

  Widget topView(FundWalletController fundWalletController) {
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
                        fundWalletController.exitScreen();
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
                'Payment',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
