import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/dashboard/full_image_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/product_detail_controller.dart';
import '../../../lang/locale_keys.g.dart';

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
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                ImageConstanst.locationPinIcon,
                                color: Color(0xFF838383),
                                height: 16,
                                width: 16,
                              ),
                              3.widthBox,
                              Text(
                                '1999 Bluff Street MOODY Alabama - 35004',
                                style: TextStyle(
                                    color: Color(0xFF838383), fontSize: 12),
                              ),
                            ],
                          )),
                      _imagePriceView(productDetailController),
                    ],
                  )));
        });
  }

  Widget _imagePriceView(ProductDetailController productDetailController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                color: Color(0xFFF3F3F3),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        width: double.maxFinite,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  color: Colors.green,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    'NEW',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF6F6F6),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2)),
                                    ),
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        InkWell(
                                            onTap: () {},
                                            child: Icon(CupertinoIcons.heart,
                                                color: Color(0xFF757575))),
                                        InkWell(
                                            onTap: () {},
                                            child: Icon(
                                              Icons.share,
                                              color: Color(0xFF757575),
                                            )),
                                      ],
                                    ))),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 50, right: 40, left: 40),
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 200,
                                            width: 400,
                                            child: InkWell(
                                                onTap: () {
                                                  productDetailController
                                                      .navigateTo(FullImageScreen(
                                                          image: productDetailController
                                                                  .imgList[
                                                              productDetailController
                                                                  .current]));
                                                },
                                                child: CarouselSlider(
                                                  items: productDetailController
                                                      .imageSliders,
                                                  carouselController:
                                                      productDetailController
                                                          .controller,
                                                  options: CarouselOptions(
                                                    autoPlay: false,
                                                    enlargeCenterPage: false,
                                                    viewportFraction: 1,
                                                    aspectRatio: 1.6,
                                                    pageSnapping: true,
                                                    onPageChanged:
                                                        (index, reason) {
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: productDetailController
                                                  .imgList
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      productDetailController
                                                          .controller
                                                          .animateToPage(
                                                              entry.key),
                                                  child: Container(
                                                    width: 8.0,
                                                    height: 8.0,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: productDetailController
                                                                    .current ==
                                                                entry.key
                                                            ? AppColors
                                                                .primaryColor
                                                            : Colors.white),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2)),
                                          border: Border.all(
                                              color: productDetailController
                                                          .current ==
                                                      index
                                                  ? AppColors.primaryColor
                                                  : Colors.white)),
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.only(right: 5),
                                      child: Image.network(
                                        productDetailController.imgList[index],
                                        fit: BoxFit.cover,
                                      )));
                            })),
                    10.heightBox,
                    Text(
                      'Canon EOS 1300D 18MP Digital SLR Camera (Black) with 18-55mm ISII Lens, 16GB Card and',
                      style: TextStyle(
                          color: Color(0xFF48505C),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    5.heightBox,
                    Row(
                      children: [
                        Text(
                          'by',
                          style:
                              TextStyle(color: Color(0xFF48505C), fontSize: 16),
                        ),
                        5.widthBox,
                        Text(
                          'Canon',
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    8.heightBox,
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppColors.offerGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text('4.1',
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
                        10.widthBox,
                        Text('(15 Reviews)',
                            style: TextStyle(
                              color: Color(0xFF828282),
                              fontSize: 12,
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
                                style: TextStyle(
                                    color: Color(0xFF636363), fontSize: 15),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'SAR ',
                                    style: TextStyle(
                                        color: Color(0xFFF4500F),
                                        fontSize: 15,
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
                                    color: Color(0xFF727272), fontSize: 15),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'SAR ',
                                    style: TextStyle(
                                        color: Color(0xFF727272), fontSize: 15),
                                  ),
                                  TextSpan(
                                    text: '31,955',
                                    style: TextStyle(
                                        color: Color(0xFF727272), fontSize: 15),
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
                                    color: Color(0xFF636363), fontSize: 15),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'SAR 6,996.00 (22%)',
                                    style: TextStyle(
                                        color: Color(0xFFF4500F), fontSize: 15),
                                  ),
                                ]))),
                    5.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                                text: '${LocaleKeys.fulfilledBy.tr} ',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 15),
                                children: <InlineSpan>[
                              TextSpan(
                                text: '${LocaleKeys.appTitle.tr} ',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'FREE Delivery.',
                                style: TextStyle(
                                    color: Color(0xFF414141),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Details',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 15),
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
                                style: TextStyle(
                                    color: Color(0xFF636363), fontSize: 15),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'FREE Shipping ',
                                    style: TextStyle(
                                        color: Color(0xFF414141),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: 'on order over SAR 200.00 ',
                                    style: TextStyle(
                                        color: Color(0xFF636363), fontSize: 15),
                                  ),
                                  TextSpan(
                                    text: 'Details',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 15),
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
                                style: TextStyle(
                                    color: Color(0xFF636363), fontSize: 15),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Body + 18-55mm Lens',
                                    style: TextStyle(
                                        color: Color(0xFF414141),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]))),
                    10.heightBox,
                    Text(
                      '18MP APS-C CMOS sensor and DIGIC 4+\n'
                      '9-point AF with 1 center cross-type AF point\n'
                      'Standard ISO: 100 to 6400, expandable to 12800\n'
                      'Wi-Fi and NFC supported, Lens Mount: Canon EF mount',
                      style: TextStyle(
                          height: 1.3, color: Color(0xFF636363), fontSize: 15),
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: productDetailController
                                        .selectedColor['name'],
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 15,
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
                                        color: Color(productDetailController
                                            .colors[index]['color']),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child:
                                        productDetailController.selectedColor ==
                                                productDetailController
                                                    .colors[index]
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
                                  color: Colors.white,
                                  height: 35,
                                  width: 35,
                                  child: Icon(
                                    Icons.keyboard_arrow_left_sharp,
                                    color: Colors.black,
                                  ),
                                )),
                            2.widthBox,
                            Container(
                              width: 50,
                              color: Colors.white,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  productDetailController.quntity.toString(),
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
                                  color: Colors.white,
                                  height: 35,
                                  width: 35,
                                  child: Center(
                                      child: Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    color: Colors.black,
                                  )),
                                )),
                            5.widthBox,
                            Expanded(
                                child: Text(
                              '*Minimum order Quantity 1 Piece.',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        )),
                    15.heightBox,
                    _quantityDiscount(productDetailController),
                  ],
                ))));
  }

  Widget _quantityDiscount(ProductDetailController productDetailController) {
    return ExpansionTile(
        trailing: productDetailController.isQuantityDiscounExpanded
            ? Icon(Icons.keyboard_arrow_up, size: 24, color: Colors.white)
            : Icon(Icons.keyboard_arrow_down, size: 24, color: Colors.white),
        onExpansionChanged: (isExapanded) {
          productDetailController.updateQuantityDiscountExpanded();
        },
        backgroundColor: Colors.black,
        collapsedBackgroundColor: Colors.black,
        initiallyExpanded: true,
        key: PageStorageKey<String>('Bulk quantity Discounts!!'),
        title: Text('Bulk quantity Discounts!!',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.0),
            child: Table(
              border: TableBorder.all(color: Color(0xFFF0F0F0)),
              children: [
                TableRow(children: [
                  Container(width: 20,height: 40, child: Checkbox(onChanged: (bool? value) {  }, value: true,)),
                  Container(
                      height: 40,

                      child: Center(
                          child: Text(
                        'Quanity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
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
                            fontSize: 15),
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
                              fontSize: 15),
                        ),
                      ))
                ]),
                TableRow(children: [
                  Container(width: 20,height: 40, child: Checkbox(onChanged: (bool? value) {  }, value: true,)),
                  Container(
                      height: 40,

                      child: Center(
                          child: Text(
                            'Quanity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
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
                                fontSize: 15),
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
                              fontSize: 15),
                        ),
                      ))
                ])
              ],
            ),
          )
        ]);
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
                  onPressed: () {},
                ),
                InkWell(
                  child: SvgPicture.asset(
                    ImageConstanst.shoppingCartIcon,
                    color: Colors.white,
                    height: 24,
                    width: 24,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ));
  }
}
