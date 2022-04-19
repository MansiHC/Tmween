import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/review_order_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class ItemShippedContainer extends StatelessWidget {
  /* ItemShippedContainer(
      {Key? key, required this.cartProductModel, required this.index})
      : super(key: key);
  final CartDetails cartProductModel;
  int index;
*/
  var language;
  final reviewOrderController = Get.put(ReviewOrderController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ReviewOrderController>(
        init: ReviewOrderController(),
        builder: (contet) {
          reviewOrderController.context = context;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Item will ship from Tmween',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              10.heightBox,
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "https://s3.me-south-1.amazonaws.com/tmween-stag/product/3/1645184496_ksix_oppo_a15_full_glue_2.5d_tempered_glass_9h.jpg"
                                .isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://s3.me-south-1.amazonaws.com/tmween-stag/product/3/1645184496_ksix_oppo_a15_full_glue_2.5d_tempered_glass_9h.jpg",
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
                                ))
                      ],
                    ),
                    5.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ProductName",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        3.heightBox,
                        Wrap(
                          children: [
                            Text('SAR 26',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough)),
                            10.widthBox,
                            Text('SAR 26',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFFF57051),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        3.heightBox,
                        if (true)
                          Text(LocaleKeys.inStock.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xFF3B963C),
                                fontSize: 13,
                              )),
                        3.heightBox,
                        Text('Sold by: Vatsal Shah',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 13,
                            )),
                        3.heightBox,
                        Wrap(children: [
                          Text('Quantity: 1',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey[700]!,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          5.widthBox,
                          Text('Change',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 13,
                              )),
                        ]),
                        10.heightBox,
                        Text("Choose a delivery speed:",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        5.heightBox,
                        InkWell(
                            onTap: (){
                              reviewOrderController.radioCurrentValue =
                              1;
                              reviewOrderController.update();
                            },
                            child:
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Radio(
                                value: 1,
                                groupValue:
                                    reviewOrderController.radioCurrentValue,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                activeColor: Color(0xFF1992CE),
                                onChanged: (int? value) {
                                  reviewOrderController.radioCurrentValue =
                                      value!;
                                  reviewOrderController.update();
                                },
                              ),
                            ),
                            5.widthBox,
                            Expanded(
                                child: Wrap(children: [
                              Text('Standard Delivery',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF3B963C),
                                    fontSize: 13,
                                  )),
                              Text(' - Delivery Price: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 13,
                                  )),

                              Text(" SAR 2111.22",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ]))
                          ],
                        )),
                        3.heightBox,
                        InkWell(
                        onTap: (){
                        reviewOrderController.radioCurrentValue =
                        2;
                        reviewOrderController.update();
                        },
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Radio(
                                value: 2,
                                groupValue:
                                    reviewOrderController.radioCurrentValue,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                activeColor: Color(0xFF1992CE),
                                onChanged: (int? value) {
                                  reviewOrderController.radioCurrentValue =
                                      value!;
                                  reviewOrderController.update();
                                },
                              ),
                            ),
                            5.widthBox,
                            Expanded(
                                child: Wrap(children: [
                              Text('Quick Delivery',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF3B963C),
                                    fontSize: 13,
                                  )),
                              Text(' - Delivery Price: ',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 13,
                                  )),
                              Text("SAR 2111.22",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ]))
                          ],
                        )),
                        10.heightBox
                      ],
                    )),
                  ])
            ],
          );
        });
  }
}
