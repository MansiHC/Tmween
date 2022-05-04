import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/wallet/fund_wallet_screen.dart';
import 'package:tmween/screens/drawer/profile/wallet/payment_status_screen.dart';
import 'package:tmween/screens/drawer/profile/wallet/view_history_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../../controller/my_wallet_controller.dart';
import '../../../../utils/views/custom_text_form_field.dart';

class MyWalletScreen extends StatelessWidget {
  late String language;

  final myWalletController = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<MyWalletController>(
        init: MyWalletController(),
        builder: (contet) {
          myWalletController.context = context;
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
                          child: topView(myWalletController)),
                      _bottomView(myWalletController),
                    ],
                  )));
        });
  }

  Widget _bottomView(MyWalletController myWalletController) {
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
                        children: [
                          SvgPicture.asset(
                            ImageConstanst.yourWalletIcon,
                            color: Color(0xFF555555),
                            height: 32,
                            width: 32,
                          ),
                          10.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${LocaleKeys.currentBalance.tr} ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              3.heightBox,
                              Text(
                                '${LocaleKeys.sar.tr} 0',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    15.heightBox,
                    Text(
                      LocaleKeys.addMoney.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    10.heightBox,
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                              isPrefix: false,
                              controller: myWalletController.amountController,
                              keyboardType: TextInputType.number,
                              hintText: LocaleKeys.amount.tr,
                              prefixIcon: Text(
                                LocaleKeys.sar.tr,
                                style: TextStyle(fontSize: 14),
                              ),
                              validator: (value) {}),
                          15.heightBox,
                          Wrap(
                              spacing: 10,
                              children: List.generate(
                                myWalletController.amounts.length,
                                (index) => InkWell(
                                    onTap: () {
                                      myWalletController.amountController.text =
                                          myWalletController.amounts[index];
                                      myWalletController.update();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: AppColors.lightBlueBackground,
                                          border:
                                              Border.all(color: AppColors.blue),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Text(
                                        '+${LocaleKeys.sar.tr} ${myWalletController.amounts[index]}',
                                        style: TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 12),
                                      ),
                                    )),
                              )),
                          20.heightBox,
                          CustomButton(
                            text: LocaleKeys.fundWalletCap.tr,
                            onPressed: () {
                              myWalletController.navigateTo(FundWalletScreen());
                            },
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                    15.heightBox,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.walletActivityFor.tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(0xFF555555),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomButton(
                            width: 120,
                            horizontalPadding: 0,
                            text: LocaleKeys.viewHistory.tr,
                            onPressed: () {
                              myWalletController
                                  .navigateTo(ViewHistoryScreen());
                            },
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                    Container(
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            itemCount:
                                myWalletController.walletHistoryList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: AppColors.lightBlueBackground,
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      myWalletController
                                          .walletHistoryList[index].title,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  MediaQuery.removePadding(
                                      context: myWalletController.context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: myWalletController
                                              .walletHistoryList[index]
                                              .historyItemList
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                10.heightBox,
                                                InkWell(
                                                    onTap: () {
                                                      myWalletController
                                                          .navigateTo(
                                                              PaymentStatusScreen(
                                                        isSuccess:
                                                            myWalletController
                                                                .walletHistoryList[
                                                                    index]
                                                                .historyItemList[
                                                                    index2]
                                                                .isSuccess,
                                                        successText:
                                                            myWalletController
                                                                .walletHistoryList[
                                                                    index]
                                                                .historyItemList[
                                                                    index2]
                                                                .successText,
                                                      ));
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 42,
                                                              height: 42,
                                                              child:
                                                                  Image.asset(
                                                                ImageConstanst
                                                                    .walletLogoIcon,
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          myWalletController
                                                                              .walletHistoryList[index]
                                                                              .historyItemList[index2]
                                                                              .title,
                                                                          style: TextStyle(
                                                                              color: Colors.black87,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          myWalletController
                                                                              .walletHistoryList[index]
                                                                              .historyItemList[index2]
                                                                              .date,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black38,
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  myWalletController
                                                                          .walletHistoryList[
                                                                              index]
                                                                          .historyItemList[
                                                                              index2]
                                                                          .isSuccess
                                                                      ? '+${LocaleKeys.sar.tr} 500'
                                                                      : '-${LocaleKeys.sar.tr} 500',
                                                                  style:
                                                                      TextStyle(
                                                                    color: myWalletController
                                                                            .walletHistoryList[
                                                                                index]
                                                                            .historyItemList[
                                                                                index2]
                                                                            .isSuccess
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  myWalletController
                                                                      .walletHistoryList[
                                                                          index]
                                                                      .historyItemList[
                                                                          index2]
                                                                      .successText,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_right_outlined,
                                                              color: Colors
                                                                  .grey[400],
                                                            )
                                                          ],
                                                        ))),
                                                10.heightBox,
                                                if (index !=
                                                    (myWalletController
                                                            .walletHistoryList[
                                                                index]
                                                            .historyItemList
                                                            .length -
                                                        1))
                                                  Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    color: Color(0xFFE6E6E6),
                                                  )
                                              ],
                                            );
                                          }))
                                ],
                              );
                            }))
                  ],
                ))));
  }

  Widget topView(MyWalletController myWalletController) {
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
                        myWalletController.exitScreen();
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
                LocaleKeys.myWallet.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
