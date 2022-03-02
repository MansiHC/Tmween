import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/cart_product_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../utils/global.dart';
import '../../controller/cart_controller.dart';
import '../../model/recommended_product_model.dart';

class RecommendedProductContainer extends StatelessWidget {
  RecommendedProductContainer({Key? key, required this.recommendedProductModel})
      : super(key: key);
  final RecommendedProductModel recommendedProductModel;
  var language;
  final cartController = Get.put(CartController());


  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return  GetBuilder<CartController>(
        init: CartController(),
    builder: (contet) {
    cartController.context = context;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFF3F3F3)),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Padding(padding: EdgeInsets.only(top:20),child:Image.network(
                      recommendedProductModel.image,
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    )),
                10.widthBox,
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.heightBox,
                    Text(recommendedProductModel.title,
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 12,fontWeight: FontWeight.bold)),
                 5.heightBox,
                    if (recommendedProductModel.isFulFilled)
                      RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: LocaleKeys.fulfilledBy.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryColor),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: LocaleKeys.appTitle.tr,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ])),
                    Wrap(

                      children:
                    [
                      Text('${LocaleKeys.sar.tr} ${recommendedProductModel.price}',
                          textAlign: TextAlign.start,
                          style:
                          TextStyle(color: Color(0xFFF57051), fontSize: 12,fontWeight: FontWeight.bold)),
                      10.widthBox,
                      Text('${LocaleKeys.sar.tr} ${recommendedProductModel.offerPrice}',
                          textAlign: TextAlign.start,
                          style:
                          TextStyle(color: Color(0xFF818181),
                              decoration:TextDecoration.lineThrough,fontSize: 12)),

                    ],),
                    5.heightBox,
                    if(recommendedProductModel.isYouSave)
                      RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: 'You save ${LocaleKeys.sar.tr} ${recommendedProductModel.savePrice}! ',
                            style:
                            TextStyle(color: Color(0xFF3B963C), fontSize: 12),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '${recommendedProductModel.saveOffer}% ${LocaleKeys.off.tr}!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF3B963C),
                                  ),
                                )
                              ])),

                    10.heightBox,
                    Container(color:Color(0xFF0088CA),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child:
                          Text('ADD TO CART',
                              textAlign: TextAlign.start,
                              style:
                              TextStyle(color: Colors.white, fontSize: 12)),

                        ),
                    10.heightBox
                  ],
                )),
              ])),
    );});
  }
}
