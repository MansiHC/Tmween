import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:tmween/screens/drawer/dashboard/all_reviews_screen.dart';
import 'package:tmween/screens/drawer/dashboard/full_image_screen.dart';
import 'package:tmween/screens/drawer/dashboard/review_product_screen.dart';
import 'package:tmween/screens/drawer/dashboard/similar_products_container.dart';
import 'package:tmween/screens/drawer/search_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/full_image_controller.dart';
import '../../../controller/product_detail_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../model/get_customer_address_list_model.dart';
import '../../../utils/my_shared_preferences.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/expandable_text.dart';
import '../../authentication/login/login_screen.dart';
import '../address_container.dart';
import '../cart_screen.dart';
import '../profile/your_addresses_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? productId;
  final String? productslug;

  ProductDetailScreen(
      {Key? key, required this.productId, required this.productslug})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailScreenState();
  }
}

class ProductDetailScreenState extends State<ProductDetailScreen> {
  late String language;
  final productDetailController = Get.put(ProductDetailController());

  @override
  void initState() {
    productDetailController.productId = widget.productId!;
    productDetailController.productSlug = widget.productslug!;
    print('hhhh....${widget.productslug}');
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      productDetailController.isLogin = value!;
      productDetailController.getProductDetails(Get.locale!.languageCode);
    });

    super.initState();
  }

  Future<bool> _onWillPop(
      ProductDetailController productDetailController) async {
    productDetailController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(),
        builder: (contet) {
          productDetailController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(productDetailController),
              child: Scaffold(
                  body: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  minWidth: double.infinity, maxHeight: 90),
                              color: AppColors.appBarColor,
                              padding: EdgeInsets.only(top: 20),
                              child: topView(productDetailController)),
                          InkWell(
                              onTap: () {
                                if (productDetailController.isLogin) {
                                  productDetailController
                                      .getAddressList(language);
                                }
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _bottomSheetView(
                                          productDetailController);
                                    });
                              },
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageConstanst.locationPinIcon,
                                        color: Color(0xFF454545),
                                        height: 16,
                                        width: 16,
                                      ),
                                      3.widthBox,
                                      Text(
                                        productDetailController.isLogin
                                            ? productDetailController
                                                    .address.isNotEmpty
                                                ? productDetailController
                                                    .address
                                                : 'Select Delivery Address'
                                            : 'Select Delivery Address',
                                        style: TextStyle(
                                            color: Color(0xFF454545),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_sharp,
                                        size: 16,
                                      ),
                                      5.widthBox
                                    ],
                                  ))),
                          productDetailController.detailLoading
                              ? Expanded(
                                  child: Center(child: CircularProgressBar()))
                              : !productDetailController.detailLoading &&
                                      productDetailController
                                              .productDetailData !=
                                          null
                                  ? _bottomView(productDetailController)
                                  : Center(
                                      child: Icon(Icons.error),
                                    ),
                        ],
                      ))));
        });
  }

  void _loginFirstDialog(
      ProductDetailController productDetailController) async {
    await showDialog(
        context: productDetailController.context,
        builder: (_) => AlertDialog(
              title: Text(
                'Please Login First',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.no.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    productDetailController.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    Get.deleteAll();
                    productDetailController.navigateTo(
                        LoginScreen(from: SharedPreferencesKeys.isDrawer));
                  },
                ),
              ],
            ));
  }

  Widget _imagePriceView(ProductDetailController productDetailController) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 5)
              ]),
              padding: EdgeInsets.all(10),
              width: double.maxFinite,
              child: Stack(
                children: [
                  if (productDetailController.topLeftInfo != null)
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          color: HexColor.fromHex(
                              productDetailController.topLeftInfo!.color!),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            productDetailController.topLeftInfo!.caption!,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            //     color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Wrap(children: [
                            if (productDetailController.topRightInfo != null)
                              Container(
                                color: HexColor.fromHex(productDetailController
                                    .topRightInfo!.color!),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  productDetailController
                                      .topRightInfo!.caption!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            3.widthBox,
                            InkWell(
                                onTap: () {
                                  MySharedPreferences.instance
                                      .getBoolValuesSF(
                                          SharedPreferencesKeys.isLogin)
                                      .then((value) async {
                                    var isLogin = value!;
                                    if (!isLogin) {
                                      _loginFirstDialog(
                                          productDetailController);
                                    } else if (!productDetailController
                                        .isLiked) {
                                      productDetailController
                                          .addToWishlist(language);
                                    } else {
                                      productDetailController
                                          .removeWishlistProduct(language);
                                    }
                                  });
                                },
                                child: SvgPicture.asset(
                                  productDetailController.isLiked
                                      ? ImageConstanst.likeFill
                                      : ImageConstanst.like,
                                  color: productDetailController.isLiked
                                      ? Colors.red
                                      : Color(0xFF666666),
                                  height: 20,
                                  width: 20,
                                )),
                          ]))),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                      ),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(children: [
                            Stack(
                              children: [
                                Container(
                                    height: 200,
                                    width: double.maxFinite,
                                    child: InkWell(
                                        onTap: () {
                                          Get.delete<FullImageController>();
                                          productDetailController.navigateTo(
                                              FullImageScreen(
                                                  image: productDetailController
                                                      .productDetailData!
                                                      .productData![0]
                                                      .productGallery!,
                                                  current:
                                                      productDetailController
                                                          .current));
                                        },
                                        child: CarouselSlider(
                                          items: productDetailController
                                              .productDetailData!
                                              .productData![0]
                                              .productGallery!
                                              .map((item) => Container(
                                                    child: item.largeImageUrl!
                                                        .setNetworkImage(),
                                                  ))
                                              .toList(),
                                          carouselController:
                                              productDetailController
                                                  .controller,
                                          options: CarouselOptions(
                                            autoPlay: false,
                                            enlargeCenterPage: false,
                                            enableInfiniteScroll: false,
                                            viewportFraction: 1,
                                            aspectRatio: 1.6,
                                            pageSnapping: true,
                                            onPageChanged: (index, reason) {
                                              productDetailController
                                                  .changPage(index);
                                            },
                                          ),
                                        ))),
                                if (productDetailController
                                        .productDetailData!
                                        .productData![0]
                                        .productGallery!
                                        .length >
                                    1)
                                  Positioned(
                                      bottom: 0.0,
                                      left: 0.0,
                                      right: 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: productDetailController
                                            .productDetailData!
                                            .productData![0]
                                            .productGallery!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return GestureDetector(
                                            onTap: () => productDetailController
                                                .controller
                                                .animateToPage(entry.key),
                                            child: Container(
                                              width: 8.0,
                                              height: 2,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: productDetailController
                                                              .current ==
                                                          entry.key
                                                      ? AppColors.darkblue
                                                      : Colors.grey),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                              ],
                            ),
                            5.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (productDetailController.bottomLeftInfo !=
                                    null)
                                  Container(
                                    color: HexColor.fromHex(
                                        productDetailController
                                            .bottomLeftInfo!.color!),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      productDetailController
                                          .bottomLeftInfo!.caption!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                if (productDetailController.bottomRightInfo !=
                                    null)
                                  Container(
                                    color: HexColor.fromHex(
                                        productDetailController
                                            .bottomRightInfo!.color!),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      productDetailController
                                          .bottomRightInfo!.caption!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                              ],
                            )
                          ]))),
                ],
              )),
          5.heightBox,
          Container(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productDetailController.productDetailData!
                      .productData![0].productGallery!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          productDetailController.controller
                              .animateToPage(index);
                          productDetailController.changPage(index);
                        },
                        child: Container(
                            width: 80,
                            decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200]!,
                                      blurRadius: 5,
                                      spreadRadius: 5)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                border: Border.all(
                                    color:
                                        productDetailController.current == index
                                            ? Color(0xFF1992CE)
                                            : Colors.white)),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(right: 5),
                            child: productDetailController
                                .productDetailData!
                                .productData![0]
                                .productGallery![index]
                                .largeImageUrl!
                                .setNetworkImage()));
                  })),
          10.heightBox,
          Text(
            productDetailController
                .productDetailData!.productData![0].productName!,
            style: TextStyle(
                color: Color(0xFF2E3846),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          5.heightBox,
          if (productDetailController
                  .productDetailData!.productData![0].brandName !=
              null)
            Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: 'by ',
                        style:
                            TextStyle(color: Color(0xFF48505C), fontSize: 16),
                        children: <InlineSpan>[
                          TextSpan(
                            text: productDetailController
                                .productDetailData!.productData![0].brandName!,
                            style: TextStyle(
                                color: Color(0xFF1992CE),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ]))),
          8.heightBox,
          productDetailController
                      .productDetailData!.productData![0].reviewsAvg ==
                  0
              ? Text('No Reviews Yet',
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 13,
                  ))
              : Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.offerGreen,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                                productDetailController.productDetailData!
                                    .productData![0].reviewsAvg!
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            5.widthBox,
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            )
                          ],
                        )),
                    10.widthBox,
                    Text(
                        '(${productDetailController.productDetailData!.customerProductReview!.data!.length} Reviews)',
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 13,
                        )),
                  ],
                ),
          15.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFE9E9E9),
          ),
          15.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Price: ',
                      style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'SAR ',
                          style: TextStyle(
                              color: Color(0xFFF4500F),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: productDetailController
                              .productDetailData!.productData![0].finalPrice
                              .toString(),
                          style: TextStyle(
                              color: Color(0xFFF4500F),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ]))),
          5.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'M.R.P: ',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2,
                          color: Color(0xFF727272),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'SAR ',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              color: Color(0xFF727272),
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: productDetailController
                              .productDetailData!.productData![0].retailPrice
                              .toString(),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              color: Color(0xFF727272),
                              fontSize: 14),
                        ),
                      ]))),
          5.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'You Save: ',
                      style: TextStyle(
                          color: Color(0xFF636363),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text:
                              'SAR ${productDetailController.productDetailData!.productData![0].discountValue.toString()} (${productDetailController.productDetailData!.productData![0].discountValuePercentage.toString()}%)',
                          style:
                              TextStyle(color: Color(0xFFF4500F), fontSize: 14),
                        ),
                      ]))),
          5.heightBox,
          if (productDetailController
                  .productDetailData!.productData![0].fullfilledByTmween ==
              1)
            Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(
                        text: productDetailController.productDetailData!
                                    .productData![0].fullfilledByTmween ==
                                1
                            ? '${LocaleKeys.fulfilledBy.tr} '
                            : '',
                        style:
                            TextStyle(color: Color(0xFF1992CE), fontSize: 14),
                        children: <InlineSpan>[
                      TextSpan(
                        text: productDetailController.productDetailData!
                                    .productData![0].fullfilledByTmween ==
                                1
                            ? '${LocaleKeys.appTitle.tr} '
                            : '',
                        style: TextStyle(
                            color: Color(0xFF1992CE),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      /*  TextSpan(
                      text: 'FREE Delivery.',
                      style: TextStyle(
                          color: Color(0xFF414141),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Details',
                      style: TextStyle(color: Color(0xFF1992CE), fontSize: 14),
                    ),*/
                    ]))),
          15.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFE9E9E9),
          ),
          10.heightBox,
          /* Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Eligible for ',
                      style: TextStyle(color: Color(0xFF636363), fontSize: 14),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'FREE Shipping ',
                          style: TextStyle(
                              color: Color(0xFF414141),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'on order over SAR 200.00 ',
                          style:
                              TextStyle(color: Color(0xFF636363), fontSize: 14),
                        ),
                        TextSpan(
                          text: 'Details',
                          style:
                              TextStyle(color: Color(0xFF1992CE), fontSize: 14),
                        ),
                      ]))),
          10.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFE9E9E9),
          ),*/
         // 10.heightBox,
          if( productDetailController
              .productDetailData!.productAssociateAttribute!.length>0)
          Wrap(
              spacing: 10,
              children: List.generate(
                productDetailController
                    .productDetailData!.productAssociateAttribute!.length,
                (index) => Column(
                  children: [
                    if (productDetailController.productDetailData!
                            .productAssociateAttribute![index].options !=
                        null)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text:
                                      '${productDetailController.productDetailData!.productAssociateAttribute![index].attributeName} : ',
                                  style: TextStyle(
                                      color: Color(0xFF636363),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    if (productDetailController
                                            .productDetailData!
                                            .productAssociateAttribute![index]
                                            .options !=
                                        null)
                                      TextSpan(
                                        text: productDetailController
                                                .getAttributeSelectedValue(
                                                    index)
                                                .isNotEmpty
                                            ? productDetailController
                                                .getAttributeSelectedValue(
                                                    index)
                                            : productDetailController
                                                .productDetailData!
                                                .productAssociateAttribute![
                                                    index]
                                                .options![0]
                                                .attributeOptionValue,
                                        style: TextStyle(
                                            color: Color(0xFF1992CE),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                  ]))),
                    5.heightBox,
                    if (productDetailController.productDetailData!
                                .productAssociateAttribute![index].options !=
                            null &&
                        productDetailController
                                .productDetailData!
                                .productAssociateAttribute![index]
                                .attributeName!
                                .toLowerCase() !=
                            'color')
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: List.generate(
                                  productDetailController
                                      .productDetailData!
                                      .productAssociateAttribute![index]
                                      .options!
                                      .length,
                                  (index2) => productDetailController
                                              .productDetailData!
                                              .productAssociateAttribute![index]
                                              .options![index2]
                                              .attributeOptionValue !=
                                          null
                                      ? InkWell(
                                          onTap: () {
                                            productDetailController
                                                .changeItemSelection(
                                                    index, index2, language);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: productDetailController
                                                                      .attributeItems[index]
                                                                      .getPrimaryIndex ==
                                                                  index &&
                                                              productDetailController.attributeItems[index].getSecondaryIndex == index2
                                                          ? Color(0xFF1992CE)
                                                          : Colors.black),
                                                  borderRadius: BorderRadius.circular(4)),
                                              child: Text(
                                                productDetailController
                                                    .productDetailData!
                                                    .productAssociateAttribute![
                                                        index]
                                                    .options![index2]
                                                    .attributeOptionValue!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                      : Container()))),
                    if (productDetailController.productDetailData!
                                .productAssociateAttribute![index].options !=
                            null &&
                        productDetailController
                                .productDetailData!
                                .productAssociateAttribute![index]
                                .attributeName!
                                .toLowerCase() ==
                            'color')
                      Container(
                          height: 24,
                          child: ListView.builder(
                              itemCount: productDetailController
                                  .productDetailData!
                                  .productAssociateAttribute![index]
                                  .options!
                                  .length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index2) {
                                if (productDetailController
                                        .productDetailData!
                                        .productAssociateAttribute![index]
                                        .options![index2]
                                        .attributeOptionValue !=
                                    null)
                                  return InkWell(
                                      onTap: () {
                                        productDetailController
                                            .changeItemSelection(
                                                index, index2, language);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 26,
                                        decoration: BoxDecoration(
                                            color: productDetailController
                                                .productDetailData!
                                                .productAssociateAttribute![
                                                    index]
                                                .options![index2]
                                                .attributeOptionValue!
                                                .toLowerCase()
                                                .color(),
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: productDetailController
                                                        .attributeItems[index]
                                                        .getPrimaryIndex ==
                                                    index &&
                                                productDetailController
                                                        .attributeItems[index]
                                                        .getSecondaryIndex ==
                                                    index2
                                            ? Icon(
                                                Icons.check,
                                                size: 16,
                                                color: productDetailController
                                                        .productDetailData!
                                                        .productAssociateAttribute![
                                                            index]
                                                        .options![index2]
                                                        .attributeOptionValue!
                                                        .toLowerCase()
                                                        .contains('white')
                                                    ? Colors.black
                                                    : Colors.white,
                                              )
                                            : Container(),
                                      ));
                                return Container();
                              })),
                    10.heightBox,
                  ],
                ),
              )),
          if (productDetailController
                  .attributeData!.productMainSupplier!.length !=
              0)
            Container(
                height: 35,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          if (productDetailController.quntity != 1) {
                            productDetailController.quntity--;
                            productDetailController.update();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 2,
                                    spreadRadius: 2)
                              ]),
                          height: 35,
                          width: 30,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Color(0xFF48525E),
                          ),
                        )),
                    2.widthBox,
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      padding: EdgeInsets.all(10),
                      child: Text(productDetailController.quntity.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF656565),
                          )),
                    ),
                    2.widthBox,
                    InkWell(
                        onTap: () {
                          productDetailController.quntity++;
                          productDetailController.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 2,
                                    spreadRadius: 2)
                              ]),
                          height: 35,
                          width: 30,
                          child: Center(
                              child: Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: Color(0xFF48525E),
                          )),
                        )),
                    5.widthBox,
                    Expanded(
                        child: Text(
                      '*Minimum order Quantity 1 Piece.',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ))
                  ],
                )),
        ]);
  }

  Widget _bottomView(ProductDetailController productDetailController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                color: Color(0xFFF3F3F3),
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _imagePriceView(productDetailController)),
                    15.heightBox,
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: CustomButton(
                              text: 'BUY NOW', fontSize: 14, onPressed: () {})),
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: CustomButton(
                              text: 'ADD TO CART',
                              fontSize: 14,
                              backgroundColor: Color(0xFF314156),
                              onPressed: () {
                                productDetailController.addToCart(productDetailController
                                    .attributeData!.productMainSupplier![0].productItemId, productDetailController
                                    .attributeData!.productMainSupplier![0].supplierId, productDetailController
                                    .attributeData!.productQtyPackData![0].supplierBranchId, language).then((value) {
                                  {
                                    if (value)
                                      _showDialog(productDetailController);
                                  }
                                });

                                // productDetailController.navigateToCartScreen();
                              })),
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      10.heightBox,
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: _quantityDiscount(productDetailController)),
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _guaranteeSection(productDetailController)),
                    15.heightBox,
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: _sellerSection(productDetailController)),
                    if (productDetailController
                            .attributeData!.productMainSupplier!.length !=
                        0)
                      15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _productInformation(productDetailController)),
                    0.1.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _specification(productDetailController)),
                    0.1.heightBox,
                    /* Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _sizeSpecification(productDetailController)),
                    0.1.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _deliveryReturns(productDetailController)),*/
                    15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _ratingReviewSection(productDetailController)),
                    15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'Similar Products',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000)),
                        )),
                    5.heightBox,
                    _similarProducts(productDetailController),
                    20.heightBox,
                  ],
                ))));
  }

  Widget _similarProducts(ProductDetailController productDetailController) {
    return Container(
        height: 244,
        child: ListView.builder(
            itemCount: productDetailController
                .productDetailData!.similarProduct!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SimilarProductsContainer(
                  products: productDetailController
                      .productDetailData!.similarProduct![index]);
            }));
  }

  Widget _ratingReviewSection(ProductDetailController productDetailController) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 5)
      ]),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ratings & Reviews',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),
              ),
              InkWell(
                  onTap: () {
                    if (!productDetailController.isLogin) {
                      _loginFirstDialog(productDetailController);
                    } else {
                      //     productDetailController.navigateTo(ReviewProductScreen(product:productDetailController.productDetailData!.productData![0]));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewProductScreen(
                                  product: productDetailController
                                      .productDetailData!
                                      .productData![0]))).then((value) {
                        if (value) {
                          productDetailController.getProductDetails(language);
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                        child: Text(
                      'Rate Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    )),
                  ))
            ],
          ),
          5.heightBox,
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: productDetailController.productDetailData!
                          .customerProductReview!.data!.length ==
                      0
                  ? Text('Be the First to write a review',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                      ))
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: /*productDetailController.productDetailData!
                                  .customerProductReview!.data!.length >
                              2
                          ? 2
                          :*/
                          productDetailController.productDetailData!
                                  .customerProductReview!.data!.length +
                              1,
                      itemBuilder: (context, index) {
                        return (index !=
                                productDetailController.productDetailData!
                                    .customerProductReview!.data!.length)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          productDetailController
                                                  .productDetailData!
                                                  .customerProductReview!
                                                  .data![index]
                                                  .largeImageUrl!
                                                  .isEmpty
                                              ? SvgPicture.asset(
                                                  ImageConstanst.user,
                                                  height: 35,
                                                  width: 35,
                                                )
                                              : CircleAvatar(
                                                  radius: 24,
                                                  foregroundColor:
                                                      Colors.transparent,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        productDetailController
                                                            .productDetailData!
                                                            .customerProductReview!
                                                            .data![index]
                                                            .largeImageUrl!,
                                                    placeholder: (context,
                                                            url) =>
                                                        CupertinoActivityIndicator(),
                                                    imageBuilder:
                                                        (context, image) =>
                                                            CircleAvatar(
                                                      backgroundImage: image,
                                                      radius: 45,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            SvgPicture.asset(
                                                      ImageConstanst.user,
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                  ),
                                                ),
                                          5.heightBox,
                                          if (productDetailController
                                                  .productDetailData!
                                                  .customerProductReview!
                                                  .data![index]
                                                  .rating !=
                                              0)
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3, vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: Colors.lightGreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Text(
                                                        productDetailController
                                                            .productDetailData!
                                                            .customerProductReview!
                                                            .data![index]
                                                            .rating!
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    2.widthBox,
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 12,
                                                    )
                                                  ],
                                                )),
                                        ],
                                      ),
                                      10.widthBox,
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                      text: productDetailController
                                                          .productDetailData!
                                                          .customerProductReview!
                                                          .data![index]
                                                          .fullname,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xFF000000)),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                            text:
                                                                ' - ${productDetailController.productDetailData!.customerProductReview!.data![index].createdAt!.split(' ')[0]}',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF888888),
                                                              fontSize: 12,
                                                            )),
                                                      ]))),
                                          5.heightBox,
                                          if (productDetailController
                                                  .productDetailData!
                                                  .customerProductReview!
                                                  .data![index]
                                                  .review!
                                                  .length <
                                              140)
                                            Text(
                                                productDetailController
                                                    .productDetailData!
                                                    .customerProductReview!
                                                    .data![index]
                                                    .review!,
                                                style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 12,
                                                )),
                                          if (productDetailController
                                                  .productDetailData!
                                                  .customerProductReview!
                                                  .data![index]
                                                  .review!
                                                  .length >
                                              140)
                                            ExpandableText(
                                              productDetailController
                                                  .productDetailData!
                                                  .customerProductReview!
                                                  .data![index]
                                                  .review!,
                                              trimLines: 4,
                                            ),
                                          5.heightBox,
                                          Row(
                                            children: [
                                              Text('Helpful',
                                                  style: TextStyle(
                                                    color: Color(0xFF333333),
                                                    fontSize: 12,
                                                  )),
                                              5.widthBox,
                                              Container(
                                                width: 1,
                                                height: 12,
                                                color: Color(0xFF333333),
                                              ),
                                              5.widthBox,
                                              Text('Report abuse',
                                                  style: TextStyle(
                                                    color: Color(0xFF333333),
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                          10.heightBox
                                        ],
                                      ))
                                    ],
                                  ),
                                  if (productDetailController.productDetailData!
                                          .customerProductReview!.data!.length >
                                      2)
                                    Divider(
                                      thickness: 1,
                                      height: 5,
                                      color: Color(0xFFF7F7F7),
                                    ),
                                ],
                              )
                            : /*productDetailController.productDetailData!
                                        .customerProductReview!.data!.length >
                                    2
                                ? */
                            InkWell(
                                onTap: () {
                                  productDetailController.navigateTo(
                                      AllReviewScreen(
                                          productId: productDetailController
                                              .productId));
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'All ${productDetailController.productDetailData!.customerProductReview!.data!.length} Reviews',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Icon(Icons.keyboard_arrow_right,
                                            color: Colors.black)
                                      ],
                                    )));
                        // : Container();
                      }))
        ],
      ),
    );
  }

  Widget _sellerSection(ProductDetailController productDetailController) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 5)
      ]),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(productDetailController.attributeData!.productDeliveryData!=null)
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: 'Ship to ',
                  style: TextStyle(
                    color: Color(0xFF484848),
                    fontSize: 14,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          '${productDetailController.attributeData!.productDeliveryData!.deliveryAgencyName} ',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '(Change city)',
                      style: TextStyle(
                        color: Color(0xFF1992CE),
                        fontSize: 14,
                      ),
                    ),
                  ])),
          if(productDetailController.attributeData!.productDeliveryData!=null)
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: 'Delivered by ',
                  style: TextStyle(
                    color: Color(0xFF484848),
                    fontSize: 14,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          '${productDetailController.attributeData!.productDeliveryData!.deliveryDurationLabel!} to ${productDetailController.attributeData!.productDeliveryData!.deliveryAgencyName}',
                      style: TextStyle(
                          color: Color(0xFF1992CE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
          if(productDetailController.attributeData!.productDeliveryData==null)
          Text('delivery is not available at your location', style: TextStyle(
              color: Color(0xFF1992CE),
              fontSize: 14,
              fontWeight: FontWeight.bold)),
          8.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFF7F7F7),
          ),
          8.heightBox,
          /* Row(
            children: [
              Expanded(
                  child: Text('Condition: ',
                      style: TextStyle(
                          color: Color(0xFF535353),
                          fontSize: 14,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text('New',
                      style: TextStyle(
                        color: Color(0xFF1992CE),
                        fontSize: 14,
                      ))),
            ],
          ),
          5.heightBox,*/
          Row(
            children: [
              Expanded(
                  child: Text('Sold by: ',
                      style: TextStyle(
                          color: Color(0xFF535353),
                          fontSize: 14,
                          fontWeight: FontWeight.bold))),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      productDetailController
                          .attributeData!.productMainSupplier![0].supplierName!,
                      style: TextStyle(
                          color: Color(0xFF1992CE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  /*3.heightBox,
                  Text('(96% Positive Rating)',
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 12,
                      ))*/
                ],
              )),
            ],
          ),
          8.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFF7F7F7),
          ),
          8.heightBox,
          Text(
              'Only ${productDetailController.productDetailData!.productData![0].inStock} left in stock!',
              style: TextStyle(
                  color: Color(0xFFF77443),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          if (productDetailController
                  .productDetailData!.productData![0].productSupplier!.length >
              1)
            3.heightBox,
          if (productDetailController
                  .productDetailData!.productData![0].productSupplier!.length >
              1)
            RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    text:
                        '${productDetailController.productDetailData!.productData![0].productSupplier!.length - 1} offers ',
                    style: TextStyle(
                      color: Color(0xFF1992CE),
                      fontSize: 14,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'from ',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            '${productDetailController.productDetailData!.productData![0].finalPriceDisp}',
                        style: TextStyle(
                          color: Color(0xFFF77443),
                          fontSize: 14,
                        ),
                      ),
                    ])),
          20.heightBox,
          Container(
            color: Color(0xFF314156),
            padding: EdgeInsets.all(15),
            width: double.maxFinite,
            child: Text(
              'Other Seller on Tmween',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0xFFEEEEEE))),
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: productDetailController
                      .attributeData!.productOtherSupplier!.length /*+ 1*/,
                  itemBuilder: (context, index) {
                    return /*(index !=
                        productDetailController.attributeData!.productOtherSupplier!.length)
                        ? */
                        Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (index != 0) 5.heightBox,
                                Text(
                                    '${productDetailController.attributeData!.productOtherSupplier![index].priceDisp}',
                                    style: TextStyle(
                                        color: Color(0xFFF77443),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                3.heightBox,
                                Text('+ ${'0.00'} Delivery charge',
                                    style: TextStyle(
                                      color: Color(0xFF7D838B),
                                      fontSize: 13,
                                    )),
                                3.heightBox,
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: 'Sold by: ',
                                        style: TextStyle(
                                          color: Color(0xFF7D838B),
                                          fontSize: 13,
                                        ),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: productDetailController
                                                .attributeData!
                                                .productOtherSupplier![index]
                                                .supplierName,
                                            style: TextStyle(
                                                color: Color(0xFF4D5560),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ])),
                                5.heightBox,
                              ],
                            ),
                            CustomButton(
                                horizontalPadding: 0,
                                width: 105,
                                fontSize: 14,
                                text: 'ADD TO CART',
                                onPressed: () {})
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          height: 5,
                          color: Color(0xFFF7F7F7),
                        ),
                      ],
                    )
                        /*: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: '(4) more offers  ',
                                    style: TextStyle(
                                        color: Color(0xFF1992CE),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: 'starting from  ',
                                        style: TextStyle(
                                            color: Color(0xFF232F3E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: 'SAR 24,999.00',
                                        style: TextStyle(
                                          color: Color(0xFFF77443),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ])))*/
                        ;
                  }))
        ],
      ),
    );
  }

  Widget _guaranteeSection(ProductDetailController productDetailController) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(0xFF314156), boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 5)
            ]),
            width: double.maxFinite,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                10.widthBox,
                SvgPicture.asset(
                  ImageConstanst.logo,
                  height: 30,
                  width: 30,
                ),
                10.heightBox,
                Expanded(
                    child: Text(
                  'Guarantee 100% Purchase Protection',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ))
              ],
            )),
        Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: /*Table(
                columnWidths: {
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(0.1),
                  2: FlexColumnWidth(5),
                  3: FlexColumnWidth(0.1),
                  4: FlexColumnWidth(4),
                  5: FlexColumnWidth(0.1),
                  6: FlexColumnWidth(5),
                },
                children: [
                  TableRow(children: [
                    SvgPicture.asset(
                      ImageConstanst.sudanFlagIcon,
                      height: 35,
                      width: 35,
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 35, width: 1,),
                    SvgPicture.asset(
                      ImageConstanst.sudanFlagIcon,
                      height: 35,
                      width: 35,
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 35, width: 1,),
                    SvgPicture.asset(
                      ImageConstanst.sudanFlagIcon,
                      height: 35,
                      width: 35,
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 35, width: 1,),
                    SvgPicture.asset(
                      ImageConstanst.sudanFlagIcon,
                      height: 35,
                      width: 35,
                    ),
                  ]),
                  TableRow(children: [
                    5.heightBox,
                    Container(color: Color(0xFFEEEEEE), height: 5, width: 1,),
                    5.heightBox,
                    Container(color: Color(0xFFEEEEEE), height: 5, width: 1,),
                    5.heightBox,
                    Container(color: Color(0xFFEEEEEE), height: 5, width: 1,),
                    5.heightBox,
                  ]),
                  TableRow(children: [
                    Text(
                      'WARRANTY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 30, width: 1,),
                    Text(
                      '100% ORIGINAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 30, width: 1,),
                    Text(
                      'SECURE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(color: Color(0xFFEEEEEE), height: 30, width: 1,),
                    Text(
                      '100% BUYER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "As per Weswox's",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF5C5C5C), fontSize: 12.5),
                    ), Container(color:Color(0xFFEEEEEE),  height: 30, width: 1,),
                    Text(
                      "Products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF5C5C5C), fontSize: 12.5),
                    ),Container(color:Color(0xFFEEEEEE), height: 30, width: 1,),
                    Text(
                      "PAYMENTS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF5C5C5C), fontSize: 12.5),
                    ),Container(color:Color(0xFFEEEEEE), height: 30, width: 1,),
                    Text(
                      "PROTECTION",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF5C5C5C), fontSize: 12.5),
                    ),
                  ])
                ])*/
                Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstanst.warranty,
                          height: 35,
                          width: 35,
                        ),
                        5.heightBox,
                        SizedBox(
                            height: 34,
                            child: Text(
                              'WARRANTY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "As per Weswox's",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF5C5C5C), fontSize: 12),
                        ),
                      ],
                    )),
                Container(
                  color: Color(0xFFEEEEEE),
                  height: 70,
                  width: 1,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstanst.original,
                          height: 35,
                          width: 35,
                        ),
                        5.heightBox,
                        SizedBox(
                            height: 34,
                            child: Text(
                              '100% ORIGINAL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\nProducts",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF5C5C5C), fontSize: 12),
                        ),
                      ],
                    )),
                Container(
                  color: Color(0xFFEEEEEE),
                  height: 70,
                  width: 1,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstanst.secure,
                          height: 35,
                          width: 35,
                        ),
                        5.heightBox,
                        SizedBox(
                            height: 34,
                            child: Text(
                              'SECURE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\nPAYMENTS",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF5C5C5C), fontSize: 12),
                        ),
                      ],
                    )),
                Container(
                  color: Color(0xFFEEEEEE),
                  height: 70,
                  width: 1,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstanst.protected,
                          height: 35,
                          width: 35,
                        ),
                        5.heightBox,
                        SizedBox(
                            height: 34,
                            child: Text(
                              '100% BUYER',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\nPROTECTION",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF5C5C5C), fontSize: 12),
                        ),
                      ],
                    )),
              ],
            ))
      ],
    );
  }

  Widget _quantityDiscount(ProductDetailController productDetailController) {
    return Theme(
        data: ThemeData(
          dividerColor: Colors.white,
        ),
        child: ExpansionTile(
            trailing: productDetailController.isQuantityDiscountExpanded
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
                : Icon(Icons.keyboard_arrow_down,
                    size: 24, color: Colors.white),
            onExpansionChanged: (isExapanded) {
              productDetailController.updateQuantityDiscountExpanded();
            },
            backgroundColor: Color(0xFF314156),
            collapsedBackgroundColor: Color(0xFF314156),
            initiallyExpanded: true,
            key: PageStorageKey<String>('Bulk quantity Discounts!!'),
            title: Text('Bulk quantity Discounts!!',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 5)
                ]),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(4),
                    2: FlexColumnWidth(4),
                    3: FlexColumnWidth(6),
                  },
                  border: TableBorder.all(color: Color(0xFFF0F0F0)),
                  children: [
                    TableRow(children: [
                      Container(width: 20, height: 40),
                      Container(
                          height: 40,
                          child: Center(
                              child: Text(
                            'Quantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ))),
                      Container(
                          height: 40,
                          child: Center(
                              child: Text(
                            'Discount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ))),
                      Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Price per Piece',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ))
                    ]),
                    for (int i = 0;
                        i <
                            productDetailController
                                .attributeData!.productQtyPackData!.length;
                        i++)
                      TableRow(children: [
                        Container(
                          height: 40,
                          child: Radio(
                            value: 1,
                            groupValue: productDetailController.val,
                            activeColor: Color(0xFF1992CE),
                            onChanged: (int? value) {
                              productDetailController.val = value!;
                              productDetailController.update();
                            },
                          ),
                        ),
                        Container(
                            height: 40,
                            child: Center(
                                child: Text(
                              productDetailController
                                  .attributeData!.productQtyPackData![i].qty!
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A), fontSize: 14),
                            ))),
                        Container(
                            height: 40,
                            child: Center(
                                child: Text(
                              '2.86%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A), fontSize: 14),
                            ))),
                        Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                productDetailController.attributeData!
                                    .productQtyPackData![i].price!
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF3A3A3A), fontSize: 14),
                              ),
                            ))
                      ]),
                  ],
                ),
              ),
            ]));
  }

  Widget _productInformation(ProductDetailController productDetailController) {
    return Theme(
        data: ThemeData(
          dividerColor: Colors.white,
        ),
        child: ExpansionTile(
            trailing: productDetailController.isProductInfoExpanded
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
                : Icon(Icons.keyboard_arrow_down,
                    size: 24, color: Colors.white),
            onExpansionChanged: (isExapanded) {
              productDetailController.updateProductInfoExpanded();
            },
            backgroundColor: Color(0xFF314156),
            collapsedBackgroundColor: Color(0xFF314156),
            initiallyExpanded: true,
            key: PageStorageKey<String>('Product Information'),
            title: Text('Product Information',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 5,
                        spreadRadius: 5)
                  ]),
                  padding: EdgeInsets.all(productDetailController
                              .productDetailData!
                              .productData![0]
                              .shortDescription!
                              .isNotEmpty &&
                          productDetailController.productDetailData!
                              .productData![0].longDescription!.isNotEmpty
                      ? 10
                      : 0),
                  child: (productDetailController.productDetailData!
                              .productData![0].shortDescription!.isNotEmpty &&
                          productDetailController.productDetailData!
                              .productData![0].longDescription!.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descriptions:',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (productDetailController.productDetailData!
                                .productData![0].shortDescription!.isNotEmpty)
                              8.heightBox,
                            if (productDetailController.productDetailData!
                                .productData![0].shortDescription!.isNotEmpty)
                              Text(
                                productDetailController.productDetailData!
                                    .productData![0].shortDescription!,
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 14,
                                ),
                              ),
                            if (productDetailController.productDetailData!
                                .productData![0].shortDescription!.isNotEmpty)
                              8.heightBox,
                            Text(
                              productDetailController.productDetailData!
                                  .productData![0].longDescription!,
                              style: TextStyle(
                                color: Color(0xFF4A4A4A),
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      : Container()),
            ]));
  }

  Widget _specification(ProductDetailController productDetailController) {
    return Theme(
        data: ThemeData(
          dividerColor: Colors.white,
        ),
        child: ExpansionTile(
            trailing: productDetailController.isSpecificationExpanded
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
                : Icon(Icons.keyboard_arrow_down,
                    size: 24, color: Colors.white),
            onExpansionChanged: (isExapanded) {
              productDetailController.updateSpecificationExpanded();
            },
            backgroundColor: Color(0xFF314156),
            collapsedBackgroundColor: Color(0xFF314156),
            initiallyExpanded: false,
            key: PageStorageKey<String>('Specification'),
            title: Text('Specification',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: [
              if (productDetailController
                  .productDetailData!.productData![0].specification!.isNotEmpty)
                Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 5,
                          spreadRadius: 5)
                    ]),
                    padding: EdgeInsets.all(productDetailController
                            .productDetailData!
                            .productData![0]
                            .specification!
                            .isNotEmpty
                        ? 10
                        : 0),
                    child: Text(
                      productDetailController
                          .productDetailData!.productData![0].specification!,
                      style: TextStyle(
                        color: Color(0xFF4A4A4A),
                        fontSize: 14,
                      ),
                    ))
            ]));
  }

  Widget _sizeSpecification(ProductDetailController productDetailController) {
    return Theme(
        data: ThemeData(
          dividerColor: Colors.white,
        ),
        child: ExpansionTile(
            trailing: productDetailController.isSizeSpecificationExpanded
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
                : Icon(Icons.keyboard_arrow_down,
                    size: 24, color: Colors.white),
            onExpansionChanged: (isExapanded) {
              productDetailController.updateSizeSpecificationExpanded();
            },
            backgroundColor: Color(0xFF314156),
            collapsedBackgroundColor: Color(0xFF314156),
            initiallyExpanded: false,
            key: PageStorageKey<String>('Size & Specification'),
            title: Text('Size & Specification',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: []));
  }

  Widget _deliveryReturns(ProductDetailController productDetailController) {
    return Theme(
        data: ThemeData(
          dividerColor: Colors.white,
        ),
        child: ExpansionTile(
            trailing: productDetailController.isDeliveryReturnExpanded
                ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
                : Icon(Icons.keyboard_arrow_down,
                    size: 24, color: Colors.white),
            onExpansionChanged: (isExapanded) {
              productDetailController.updateDeliveryReturnExpanded();
            },
            backgroundColor: Color(0xFF314156),
            collapsedBackgroundColor: Color(0xFF314156),
            initiallyExpanded: false,
            key: PageStorageKey<String>('Delivery & Returns'),
            title: Text('Delivery & Returns',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            children: []));
  }

  Widget topView(ProductDetailController productDetailController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                color: Colors.white, // Button color
                child: InkWell(
                  onTap: () {
                    productDetailController.exitScreen();
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
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    productDetailController.navigateTo(
                        SearchScreen(from: AppConstants.productDetail));
                  },
                ),
                InkWell(
                    onTap: () {
                      Share.share('check out my website https://example.com',
                          subject: 'Look what I made!');
                    },
                    child: SvgPicture.asset(
                      ImageConstanst.share,
                      color: Colors.white,
                      height: 24,
                      width: 24,
                    )),
                10.widthBox,
                InkWell(
                    onTap: () {
                      productDetailController.navigateTo(CartScreen(
                        from: AppConstants.productDetail,
                      ));
                    },
                    child: Badge(
                      badgeContent: Text('2'),
                      badgeColor: Colors.white,
                      animationType: BadgeAnimationType.fade,
                      child: SvgPicture.asset(
                        ImageConstanst.shoppingCartIcon,
                        color: Colors.white,
                        height: 24,
                        width: 24,
                      ),
                    )),
              ],
            ),
          ],
        ));
  }

  _bottomSheetView(ProductDetailController productDetailController) {
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(),
        builder: (contet) {
          return Container(
              height: productDetailController.isLogin ? 310 : 200,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Text(
                    LocaleKeys.chooseLocation.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  10.heightBox,
                  Text(
                    LocaleKeys.chooseLocationText.tr,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                  ),
                  20.heightBox,
                  productDetailController.isLogin
                      ? Column(children: [
                          Visibility(
                            visible: productDetailController.loading,
                            child: CircularProgressBar(),
                          ),
                          Visibility(
                            visible: !productDetailController.loading &&
                                productDetailController.addressList.length == 0,
                            child: InkWell(
                                onTap: () {
                                  productDetailController.pop();
                                  productDetailController
                                      .navigateTo(YourAddressesScreen());
                                },
                                child: Container(
                                    width: 150,
                                    height: 160,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.lightBlue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    child: Center(
                                        child: Text(
                                            LocaleKeys.addAddressText.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.bold))))),
                          ),
                          Visibility(
                              visible: !productDetailController.loading &&
                                  productDetailController.addressList.length >
                                      0,
                              child: Container(
                                  height: 170,
                                  child: ListView.builder(
                                      itemCount: productDetailController
                                              .addressList.length +
                                          1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return (index !=
                                                productDetailController
                                                    .addressList.length)
                                            ? InkWell(
                                                onTap: () {
                                                  Address address =
                                                      productDetailController
                                                          .addressList[index];
                                                  productDetailController
                                                      .editAddress(
                                                          address.id,
                                                          address.fullname,
                                                          address.address1,
                                                          address.address2,
                                                          address.landmark,
                                                          address.countryCode,
                                                          address.stateCode,
                                                          address.cityCode,
                                                          address.zip,
                                                          address.mobile1,
                                                          address.addressType,
                                                          address
                                                              .deliveryInstruction,
                                                          '1',
                                                          language);
                                                },
                                                child: AddressContainer(
                                                    address: productDetailController
                                                        .addressList[index]))
                                            : InkWell(
                                                onTap: () {
                                                  productDetailController.pop();
                                                  productDetailController
                                                      .navigateTo(
                                                          YourAddressesScreen());
                                                },
                                                child: Container(
                                                    width: 150,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .lightBlue),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                                    child: Center(
                                                        child: Text(
                                                            LocaleKeys.addAddressText.tr,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(color: AppColors.primaryColor, fontSize: 15, fontWeight: FontWeight.bold)))));
                                      })))
                        ])
                      : CustomButton(
                          text: 'Sign in to see your Addresses',
                          fontSize: 16,
                          onPressed: () {
                            Get.deleteAll();
                            productDetailController.navigateTo(LoginScreen(
                                from: SharedPreferencesKeys.isDrawer));
                          }),
                ],
              ));
        });
  }

  void _showDialog(ProductDetailController productDetailController) async {
    await showDialog(
        context: productDetailController.context,
        builder: (_) {
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.of(productDetailController.context).pop(true);
          });
          return Center(
              child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.appBarColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          color: Colors.white,
                        ),
                        10.widthBox,
                        Text(
                          'Added To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )));
        });
  }
}
