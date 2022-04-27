import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/sub_category_product_listing_model.dart';
import '../../../utils/global.dart';

class CategoryProductListingContainer extends StatelessWidget {
  CategoryProductListingContainer({Key? key, required this.productData}) : super(key: key);
  final ProductData productData;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 165,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 1)
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
                  productData.reviewsAvg == 0
                      ? Container(
                          width: 10,
                        )
                      : Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppColors.offerGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(productData.reviewsAvg.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 12,
                              )
                            ],
                          )),
                  if (productData.discountValuePercentage != 0)
                    Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: AppColors.offerGreen,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Column(
                          children: [
                            Text('${productData.discountValuePercentage}%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            Text(LocaleKeys.off.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        )),
                ])),
        5.heightBox,
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: productData.largeImageUrl!.setNetworkImage())),
        5.heightBox,
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 5, right: 15),
                child: Text(productData.productName!,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                Text('${productData.finalPriceDisp!}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                2.widthBox,
                Text('${productData.retailPriceDisp!}',
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
