import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/cart_product_container.dart';
import 'package:tmween/screens/drawer/recommended_product_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../controller/cart_controller.dart';
import 'cart_recent_viewed_product_container.dart';

class CartScreen extends StatelessWidget {
  late String language;
  final String from;

  CartScreen({Key? key, required this.from}) : super(key: key);

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (contet) {
          cartController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (from == AppConstants.productDetail)
                        Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity, maxHeight: 90),
                            color: AppColors.appBarColor,
                            padding: EdgeInsets.only(top: 20),
                            child: topView(cartController)),
                      Expanded(child: _bottomView(cartController))
                    ],
                  )));
        });
  }

  Widget topView(CartController cartController) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipOval(
            child: Material(
              color: Colors.white, // Button color
              child: InkWell(
                onTap: () {
                  cartController.exitScreen();
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
        ));
  }

  Widget _bottomView(CartController cartController) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(
              15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                5.heightBox,
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: 'BASKET SUBTOTAL ',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '(2 items)',
                            style: TextStyle(
                              color: Color(0xFF39A0D4),
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: ': ',
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'SAR 2680',
                            style: TextStyle(
                                color: Color(0xFFF4500F),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ])),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      cartController.freeChecked = !cartController.freeChecked;
                      cartController.update();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: Theme(
                                  data:
                                      Theme.of(cartController.context).copyWith(
                                    unselectedWidgetColor: Colors.grey,
                                  ),
                                  child: Checkbox(
                                      value: cartController.freeChecked,
                                      activeColor: AppColors.primaryColor,
                                      onChanged: (value) {
                                        cartController.freeChecked = value!;
                                        cartController.update();
                                      }))),
                          10.widthBox,
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'Eligible for ',
                                  style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: 'FREE ',
                                      style: TextStyle(
                                          color: Color(0xFF57A659),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'Shipping',
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ])),
                        ])),
                5.heightBox,
                CustomButton(
                  text: 'PROCEED TO CHECKOUT',
                  fontSize: 17,
                  backgroundColor: Color(0xFF27AE61),
                  onPressed: () {},
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.cartProducts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartProductContainer(
                              cartProductModel:
                                  cartController.cartProducts[index]),
                          15.heightBox
                        ],
                      );
                    }),
                5.heightBox,
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF232F3F),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6))),
                  child: Center(
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: 'SUBTOTAL: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'SAR ',
                                  style: TextStyle(
                                      color: Color(0xFFEF461F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: '2680',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]))),
                ),
                Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFF9F9F9),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.heightBox,
                        SvgPicture.asset(
                          ImageConstanst.info,
                          height: 20,
                          width: 20,
                        ),
                        10.heightBox,
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                                'Add 70.01 SAR of "Fulfilled by Tmween" items to your order to quality for Free Shipping.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                        10.heightBox
                      ],
                    )),
                15.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'RECOMMENDATION FOR ALL PRODUCTS',
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'View All',
                          style:
                              TextStyle(color: Color(0xFF626262), fontSize: 11),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF626262),
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.recommendedProducts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RecommendedProductContainer(
                              recommendedProductModel:
                                  cartController.recommendedProducts[index]),
                          15.heightBox
                        ],
                      );
                    }),
                15.heightBox,
                _guaranteeSection(cartController),
                15.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'YOUR RECENTLY VIEWED ITEMS',
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'View All',
                          style:
                              TextStyle(color: Color(0xFF626262), fontSize: 11),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF626262),
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.cartRecentViewedProducts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartRecentViewedProductContainer(
                              cartRecentViewedProductModel: cartController
                                  .cartRecentViewedProducts[index]),
                          15.heightBox
                        ],
                      );
                    }),
              ],
            )));
  }

  Widget _guaranteeSection(CartController cartController) {
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
}
