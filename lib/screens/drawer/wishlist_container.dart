import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_wishlist_details_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class WishlistContainer extends StatelessWidget {
  WishlistContainer({Key? key, required this.wishlistData}) : super(key: key);
  final WishlistData wishlistData;
  var language;
  final wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (contet) {
          wishlistController.context = context;
          return Container(
            width: 165,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 1)
                ],
                border: Border.all(color: Color(0xFFE8E8E8)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  5.heightBox,
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            wishlistData.reviewsAvg == 0
                                ? Container(
                                    width: 10,
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: AppColors.offerGreen,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(wishlistData.reviewsAvg.toString(),
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
                            InkWell(
                                onTap: () {
                                  wishlistController.removeWishlistProduct(
                                      wishlistData.id, language);
                                },
                                child: Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFDDDDDD),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ))),
                          ])),
                  5.heightBox,
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child:
                              wishlistData.largeImageUrl!.setNetworkImage())),
                  5.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 15),
                          child: Text(wishlistData.productName!,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xFF333333), fontSize: 13)))),
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
                                        fontSize: 11,
                                        color: AppColors.primaryColor),
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
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Wrap(children: [
                          Text('${wishlistData.finalPrice!}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          2.widthBox,
                          Text('${wishlistData.retailPrice!}',
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Text(
                              LocaleKeys.add.tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          );
        });
  }
}

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/sold_by_tmween_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class WishlistContainer extends StatelessWidget {
  WishlistContainer({Key? key, required this.wishlistData}) : super(key: key);
  final wishlistDataModel wishlistData;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 165,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 1)
          ],
          border: Border.all(color: Color(0xFFE8E8E8)),
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
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.offerGreen,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(wishlistData.rating,
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
                  Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          color: Color(0xFFDDDDDD),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      )),
                ])),
        5.heightBox,
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  wishlistData.image,
                  fit: BoxFit.contain,
                ))),
        5.heightBox,
        Padding(
            padding: EdgeInsets.only(left: 5, right: 15),
            child: Text(wishlistData.title,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(color: Color(0xFF333333), fontSize: 13))),
        5.heightBox,
        if (wishlistData.fulfilled)
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
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4))),
          child: Row(
            children: [
              Text('${LocaleKeys.sar.tr} ${wishlistData.price}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              2.widthBox,
              Expanded(
                  child: Text(
                      '${LocaleKeys.sar.tr} ${wishlistData.beforePrice!}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3,
                          color: Color(0xFF7B7B7B),
                          fontSize: 10))),
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
*/
