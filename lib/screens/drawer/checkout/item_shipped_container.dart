import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/review_order_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/review_order_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class ItemShippedContainer extends StatelessWidget {
  ItemShippedContainer(
      {Key? key, required this.quoteItemData, required this.index})
      : super(key: key);
  final QuoteItemData quoteItemData;
  int index;
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
              Text(
                  '${LocaleKeys.itemWillShipFrom.tr} ${quoteItemData.supplierName}',
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
                        quoteItemData.largeImageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: quoteItemData.largeImageUrl!,
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
                        Text(quoteItemData.productName!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        3.heightBox,
                        Wrap(
                          children: [
                            Text(
                                '${LocaleKeys.sar.tr} ${quoteItemData.finalPrice}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                  decorationThickness: 2,
                                )),
                            10.widthBox,
                            Text(
                                '${LocaleKeys.sar.tr} ${quoteItemData.retailPrice}',
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
                        Text(
                            '${LocaleKeys.soldBy.tr}: ${quoteItemData.supplierName}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 13,
                            )),
                        3.heightBox,
                        Wrap(children: [
                          Text(
                              '${LocaleKeys.quantity.tr}: ${quoteItemData.quantity}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey[700]!,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700)),
                          5.widthBox,
                          InkWell(
                              onTap: () {
                                reviewOrderController.pop();
                                reviewOrderController.pop();
                                reviewOrderController.pop();
                              },
                              child: Text(LocaleKeys.change.tr,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 13,
                                  ))),
                        ]),
                        10.heightBox,
                        Text('${LocaleKeys.chooseDeliverySpeed.tr}:',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        5.heightBox,
                        InkWell(
                            onTap: () {
                              reviewOrderController
                                      .radioValue[index].currentId =
                                  reviewOrderController.radioValue[index].id[0];
                              reviewOrderController.update();
                              reviewOrderController.changeDeliverySpeed(
                                  quoteItemData.id, 1, language);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  child: Radio(
                                    value: reviewOrderController
                                        .radioValue[index].id[0],
                                    groupValue: reviewOrderController
                                        .radioValue[index].currentId,
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    activeColor: Color(0xFF1992CE),
                                    onChanged: (int? value) {
                                      reviewOrderController
                                          .radioValue[index].currentId = value!;
                                      reviewOrderController.update();
                                      reviewOrderController.changeDeliverySpeed(
                                          quoteItemData.id, 1, language);
                                    },
                                  ),
                                ),
                                5.widthBox,
                                Expanded(
                                    child: Wrap(children: [
                                  Text(LocaleKeys.standardDelivery.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFF3B963C),
                                        fontSize: 13,
                                      )),
                                  Text(' - ${LocaleKeys.deliveryPrice.tr}: ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 13,
                                      )),
                                  Text(
                                      "${LocaleKeys.sar.tr} ${quoteItemData.normalDeliveryPrice}",
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
                            onTap: () {
                              reviewOrderController
                                      .radioValue[index].currentId =
                                  reviewOrderController.radioValue[index].id[1];
                              reviewOrderController.update();
                              reviewOrderController.changeDeliverySpeed(
                                  quoteItemData.id, 2, language);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  child: Radio(
                                    value: reviewOrderController
                                        .radioValue[index].id[1],
                                    groupValue: reviewOrderController
                                        .radioValue[index].currentId,
                                    visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity,
                                    ),
                                    activeColor: Color(0xFF1992CE),
                                    onChanged: (int? value) {
                                      reviewOrderController
                                          .radioValue[index].currentId = value!;
                                      reviewOrderController.update();
                                      reviewOrderController.changeDeliverySpeed(
                                          quoteItemData.id, 2, language);
                                    },
                                  ),
                                ),
                                5.widthBox,
                                Expanded(
                                    child: Wrap(children: [
                                  Text(LocaleKeys.quickDelivery.tr,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFF3B963C),
                                        fontSize: 13,
                                      )),
                                  Text(' - ${LocaleKeys.deliveryPrice.tr}: ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 13,
                                      )),
                                  Text(
                                      "${LocaleKeys.sar.tr} ${quoteItemData.quickDeliveryPrice}",
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
