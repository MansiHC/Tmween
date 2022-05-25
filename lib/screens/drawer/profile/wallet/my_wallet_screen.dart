import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<bool> _onWillPop(MyWalletController myWalletController) async {
    myWalletController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<MyWalletController>(
        init: MyWalletController(),
        builder: (contet) {
          myWalletController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(myWalletController),
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
                              child: topView(myWalletController)),
                          if (myWalletController.walletData != null)
                            _bottomView(myWalletController),
                        ],
                      ))));
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
                                myWalletController.walletData!.balance!,
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
                      child: Form(
                          key: myWalletController.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                isPrefix: false,
                                controller: myWalletController.amountController,
                                keyboardType: TextInputType.number,
                                hintText: LocaleKeys.amount.tr,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '${LocaleKeys.emptyEnter.tr} ${LocaleKeys.amount.tr}';
                                  }
                                  return null;
                                },
                                prefixIcon: Text(
                                  LocaleKeys.sar.tr,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              15.heightBox,
                              Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: List.generate(
                                    myWalletController.amounts.length,
                                    (index) => InkWell(
                                        onTap: () {
                                          if (myWalletController
                                              .amountController.text.isNotEmpty)
                                            myWalletController.amountController
                                                .text = (int.parse(
                                                        myWalletController
                                                            .amountController
                                                            .text) +
                                                    int.parse(myWalletController
                                                        .amounts[index]))
                                                .toString();
                                          else
                                            myWalletController
                                                    .amountController.text =
                                                myWalletController
                                                    .amounts[index];
                                          myWalletController.update();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.lightBlueBackground,
                                              border: Border.all(
                                                  color: AppColors.blue),
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
                                  if (myWalletController.formKey.currentState!
                                      .validate()) {
                                    
                                    Navigator.push(myWalletController.context, MaterialPageRoute(builder: (context) => FundWalletScreen(
                                        paymentAmount: myWalletController
                                            .amountController.text))).then((value) => myWalletController.getWalletData(language));
                                  }
                                },
                                fontSize: 15,
                              ),
                            ],
                          )),
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
                    myWalletController.walletHistoryList.length > 0
                        ? Container(
                            color: Colors.white,
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: ScrollPhysics(),
                                itemCount:
                                    myWalletController.walletHistoryList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: AppColors.lightBlueBackground,
                                        width: double.maxFinite,
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          myWalletController
                                              .walletHistoryList[index].month!,
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
                                                  .monthData!
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
                                                            monthData: myWalletController
                                                                .walletHistoryList[
                                                                    index]
                                                                .monthData![index2],
                                                          ));
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 42,
                                                                  height: 42,
                                                                  child: Image
                                                                      .asset(
                                                                    ImageConstanst
                                                                        .walletLogoIcon,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                                                        child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              myWalletController.walletHistoryList[index].monthData![index2].message!,
                                                                              style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              myWalletController.walletHistoryList[index].monthData![index2].createdAt!.formattedDateTime,
                                                                              style: TextStyle(
                                                                                color: Colors.black38,
                                                                                fontSize: 13,
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
                                                                      myWalletController.walletHistoryList[index].monthData![index2].transactionType ==
                                                                              1
                                                                          ? '+${myWalletController.walletData!.currencySymbol!} ${myWalletController.walletHistoryList[index].monthData![index2].amount!}'
                                                                          : '-${myWalletController.walletData!.currencySymbol!} ${myWalletController.walletHistoryList[index].monthData![index2].amount!}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: getColor(myWalletController
                                                                            .walletHistoryList[index]
                                                                            .monthData![index2]
                                                                            .transactionType!),
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getStatus(myWalletController
                                                                          .walletHistoryList[
                                                                              index]
                                                                          .monthData![
                                                                              index2]
                                                                          .paymentStatus!),
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
                                                                          .grey[
                                                                      400],
                                                                )
                                                              ],
                                                            ))),
                                                    10.heightBox,
                                                    if (index !=
                                                        (myWalletController
                                                                .walletHistoryList[
                                                                    index]
                                                                .monthData!
                                                                .length -
                                                            1))
                                                      Divider(
                                                        height: 1,
                                                        thickness: 1,
                                                        color:
                                                            Color(0xFFE6E6E6),
                                                      )
                                                  ],
                                                );
                                              }))
                                    ],
                                  );
                                }))
                        : Center(
                            child: Text(
                            LocaleKeys.noTransactionFound.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ))
                  ],
                ))));
  }

  Color getColor(int transactionType) {
   if (transactionType == 1)
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
      return LocaleKeys.successful.tr;
    else
      return LocaleKeys.failed.tr;
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
