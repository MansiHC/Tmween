import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/profile/payment_status_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/view_history_controller.dart';

class ViewHistoryScreen extends StatelessWidget {
  late String language;

  final viewHistoryController = Get.put(ViewHistoryController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ViewHistoryController>(
        init: ViewHistoryController(),
        builder: (contet) {
          viewHistoryController.context = context;
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
                          child: topView(viewHistoryController)),
                      _bottomView(viewHistoryController),
                    ],
                  )));
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
                          "From Date",
                          style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold),
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
                                      ? "Choose Date"
                                      : viewHistoryController.fromDate,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
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
                            "To Date",
                            style: TextStyle(color: Colors.black54, fontSize: 14,fontWeight: FontWeight.bold),
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
                                        ? "Choose Date"
                                        : viewHistoryController.toDate,
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                              ],
                            ),
                          )
                        ]),
                    10.widthBox,
                  Expanded(child: Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Container(
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          color: AppColors.primaryColor,
                          padding: EdgeInsets.all(5),
                        ))),

                  ],
                ),
                Align(alignment: Alignment.centerRight,child:InkWell(onTap: (){
                  showModalBottomSheet<void>(
                      context: viewHistoryController.context,
                      builder: (BuildContext context) {
                        return _bottomSheetView(viewHistoryController);
                      });
                },child:
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Wrap(
                      children: [
                        Text(
                          'Filter',
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
                Expanded(
                    child: Container(
                        color: Colors.white,
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
                                          .walletHistoryList[index].title,
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
                                                      viewHistoryController
                                                          .navigateTo(
                                                              PaymentStatusScreen(
                                                        isSuccess:
                                                            viewHistoryController
                                                                .walletHistoryList[
                                                                    index]
                                                                .historyItemList[
                                                                    index2]
                                                                .isSuccess,
                                                        successText:
                                                            viewHistoryController
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
                                                                          viewHistoryController
                                                                              .walletHistoryList[index]
                                                                              .historyItemList[index2]
                                                                              .title,
                                                                          style: TextStyle(
                                                                              color: Colors.black87,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          viewHistoryController
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
                                                                  viewHistoryController
                                                                          .walletHistoryList[
                                                                              index]
                                                                          .historyItemList[
                                                                              index2]
                                                                          .isSuccess
                                                                      ? '+SAS 500'
                                                                      : '-SAS 500',
                                                                  style:
                                                                      TextStyle(
                                                                    color: viewHistoryController
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
                                                                  viewHistoryController
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
                                                    (viewHistoryController
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
                            })))
              ],
            )));
  }

  _bottomSheetView(ViewHistoryController viewHistoryController) {
    return GetBuilder<ViewHistoryController>(
        init: ViewHistoryController(),
        builder: (contet) {
          return Container(
              height:280,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Text(
                    'Filter Payments',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  10.heightBox,
                  Text(
                    'Status',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                       ),
                  ),
                  10.heightBox,
                  Wrap(spacing:10,children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15)
                      ),
                    
                     child: Text(
                      'Successful',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14),
                    ),), Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15)
                      ),

                      child: Text(
                      'Pending',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14),
                    ),), Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)
                      ),

                     child: Text(
                      'Failed',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14),
                    ),),
                  ],),
                  10.heightBox,
                  Text(
                    'Type',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  10.heightBox,
                  Wrap(spacing:10,children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]!)
                      ),

                      child: Text(
                        'Paid',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14),
                      ),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[300]!)
                      ),

                      child: Text(
                        'Added',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14),
                      ),), Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[300]!)
                      ),

                      child: Text(
                        'Cashback',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14),
                      ),),
                  ],),
                  15.heightBox,
                  Row(children: [
                    Expanded(child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: AppColors.primaryColor)
                      ),

                      child: Text(
                        'Clear',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14),
                      ),)),
                    10.widthBox,
                    Expanded(child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(color: AppColors.primaryColor)
                      ),

                      child: Text(
                        'Apply',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14),
                      ),))
                  ],)
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
                'View History',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
