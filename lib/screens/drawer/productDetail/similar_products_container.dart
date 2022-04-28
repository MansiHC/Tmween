import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/product_detail_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class SimilarProductsContainer extends StatelessWidget {
  SimilarProductsContainer({Key? key, required this.products})
      : super(key: key);
  final SimilarProduct products;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 165,
      margin: EdgeInsets.only(right: 7, top: 5, bottom: 5, left: 3),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, blurRadius: 3, spreadRadius: 3)
          ],
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        5.heightBox,
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  products.reviewsAvg == 0
                      ? Container(
                          width: 10,
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                              color: AppColors.offerGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(products.reviewsAvg.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 11,
                              )
                            ],
                          )),
                  if (products.discountValuePercentage != 0)
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Color(0xFFFF9529),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            Text('${products.discountValuePercentage}%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                            2.widthBox,
                            Text(LocaleKeys.off.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        )),
                ])),
        5.heightBox,
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: products.largeImageUrl!.setNetworkImage())),
        5.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child:Padding(
            padding: EdgeInsets.only(left: 5, right: 15),
            child: Text(products.productName!,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(color: Color(0xFF333333), fontSize: 13)))),
        5.heightBox,
        if (true)
          Padding(
              padding: EdgeInsets.only(left: 5, right: 15),
              child: Align(
                  alignment: language == 'ar'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: LocaleKeys.fulfilledBy.tr,
                          style: TextStyle(
                              fontSize: 11, color: AppColors.primaryColor),
                          children: <InlineSpan>[
                            TextSpan(
                              text: LocaleKeys.appTitle.tr,
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ]))))
        else
          13.heightBox,
        5.heightBox,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              color: AppColors.darkGrayBackground,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4))),
          child: Row(
            children: [
              Expanded(
                  child: Wrap(children: [
                Text('${products.finalPriceDisp!}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                2.widthBox,
                Text('${products.retailPriceDisp!}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 3,
                        color: Color(0xFF7B7B7B),
                        fontSize: 10))
              ])),
              2.widthBox,
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(
                    LocaleKeys.add.tr,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
