import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/recommended_product_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/get_recommended_product_model.dart';
import '../../../utils/global.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../productDetail/product_detail_screen.dart';

class RecommendedProductScreen extends StatefulWidget {
  final List<String> productIdList;

  RecommendedProductScreen({Key? key, required this.productIdList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RecommendedProductScreenState();
  }
}

class RecommendedProductScreenState extends State<RecommendedProductScreen> {
  final recommendedProductController = Get.put(RecommendedProductController());
  var language;

  @override
  void initState() {
    recommendedProductController.productIdList = widget.productIdList;
    recommendedProductController.getData(Get.locale!.languageCode);
    super.initState();
  }

  Future<bool> _onWillPop(
      RecommendedProductController recommendedProductController) async {
    recommendedProductController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<RecommendedProductController>(
        init: RecommendedProductController(),
        builder: (contet) {
          recommendedProductController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(recommendedProductController),
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 90),
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 20),
                        child: topView(recommendedProductController)),
                    recommendedProductController.loading
                        ? Expanded(child: Center(child: CircularProgressBar()))
                        : Expanded(
                            child: RefreshIndicator(
                                onRefresh: () => recommendedProductController
                                    .onRefresh(language),
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    padding: EdgeInsets.all(1.5),
                                    child: NotificationListener<
                                            ScrollNotification>(
                                        onNotification:
                                            (ScrollNotification scrollInfo) {
                                          if (scrollInfo
                                                  is ScrollEndNotification &&
                                              scrollInfo.metrics.pixels ==
                                                  scrollInfo.metrics
                                                      .maxScrollExtent) {
                                            if (recommendedProductController
                                                    .next !=
                                                0) {
                                              recommendedProductController
                                                  .loadMore(language);
                                            }
                                          }
                                          return false;
                                        },
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemCount:
                                                recommendedProductController
                                                    .recommendedProductData!
                                                    .length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  RecommendedProductContainer2(
                                                      recommendedProductModel:
                                                          recommendedProductController
                                                                  .recommendedProductData![
                                                              index]),
                                                  15.heightBox
                                                ],
                                              );
                                            })))))
                  ],
                ),
              ));
        });
  }

  Widget topView(RecommendedProductController addressController) {
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
                        addressController.exitScreen();
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
                LocaleKeys.recommendProducts.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}

class RecommendedProductContainer2 extends StatelessWidget {
  RecommendedProductContainer2(
      {Key? key, required this.recommendedProductModel})
      : super(key: key);
  final RecommendationProducts recommendedProductModel;
  var language;
  final recommendedProductController = Get.put(RecommendedProductController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<RecommendedProductController>(
        init: RecommendedProductController(),
        builder: (contet) {
          recommendedProductController.context = context;
          return InkWell(
              onTap: () {
                recommendedProductController.navigateTo(ProductDetailScreen(
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
                                    recommendedProductController.navigateTo(
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
