import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../../controller/view_history_controller.dart';

class ViewHistoryScreen extends StatelessWidget {
  late String language;

  final viewHistoryController = Get.put(ViewHistoryController());

  Future<bool> _onWillPop(ViewHistoryController viewHistoryController) async {
    viewHistoryController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ViewHistoryController>(
        init: ViewHistoryController(),
        builder: (contet) {
          viewHistoryController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(viewHistoryController),
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
                              child: topView(viewHistoryController)),
                          if (viewHistoryController.walletData != null)
                            _bottomView(viewHistoryController),
                        ],
                      ))));
        });
  }

  Widget _bottomView(ViewHistoryController viewHistoryController) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(
              15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.fromDate.tr,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        5.heightBox,
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!)),
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: AppColors.blue,
                                size: 20,
                              ),
                              5.widthBox,
                              InkWell(
                                onTap: () {
                                  viewHistoryController.selectFromDate();
                                },
                                child: Text(
                                  viewHistoryController.fromDate.isEmpty
                                      ? LocaleKeys.chooseDate.tr
                                      : viewHistoryController.fromDate,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                            ],
                          ),
                        )
                      ],
                    ),
                    5.widthBox,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.toDate.tr,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          5.heightBox,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[300]!)),
                            padding: EdgeInsets.all(5),
                            child: Wrap(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: AppColors.blue,
                                  size: 20,
                                ),
                                5.widthBox,
                                InkWell(
                                  onTap: () {
                                    viewHistoryController.selectToDate();
                                  },
                                  child: Text(
                                    viewHistoryController.toDate.isEmpty
                                        ? LocaleKeys.chooseDate.tr
                                        : viewHistoryController.toDate,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                                ),
                                //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                              ],
                            ),
                          )
                        ]),
                    10.widthBox,
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              viewHistoryController
                                  .getWalletHistoryData(language);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Container(
                                  child: Text(
                                    LocaleKeys.submit.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  color: AppColors.primaryColor,
                                  padding: EdgeInsets.all(5),
                                )))),
                  ],
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: viewHistoryController.context,
                              builder: (BuildContext context) {
                                return _bottomSheetView(viewHistoryController);
                              });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Wrap(
                              children: [
                                Text(
                                  LocaleKeys.filter.tr,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black87),
                                ),
                                10.widthBox,
                                SvgPicture.asset(
                                  ImageConstanst.filterIcon,
                                  height: 24,
                                  width: 24,
                                )
                              ],
                            )))),
                10.heightBox,
                viewHistoryController.walletHistoryList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            itemCount:
                                viewHistoryController.walletHistoryList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: AppColors.lightBlueBackground,
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      viewHistoryController
                                          .walletHistoryList[index].month!,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  MediaQuery.removePadding(
                                      context: viewHistoryController.context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: viewHistoryController
                                              .walletHistoryList[index]
                                              .monthData!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Container(
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    10.heightBox,
                                                    InkWell(
                                                        onTap: () {
                                                          /*viewHistoryController
                                                          .navigateTo(
                                                              PaymentStatusScreen(
                                                        isSuccess:
                                                            viewHistoryController
                                                                .walletHistoryList[
                                                                    index]
                                                                .monthData![
                                                                    index2]
                                                                .isSuccess,
                                                        successText:
                                                            viewHistoryController
                                                                .walletHistoryList[
                                                                    index]
                                                                .monthData![
                                                                    index2]
                                                                .successText,
                                                      ));*/
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
                                                                              viewHistoryController.walletHistoryList[index].monthData![index2].message!,
                                                                              style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              viewHistoryController.walletHistoryList[index].monthData![index2].createdAt!.formattedDateTime,
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
                                                                      viewHistoryController.walletHistoryList[index].monthData![index2].transactionType ==
                                                                              1
                                                                          ? '+${viewHistoryController.walletData!.currencySymbol!} ${viewHistoryController.walletHistoryList[index].monthData![index2].amount!}'
                                                                          : '-${viewHistoryController.walletData!.currencySymbol!} ${viewHistoryController.walletHistoryList[index].monthData![index2].amount!}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: getColor(viewHistoryController
                                                                            .walletHistoryList[index]
                                                                            .monthData![index2]
                                                                            .transactionType!),
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getStatus(viewHistoryController
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
                                                        (viewHistoryController
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
                                                ));
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
            )));
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

  _bottomSheetView(ViewHistoryController viewHistoryController) {
    return GetBuilder<ViewHistoryController>(
        init: ViewHistoryController(),
        builder: (contet) {
          return Container(
              height: 300,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Text(
                    LocaleKeys.filterPayments.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  10.heightBox,
                  Text(
                    LocaleKeys.status.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  10.heightBox,
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      InkWell(
                          onTap: () {
                            viewHistoryController.paymentStatus = "3";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.paymentStatus == "3"
                                        ? Colors.green
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color:
                                        viewHistoryController.paymentStatus ==
                                                "3"
                                            ? Colors.white
                                            : Colors.green)),
                            child: Text(
                              LocaleKeys.successful.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.paymentStatus == "3"
                                          ? Colors.white
                                          : Colors.green,
                                  fontSize: 14),
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            viewHistoryController.paymentStatus = "1";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.paymentStatus == "1"
                                        ? Colors.orange
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color:
                                        viewHistoryController.paymentStatus ==
                                                "1"
                                            ? Colors.white
                                            : Colors.orange)),
                            child: Text(
                              LocaleKeys.pending.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.paymentStatus == "1"
                                          ? Colors.white
                                          : Colors.orange,
                                  fontSize: 14),
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            viewHistoryController.paymentStatus = "4";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.paymentStatus == "4"
                                        ? Colors.red
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color:
                                        viewHistoryController.paymentStatus ==
                                                "4"
                                            ? Colors.white
                                            : Colors.red)),
                            child: Text(
                              LocaleKeys.failed.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.paymentStatus == "4"
                                          ? Colors.white
                                          : Colors.red,
                                  fontSize: 14),
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            viewHistoryController.paymentStatus = "2";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.paymentStatus == "2"
                                        ? Color(0xFFffc107)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color:
                                        viewHistoryController.paymentStatus ==
                                                "2"
                                            ? Colors.white
                                            : Color(0xFFffc107))),
                            child: Text(
                              LocaleKeys.processing.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.paymentStatus == "2"
                                          ? Colors.white
                                          : Color(0xFFffc107),
                                  fontSize: 14),
                            ),
                          )),
                    ],
                  ),
                  10.heightBox,
                  Text(
                    LocaleKeys.type.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  10.heightBox,
                  Wrap(
                    spacing: 10,
                    children: [
                      InkWell(
                          onTap: () {
                            viewHistoryController.transactionType = "2";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.transactionType == "2"
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey[300]!)),
                            child: Text(
                              LocaleKeys.paid.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.transactionType ==
                                              "2"
                                          ? Colors.white
                                          : Colors.black54,
                                  fontSize: 14),
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            viewHistoryController.transactionType = "1";
                            viewHistoryController.update();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    viewHistoryController.transactionType == "1"
                                        ? AppColors.primaryColor
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey[300]!)),
                            child: Text(
                              LocaleKeys.added.tr,
                              style: TextStyle(
                                  color:
                                      viewHistoryController.transactionType ==
                                              "1"
                                          ? Colors.white
                                          : Colors.black54,
                                  fontSize: 14),
                            ),
                          )),
                    ],
                  ),
                  15.heightBox,
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                viewHistoryController.transactionType = "";
                                viewHistoryController.paymentStatus = "";
                                viewHistoryController.update();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Text(
                                  LocaleKeys.clear.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14),
                                ),
                              ))),
                      10.widthBox,
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                viewHistoryController.pop();
                                viewHistoryController
                                    .getWalletHistoryData(language);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Text(
                                  LocaleKeys.applySmall.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              )))
                    ],
                  )
                ],
              ));
        });
  }

  Widget topView(ViewHistoryController viewHistoryController) {
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
                        viewHistoryController.exitScreen();
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
                LocaleKeys.viewHistory.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
