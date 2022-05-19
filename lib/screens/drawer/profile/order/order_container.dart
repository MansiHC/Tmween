import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/order_listing_model.dart';
import 'package:tmween/screens/drawer/profile/order/order_detail.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../../controller/your_order_controller.dart';
import '../../productDetail/product_detail_screen.dart';

class OrderContainer extends StatelessWidget {
  OrderContainer(
      {Key? key,
      required this.order,
      required this.index,
      required this.length})
      : super(key: key);
  final OrderData order;
  final int index;
  final int length;
  var language;
  final yourOrderController = Get.put(YourOrderController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<YourOrderController>(
        init: YourOrderController(),
        builder: (contet) {
          yourOrderController.context = context;
          return Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(orderId: order.id.toString()))).then((value) =>
                        yourOrderController.getOrderList(language));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: order.salesOrderItem![0].largeImageUrl!
                                      .isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: order
                                          .salesOrderItem![0].largeImageUrl!,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              4.5,
                                width:
                                          MediaQuery.of(context).size.width /
                                              4.5,
                                      placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.width /
                                              5.3,
                                  width:
                                          MediaQuery.of(context).size.width /
                                              5.3,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ))),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.heightBox,
                              Text(order.salesOrderItem![0].productName!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              5.heightBox,
                              Text(order.itemStatusLabel!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF646464),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              10.heightBox,
                              // if (order.isRating)
                              AbsorbPointer(
                                  absorbing: true,
                                  child: RatingBar.builder(
                                    wrapAlignment: WrapAlignment.start,
                                    itemSize: 24,
                                    initialRating: double.parse(order
                                        .salesOrderItem![0].reviewsAvg!
                                        .toString()),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    unratedColor: Color(0xFFDDDDDD),
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Color(0xFFFEBD06),
                                    ),
                                    onRatingUpdate: (rating) {},
                                  )),
                              5.heightBox,
                              //if (order.isRating)
                              InkWell(
                                  onTap: () {
                                    /* yourOrderController
                                          .navigateTo(ReviewProductScreen());*/
                                    yourOrderController.navigateTo(
                                        ProductDetailScreen(
                                            productId: order
                                                .salesOrderItem![0].productId,
                                            productslug: order
                                                .salesOrderItem![0]
                                                .slug![0]
                                                .productSlug));

                                  },
                                  child: Text(LocaleKeys.writeReview.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF0283CA),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold))),
                              5.heightBox
                            ],
                          )),
                          10.widthBox,
                          InkWell(
                              onTap: () {},
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Color(0xFF233040),
                                  ))),
                        ]),
                  )),
              if (index != (length - 1))
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE6E6E6),
                )
            ],
          );
        });
  }
}
