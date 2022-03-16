import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
import '../../../utils/views/expandable_text.dart';
import '../address_container.dart';
import '../cart_screen.dart';
import '../profile/add_address_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  late String language;
  final productDetailController = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ProductDetailController>(
        init: ProductDetailController(),
        builder: (contet) {
          productDetailController.context = context;
          return Scaffold(
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
                                    'Alabama - 35004',
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
                      _bottomView(productDetailController),
                    ],
                  )));
        });
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
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        color: Color(0xFF158D07),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'NEW',
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
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    productDetailController.isLiked =
                                        !productDetailController.isLiked;
                                    productDetailController.update();
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
                              15.heightBox,
                              InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    ImageConstanst.share,
                                    color: Color(0xFF666666),
                                    height: 20,
                                    width: 20,
                                  )),
                            ],
                          ))),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
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
                                                    .current));
                                      },
                                      child: CarouselSlider(
                                        items: productDetailController
                                            .imageSliders,
                                        carouselController:
                                            productDetailController.controller,
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
                              Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: productDetailController.imgList
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
                                              vertical: 8.0, horizontal: 4.0),
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
                          ))),
                ],
              )),
          5.heightBox,
          Container(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productDetailController.imgList.length,
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
                            child: Image.asset(
                              productDetailController.imgList[index],
                              fit: BoxFit.contain,
                            )));
                  })),
          10.heightBox,
          Text(
            'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and',
            style: TextStyle(
                color: Color(0xFF2E3846),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          5.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'by ',
                      style: TextStyle(color: Color(0xFF48505C), fontSize: 16),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Canon',
                          style: TextStyle(
                              color: Color(0xFF1992CE),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ]))),
          8.heightBox,
          Row(
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
                      Text('4.1',
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
              Text('(15 Reviews)',
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
          20.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Price: ',
                      style: TextStyle(color: Color(0xFF636363), fontSize: 14),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'SAR ',
                          style: TextStyle(
                              color: Color(0xFFF4500F),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '24,999',
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
                          fontSize: 14),
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
                          text: '31,955',
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
                      style: TextStyle(color: Color(0xFF636363), fontSize: 14),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'SAR 6,996.00 (22%)',
                          style:
                              TextStyle(color: Color(0xFFF4500F), fontSize: 14),
                        ),
                      ]))),
          5.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: '${LocaleKeys.fulfilledBy.tr} ',
                      style: TextStyle(color: Color(0xFF1992CE), fontSize: 14),
                      children: <InlineSpan>[
                    TextSpan(
                      text: '${LocaleKeys.appTitle.tr} ',
                      style: TextStyle(
                          color: Color(0xFF1992CE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'FREE Delivery.',
                      style: TextStyle(
                          color: Color(0xFF414141),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Details',
                      style: TextStyle(color: Color(0xFF1992CE), fontSize: 14),
                    ),
                  ]))),
          15.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFE9E9E9),
          ),
          10.heightBox,
          Align(
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
          ),
          10.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Style name: ',
                      style: TextStyle(color: Color(0xFF636363), fontSize: 14),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Body + 18-55mm Lens',
                          style: TextStyle(
                              color: Color(0xFF414141),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ]))),
          10.heightBox,
          Text(
            '18MP APS-C CMOS sensor and DIGIC 4+\n'
            '9-point AF with 1 center cross-type AF point\n'
            'Standard ISO: 100 to 6400, expandable to 12800\n'
            'Wi-Fi and NFC supported, Lens Mount: Canon EF mount',
            style:
                TextStyle(height: 1.3, color: Color(0xFF636363), fontSize: 14),
          ),
          10.heightBox,
          Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: 'Color : ',
                      style: TextStyle(
                          color: Color(0xFF293341),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      children: <InlineSpan>[
                        TextSpan(
                          text: productDetailController.selectedColor['name'],
                          style: TextStyle(
                              color: Color(0xFF1992CE),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ]))),
          5.heightBox,
          Container(
              height: 24,
              child: ListView.builder(
                  itemCount: productDetailController.colors.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          productDetailController.selectedColor =
                              productDetailController.colors[index];
                          productDetailController.update();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 26,
                          decoration: BoxDecoration(
                              color: Color(productDetailController.colors[index]
                                  ['color']),
                              borderRadius: BorderRadius.circular(40)),
                          child: productDetailController.selectedColor ==
                                  productDetailController.colors[index]
                              ? Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Container(),
                        ));
                  })),
          15.heightBox,
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
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: CustomButton(
                            text: 'BUY NOW', fontSize: 14, onPressed: () {})),
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: CustomButton(
                            text: 'ADD TO CART',
                            fontSize: 14,
                            backgroundColor: Color(0xFF314156),
                            onPressed: () {
                              _showDialog(productDetailController);
                              // productDetailController.navigateToCartScreen();
                            })),
                    10.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _quantityDiscount(productDetailController)),
                    15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _guaranteeSection(productDetailController)),
                    15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _sellerSection(productDetailController)),
                    15.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _productInformation(productDetailController)),
                    0.1.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _specification(productDetailController)),
                    0.1.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _sizeSpecification(productDetailController)),
                    0.1.heightBox,
                    Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: _deliveryReturns(productDetailController)),
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
            itemCount: productDetailController.recentlVieweds.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SimilarProductsContainer(
                  products: productDetailController.recentlVieweds[index]);
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
                    productDetailController.navigateTo(ReviewProductScreen());
                  },
                  child: Container(
                    height: 35,
                    color: AppColors.primaryColor,
                    width: 120,
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
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: productDetailController.reviews.length + 1,
                  itemBuilder: (context, index) {
                    return (index != productDetailController.reviews.length)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                          productDetailController
                                              .reviews[index].rating,
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
                              5.heightBox,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    ImageConstanst.user,
                                    height: 35,
                                    width: 35,
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
                                                      .reviews[index].name,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF000000)),
                                                  children: <InlineSpan>[
                                                    TextSpan(
                                                        text:
                                                            ' - ${productDetailController.reviews[index].date}',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF888888),
                                                          fontSize: 12,
                                                        )),
                                                  ]))),
                                      5.heightBox,
                                      ExpandableText(
                                        productDetailController
                                            .reviews[index].desc,
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
                                          Text('Comment',
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
                              Divider(
                                thickness: 1,
                                height: 5,
                                color: Color(0xFFF7F7F7),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'All 9233 Reviews',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.black)
                              ],
                            ));
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
                      text: 'Riyadh ',
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
                      text: 'Monday, Apr 22 - Wednesday, Apr 24 to Riyadh',
                      style: TextStyle(
                          color: Color(0xFF1992CE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
          8.heightBox,
          Divider(
            thickness: 1,
            height: 5,
            color: Color(0xFFF7F7F7),
          ),
          8.heightBox,
          Row(
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
          5.heightBox,
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
                  Text('Tmween-shop',
                      style: TextStyle(
                          color: Color(0xFF1992CE),
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  3.heightBox,
                  Text('(96% Positive Rating)',
                      style: TextStyle(
                        color: Color(0xFFA0A0A0),
                        fontSize: 12,
                      ))
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
          Text('Only 6 left in stock!',
              style: TextStyle(
                  color: Color(0xFFF77443),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          3.heightBox,
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: '9 offers ',
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
                      text: 'SAR 24,999.00',
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
                  itemCount: productDetailController.sellerOnTmweens.length + 1,
                  itemBuilder: (context, index) {
                    return (index !=
                            productDetailController.sellerOnTmweens.length)
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (index != 0) 5.heightBox,
                                      Text(
                                          'SAR ${productDetailController.sellerOnTmweens[index].amount}',
                                          style: TextStyle(
                                              color: Color(0xFFF77443),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      3.heightBox,
                                      Text(
                                          '+ ${productDetailController.sellerOnTmweens[index].charge} Delivery charge',
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
                                                      .sellerOnTmweens[index]
                                                      .brand,
                                                  style: TextStyle(
                                                      color: Color(0xFF4D5560),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                        : Padding(
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
                                    ])));
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
                          "Products",
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
                          "PAYMENTS",
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
                          "PROTECTION",
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
                            '5-9',
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
                              'SAR 11,464',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF3A3A3A), fontSize: 14),
                            ),
                          ))
                    ]),
                    TableRow(children: [
                      Container(
                        height: 40,
                        child: Radio(
                          value: 2,
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
                            '10+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF3A3A3A), fontSize: 14),
                          ))),
                      Container(
                          height: 40,
                          child: Center(
                              child: Text(
                            '3.43%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF3A3A3A), fontSize: 14),
                          ))),
                      Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'SAR 22,396',
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descriptions:',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      8.heightBox,
                      Text(
                        'Style: Body + 18-55mm Lens',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 14,
                        ),
                      ),
                      8.heightBox,
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 14,
                        ),
                      ),
                      8.heightBox,
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 14,
                        ),
                      ),
                      5.heightBox,
                    ],
                  )),
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
            children: []));
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
    return Container(
        height: 310,
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
            Container(
                height: 160,
                child: ListView.builder(
                    itemCount: productDetailController.addresses.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return (index != productDetailController.addresses.length)
                          ? AddressContainer(
                              address: productDetailController.addresses[index])
                          : InkWell(
                              onTap: () {
                                productDetailController
                                    .navigateTo(AddAddressScreen());
                              },
                              child: Container(
                                  width: 150,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: AppColors.lightBlue),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                  child: Center(
                                      child: Text(LocaleKeys.addAddressText.tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)))));
                    }))
          ],
        ));
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
