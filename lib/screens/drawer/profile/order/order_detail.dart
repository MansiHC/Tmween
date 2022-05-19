import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmween/controller/order_detail_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/productDetail/product_detail_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';

import '../../../../utils/my_shared_preferences.dart';

class OrderDetailScreen extends StatefulWidget {
  final String? orderId;

  OrderDetailScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OrderDetailScreenState();
  }
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  late String language;
  final orderDetailController = Get.put(OrderDetailController());

  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;

  @override
  void initState() {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      orderDetailController.token = value!;
      print('dhsh.....${orderDetailController.token}');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        orderDetailController.userId = value!;
        orderDetailController.orderId = widget.orderId;
        orderDetailController.getOrderDetail(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          orderDetailController.loginLogId = value!;
        });
      });
    });

    super.initState();
  }

  Future<bool> _onWillPop(OrderDetailController orderDetailController) async {
    orderDetailController.exitScreen();
    return true;
  }

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        Helper.showToast(LocaleKeys.downloading.tr);

        await dio.download(orderDetailController.invoiceUrl!,
            dirloc + convertCurrentDateTimeToString() + ".pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            print(progress);
          });
        });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        Helper.showToast(LocaleKeys.downloaded.tr);
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";
      });
      print(path);
      print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile();
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<OrderDetailController>(
        init: OrderDetailController(),
        builder: (contet) {
          orderDetailController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(orderDetailController),
              child: Scaffold(
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
                          if (orderDetailController.orderData != null)
                            Expanded(child: _bottomView(orderDetailController))
                        ],
                      ))));
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
                      orderDetailController.orderData!.orderDate!
                          .split(' ')[0]
                          .formattedDate,
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
                      orderDetailController.orderData!.orderNumber!,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      LocaleKeys.orderTotal.tr,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      orderDetailController.orderData!.grandTotal!,
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
          InkWell(
              onTap: () async {
                Helper.showLoading();
                // update();
                await orderDetailController.api
                    .getInvoice(
                        orderDetailController.userId,
                        orderDetailController.token,
                        orderDetailController.orderId,
                        language)
                    .then((value) {
                  if (value.statusCode == 200) {
                    orderDetailController.isLoading = false;
                    Helper.hideLoading(context);
                    orderDetailController.invoiceUrl = value.data!;
                    downloadFile();
                  } else {
                    orderDetailController.isLoading = false;
                    Helper.hideLoading(context);
                  }
                  //update();
                }).catchError((error) {
                  Helper.hideLoading(context);
                  orderDetailController.isLoading = false;
                  orderDetailController.update();
                  print('error....$error');
                });
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.downloadInvoice.tr,
                        style: TextStyle(
                            color: Color(0xFF3F3F3F),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Color(0xFF262938),
                      )
                    ],
                  ))),
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
                        child: orderDetailController.orderData!
                                .salesOrderItem![0].largeImageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: orderDetailController.orderData!
                                    .salesOrderItem![0].largeImageUrl!,
                                height: MediaQuery.of(context).size.width / 4.5,
                                placeholder: (context, url) =>
                                    Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.width / 5.3,
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ))),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            orderDetailController
                                .orderData!.salesOrderItem![0].productName!,
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
                                text: orderDetailController
                                    .orderData!.salesOrderItem![0].brandName,
                                style: TextStyle(
                                  color: Color(0xFF4BA2C2),
                                  fontSize: 13,
                                ),
                              )
                            ])),
                        5.heightBox,
                        Text(
                            orderDetailController
                                .orderData!.salesOrderItem![0].itemStatusLabel!,
                            style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        10.heightBox,
                        InkWell(
                            onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(
                                  productId: orderDetailController
                                      .orderData!
                                      .salesOrderItem![0]
                                      .productId,
                                  productslug: orderDetailController
                                      .orderData!
                                      .salesOrderItem![0]
                                      .slug![0]
                                      .productSlug))).then((value) => orderDetailController.getOrderDetail(language));

                            },
                            child: Container(
                              color: Color(0xFF0088C8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(LocaleKeys.buyItAgain.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                            )),
                        8.heightBox,
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(
                                productId: orderDetailController
                                    .orderData!
                                    .salesOrderItem![0]
                                    .productId,
                                productslug: orderDetailController
                                    .orderData!
                                    .salesOrderItem![0]
                                    .slug![0]
                                    .productSlug))).then((value) => orderDetailController.getOrderDetail(language));

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
                      orderDetailController
                          .orderData!.paymentMethodName![0].methodName!,
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
                      orderDetailController
                          .orderData!.salesOrderAddr![0].fullname!,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${orderDetailController.orderData!.salesOrderAddr![0].address1!},',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${orderDetailController.orderData!.salesOrderAddr![0].address2!},',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${orderDetailController.orderData!.salesOrderAddr![0].city!}, ${orderDetailController.orderData!.salesOrderAddr![0].zip!},',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      orderDetailController
                          .orderData!.salesOrderAddr![0].country!,
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
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
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
                      orderDetailController.orderData!.subTotal!,
                      textAlign: TextAlign.right,
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
                      orderDetailController.orderData!.shippingPrice!,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      '${LocaleKeys.tax.tr}:',
                      style: TextStyle(
                        color: Color(0xFF3F3F3F),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      orderDetailController.orderData!.taxAmount!,
                      textAlign: TextAlign.right,
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
                      orderDetailController.orderData!.grandTotal!,
                      textAlign: TextAlign.right,
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
