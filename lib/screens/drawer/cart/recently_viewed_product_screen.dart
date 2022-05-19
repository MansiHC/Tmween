import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/dashboard_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/recently_viewed_product_controller.dart';
import '../../../utils/global.dart';
import '../../../utils/my_shared_preferences.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../productDetail/product_detail_screen.dart';

class RecentlyViewedProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecentlyViewedProductScreenState();
  }
}

class RecentlyViewedProductScreenState
    extends State<RecentlyViewedProductScreen> {
  final recentlyViewedProductController =
      Get.put(RecentlyViewedProductController());
  var language;

  @override
  void initState() {
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      recentlyViewedProductController.isLogin = value!;

      if (recentlyViewedProductController.isLogin)
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.token)
            .then((value) async {
          recentlyViewedProductController.token = value!;
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.userId)
              .then((value) async {
            recentlyViewedProductController.userId = value!;
            recentlyViewedProductController.getData(Get.locale!.languageCode);
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              recentlyViewedProductController.loginLogId = value!;
            });
          });
        });
    });
    super.initState();
  }

  Future<bool> _onWillPop(
      RecentlyViewedProductController recentlyViewedProductController) async {
    recentlyViewedProductController.exitScreen();
    return true;
  }

  Widget topView(RecentlyViewedProductController addressController) {
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
                LocaleKeys.recentlyViewedProducts.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<RecentlyViewedProductController>(
        init: RecentlyViewedProductController(),
        builder: (contet) {
          recentlyViewedProductController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(recentlyViewedProductController),
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 90),
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 20),
                        child: topView(recentlyViewedProductController)),
                    recentlyViewedProductController.loading
                        ? Expanded(child: Center(child: CircularProgressBar()))
                        : Expanded(
                            child: RefreshIndicator(
                                onRefresh: () => recentlyViewedProductController
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
                                                scrollInfo
                                                    .metrics.maxScrollExtent) {
                                          if (recentlyViewedProductController
                                                  .next !=
                                              0) {
                                            recentlyViewedProductController
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
                                              recentlyViewedProductController
                                                  .recentlyViewProduct!.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                RecentViewedProductContainer(
                                                    cartRecentViewedProductModel:
                                                        recentlyViewedProductController
                                                                .recentlyViewProduct![
                                                            index]),
                                                15.heightBox
                                              ],
                                            );
                                          }),
                                    ))))
                  ],
                ),
              ));
        });
  }
}

class RecentViewedProductContainer extends StatelessWidget {
  RecentViewedProductContainer(
      {Key? key, required this.cartRecentViewedProductModel})
      : super(key: key);
  final RecentlyViewProduct cartRecentViewedProductModel;
  var language;
  final recentlyViewedProductController =
      Get.put(RecentlyViewedProductController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<RecentlyViewedProductController>(
        init: RecentlyViewedProductController(),
        builder: (contet) {
          recentlyViewedProductController.context = context;
          return InkWell(
              onTap: () {
                recentlyViewedProductController.navigateTo(ProductDetailScreen(
                    productId: cartRecentViewedProductModel.id,
                    productslug: cartRecentViewedProductModel.productSlug!));
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cartRecentViewedProductModel.reviewsAvg == 0
                                  ? Container(
                                      width: 10,
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: AppColors.offerGreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(
                                              cartRecentViewedProductModel
                                                  .reviewsAvg
                                                  .toString(),
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
                              5.heightBox,
                              cartRecentViewedProductModel
                                      .largeImageUrl!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: cartRecentViewedProductModel
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
                                      ))
                            ],
                          ),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              5.heightBox,
                              Text(cartRecentViewedProductModel.productName!,
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
                                      '${cartRecentViewedProductModel.finalPriceDisp}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFFF57051),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  10.widthBox,
                                  Text(
                                      ' ${cartRecentViewedProductModel.retailPriceDisp}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF818181),
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12)),
                                ],
                              ),
                              if (cartRecentViewedProductModel.discountPer! > 0)
                                5.heightBox,
                              if (cartRecentViewedProductModel.discountPer! > 0)
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text:
                                            'You save ${cartRecentViewedProductModel.discountPerDisp}! ',
                                        style: TextStyle(
                                            color: Color(0xFF3B963C),
                                            fontSize: 12),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                '${cartRecentViewedProductModel.discountPer}% ${LocaleKeys.off.tr}!',
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
                                    recentlyViewedProductController.navigateTo(
                                        ProductDetailScreen(
                                            productId:
                                                cartRecentViewedProductModel.id,
                                            productslug:
                                                cartRecentViewedProductModel
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
                          10.widthBox,
                          InkWell(
                              onTap: () {
                                print(
                                    '......${cartRecentViewedProductModel.id}');
                                if (recentlyViewedProductController
                                    .wishListedProduct
                                    .contains(
                                        cartRecentViewedProductModel.id)) {
                                  recentlyViewedProductController
                                      .removeWishlistProduct(
                                          cartRecentViewedProductModel.id,
                                          language);
                                } else {
                                  recentlyViewedProductController.addToWishlist(
                                      cartRecentViewedProductModel.id,
                                      language);
                                }
                              },
                              child: SvgPicture.asset(
                                recentlyViewedProductController
                                        .wishListedProduct
                                        .contains(
                                            cartRecentViewedProductModel.id)
                                    ? ImageConstanst.likeFill
                                    : ImageConstanst.like,
                                color: recentlyViewedProductController
                                        .wishListedProduct
                                        .contains(
                                            cartRecentViewedProductModel.id)
                                    ? Colors.red
                                    : Color(0xFF969696),
                                height: 20,
                                width: 20,
                              )),
                        ])),
              ));
        });
  }
}
