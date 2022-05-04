import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/order_detail_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class OrderDetailScreen extends StatelessWidget {
  late String language;
  final orderDetailController = Get.put(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<OrderDetailController>(
        init: OrderDetailController(),
        builder: (contet) {
          orderDetailController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(orderDetailController)),
                      Expanded(child: _bottomView(orderDetailController))
                    ],
                  )));
        });
  }

  Widget _bottomView(OrderDetailController orderDetailController) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.viewOrderDetails.tr,
            style: TextStyle(
                color: Color(0xFF383838),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          20.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Table(
                children: [
                  TableRow(children: [
                    Text(
                      LocaleKeys.orderDate.tr,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '27-Dec-2021',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      LocaleKeys.orderNumber.tr,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '408-20155847-2541781',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      'Order Total',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${LocaleKeys.sar.tr} 1,499.00',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                ],
              )),
          10.heightBox,
          Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFEFEFEF),
          ),
          10.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.downloadInvoice.tr,
                    style: TextStyle(
                      color: Color(0xFF3F3F3F),
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Color(0xFF262938),
                  )
                ],
              )),
          25.heightBox,
          Text(LocaleKeys.shippingDetails.tr,
              style: TextStyle(
                  color: Color(0xFF383838),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          10.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Image.asset(
                          'asset/image/my_cart_images/book.png',
                          fit: BoxFit.contain,
                          height: 70,
                          width: 70,
                        )),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Book name - author name details of book',
                            style: TextStyle(
                                color: Color(0xFF090909),
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        5.heightBox,
                        RichText(
                            text: TextSpan(
                                text: '${LocaleKeys.soldBy.tr}: ',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 13,
                                ),
                                children: [
                              TextSpan(
                                text: 'Brand name',
                                style: TextStyle(
                                  color: Color(0xFF4BA2C2),
                                  fontSize: 13,
                                ),
                              )
                            ])),
                        5.heightBox,
                        Text('Delivered wednesday',
                            style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        10.heightBox,
                        Container(
                          color: Color(0xFF0088C8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(LocaleKeys.buyItAgain.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              )),
                        ),
                        8.heightBox,
                        InkWell(
                          onTap: () {
                            /* orderDetailController
                                .navigateTo(ReviewProductScreen());*/
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF3C3C3C))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(LocaleKeys.writeProductReview.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF3C3C3C),
                                  fontSize: 12,
                                )),
                          ),
                        )
                      ],
                    ))
                  ])),
          25.heightBox,
          Text(LocaleKeys.paymentInfo.tr,
              style: TextStyle(
                  color: Color(0xFF383838),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    Text(LocaleKeys.paymentMethod.tr,
                        style: TextStyle(
                            color: Color(0xFF383838),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text(
                      'Visa ending in 9876',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                  ])),
          25.heightBox,
          Text(LocaleKeys.shippingAddress.tr,
              style: TextStyle(
                  color: Color(0xFF383838),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    Text(
                      'Salim Akka',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '102/11,',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Street colony, New Jersey,',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Columbia, 220011,',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'United State',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                  ])),
          25.heightBox,
          Text(LocaleKeys.orderSummary.tr,
              style: TextStyle(
                  color: Color(0xFF383838),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          10.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(10),
                  1: FlexColumnWidth(3),
                },
                children: [
                  TableRow(children: [
                    Text(
                      '${LocaleKeys.items.tr}:',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${LocaleKeys.sar.tr} 1,499',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${LocaleKeys.shipping.tr}:',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${LocaleKeys.sar.tr} 40',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${LocaleKeys.total.tr}:',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${LocaleKeys.sar.tr} 40',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${LocaleKeys.grandTotal.tr}:',
                      style: TextStyle(
                          color: Color(0xFF383838),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${LocaleKeys.sar.tr} 1,499',
                      style: TextStyle(
                          color: Color(0xFF383838),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ],
              )),
          30.heightBox,
        ],
      ),
    ));
  }

  Widget topView(OrderDetailController orderDetailController) {
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
                        orderDetailController.exitScreen();
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
                LocaleKeys.orderDetails.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
