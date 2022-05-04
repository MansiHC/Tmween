import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_cart_products_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../../utils/global.dart';
import '../../../controller/cart_controller.dart';
import '../productDetail/product_detail_screen.dart';

class RecommendedProductContainer extends StatelessWidget {
  RecommendedProductContainer({Key? key, required this.recommendedProductModel})
      : super(key: key);
  final RecommendationProducts recommendedProductModel;
  var language;
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (contet) {
          cartController.context = context;
          return InkWell(
              onTap: () {
                cartController.navigateTo(ProductDetailScreen(
                    productId: recommendedProductModel.id,
                    productslug: recommendedProductModel.productSlug!));
              },
              child: Container(
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
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: recommendedProductModel
                                      .largeImageUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: recommendedProductModel
                                          .largeImageUrl!,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              4.5,
                                      width: MediaQuery.of(context).size.width /
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
                              Text(recommendedProductModel.productName!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              5.heightBox,
                              if (true)
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
                                children: [
                                  Text(
                                      '${recommendedProductModel.finalPriceDisp}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFFF57051),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  10.widthBox,
                                  Text(
                                      '${recommendedProductModel.retailPriceDisp}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF818181),
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12)),
                                ],
                              ),
                              if (recommendedProductModel.discountPer! > 0)
                                5.heightBox,
                              if (recommendedProductModel.discountPer! > 0)
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text:
                                            '${LocaleKeys.youSave.tr} ${recommendedProductModel.discountPerDisp}! ',
                                        style: TextStyle(
                                            color: Color(0xFF3B963C),
                                            fontSize: 12),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                '${recommendedProductModel.discountPer}% ${LocaleKeys.off.tr}!',
                                            style: TextStyle(
                                              fontSize: 12,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Color(0xFF3B963C),
                                            ),
                                          )
                                        ])),
                              10.heightBox,
                              InkWell(
                                  onTap: () {
                                    cartController.navigateTo(
                                        ProductDetailScreen(
                                            productId:
                                                recommendedProductModel.id,
                                            productslug: recommendedProductModel
                                                .productSlug!));
                                  },
                                  child: Container(
                                    color: Color(0xFF0088CA),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(LocaleKeys.addToCart.tr,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  )),
                              10.heightBox
                            ],
                          )),
                        ])),
              ));
        });
  }
}
