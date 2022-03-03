import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/top_selection_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';

class TopSelectionContainer extends StatelessWidget {
  TopSelectionContainer({Key? key, required this.topSelection})
      : super(key: key);
  final TopSelectionModel topSelection;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 165,
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
          color: Colors.white,
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
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.offerGreen,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(topSelection.rating,
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
                  Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: AppColors.offerGreen,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        children: [
                          Text('${topSelection.offer}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          Text(LocaleKeys.off.tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      )),
                ])),
        5.heightBox,
        Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  topSelection.image,
                  fit: BoxFit.contain,
                ))),
        5.heightBox,
        Padding(
            padding: EdgeInsets.only(left: 5, right: 15),
            child: Text(topSelection.title,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(color: Color(0xFF333333), fontSize: 13))),
        5.heightBox,
        if (topSelection.fulfilled)
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
              Text('${LocaleKeys.sar.tr} ${topSelection.price}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              2.widthBox,
              Expanded(
                  child: Text(
                      '${LocaleKeys.sar.tr} ${topSelection.beforePrice!}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
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
