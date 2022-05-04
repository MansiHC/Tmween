import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/cart/cart_product_container.dart';
import 'package:tmween/screens/drawer/cart/recently_viewed_product_screen.dart';
import 'package:tmween/screens/drawer/cart/recommended_product_container.dart';
import 'package:tmween/screens/drawer/cart/recommended_product_screen.dart';
import 'package:tmween/screens/drawer/checkout/shipping_address_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/cart_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../utils/my_shared_preferences.dart';
import 'cart_recent_viewed_product_container.dart';

class CartScreen extends StatefulWidget {
  final String from;

  CartScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  late String language;

  final cartController = Get.put(CartController());

  @override
  void initState() {
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      cartController.token = value!;
      print('dhsh.....${cartController.token}');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        cartController.userId = value!;
        cartController.getCartProducts(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          cartController.loginLogId = value!;
        });
      });
    });
    super.initState();
  }

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
                      if (widget.from == AppConstants.productDetail)
                        Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity, maxHeight: 90),
                            color: AppColors.appBarColor,
                            padding: EdgeInsets.only(top: 20),
                            child: topView(cartController)),
                      if (cartController.cartData == null)
                        _noCartView(cartController),
                      if (cartController.cartData != null)
                        Expanded(child: _bottomView(cartController))
                    ],
                  )));
        });
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
                        text: '${LocaleKeys.basketSubTotal.tr} ',
                        style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        children: <InlineSpan>[
                          TextSpan(
                            text:
                                '(${cartController.cartCount} ${LocaleKeys.items.tr})',
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
                            text:
                                '${cartController.cartData!.currencyCode} ${cartController.totalAmount}',
                            style: TextStyle(
                                color: Color(0xFFF4500F),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ])),
                /*  TextButton(
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
                        ])),*/
                10.heightBox,
                CustomButton(
                  text: LocaleKeys.proceedToCheckout.tr,
                  fontSize: 17,
                  backgroundColor: Color(0xFF27AE61),
                  onPressed: () {
                    cartController.navigateTo(ShippingAddressScreen(
                        /*cartData: cartController.cartData,
                    shippingAmount: cartController.shippingAmount,
                    taxAmount: cartController.taxAmount,
                    totalAmount: cartController.totalAmount
*/
                        ));
                  },
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.cartData!.cartItemDetails!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartProductContainer(
                              cartProductModel:
                                  cartController.cartData!.cartItemDetails![index],
                              index: index),
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
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Center(
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: '${LocaleKeys.subTotal.tr} ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                              children: <InlineSpan>[
                                TextSpan(
                                  text:
                                      '${cartController.cartData!.currencyCode} ',
                                  style: TextStyle(
                                      color: Color(0xFFEF461F),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: cartController.totalAmount
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]))),
                ),
                // Container(
                //     width: double.maxFinite,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Color(0xFFF9F9F9),
                //         ),
                //         borderRadius: BorderRadius.only(
                //             bottomLeft: Radius.circular(6),
                //             bottomRight: Radius.circular(6))),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         10.heightBox,
                //         SvgPicture.asset(
                //           ImageConstanst.info,
                //           height: 20,
                //           width: 20,
                //         ),
                //         10.heightBox,
                //         Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 25),
                //             child: Text(
                //                 'Add 70.01 SAR of "Fulfilled by Tmween" items to your order to quality for Free Shipping.',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     color: Color(0xFF333333),
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.bold))),
                //         10.heightBox
                //       ],
                //     )),
                15.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(cartController.recommendedProductsData!.length>0)
                    Expanded(
                        child: Text(
                      LocaleKeys.recommendationForAllProducts.tr,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )),
                    if(cartController.recommendedProductsData!.length>3)
                    InkWell(
                        onTap: (){
cartController.navigateTo(RecommendedProductScreen(productIdList:cartController.productIdList!));
                        },
                        child:Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr,
                          style:
                              TextStyle(color: Color(0xFF626262), fontSize: 11),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF626262),
                          size: 16,
                        )
                      ],
                    ))
                  ],
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.recommendedProductsData!.length>3?3:cartController.recommendedProductsData!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          RecommendedProductContainer(
                              recommendedProductModel:
                                  cartController.recommendedProductsData![index]),
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
                    if(cartController.recentlyViewedProducts!.length>0)
                    Expanded(
                        child: Text(
                      LocaleKeys.yourRecentlyViewedItems.tr,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )),
    if(cartController.recentlyViewedProducts!.length>3)
    InkWell(
    onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RecentlyViewedProductScreen())).then((value) => cartController.getCartProducts(language));
    },
    child:
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr,
                          style:
                              TextStyle(color: Color(0xFF626262), fontSize: 11),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF626262),
                          size: 16,
                        )
                      ],
                    ))
                  ],
                ),
                10.heightBox,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: cartController.recentlyViewedProducts!.length>3?3:cartController.recentlyViewedProducts!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CartRecentViewedProductContainer(
                              cartRecentViewedProductModel: cartController
                                  .recentlyViewedProducts![index]),
                          15.heightBox
                        ],
                      );
                    }),
              ],
            )));
  }

  Widget _guaranteeSection(CartController cartController) {
    return Container(
        decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFFF3F3F3)),
    ),
    child: Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(0xFF314156),
          boxShadow: [
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
                  LocaleKeys.guaranteePurchaseProtection,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ))
              ],
            )),
        Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child:
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
                              LocaleKeys.warranty.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          LocaleKeys.asPerWeswox.tr,
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
                              LocaleKeys.percentOriginal.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\n${LocaleKeys.products.tr}",
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
                              LocaleKeys.secure.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\n${LocaleKeys.payments.tr}",
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
                              LocaleKeys.percentBuyer.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text(
                          "\n${LocaleKeys.protection.tr}",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF5C5C5C), fontSize: 12),
                        ),
                      ],
                    )),
              ],
            ))
      ],
    ));
  }

  Widget _noCartView(CartController cartController) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: MediaQuery.of(cartController.context).size.height / 3),
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xFFD7D7D7))),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                5.heightBox,
                Text(
                  LocaleKeys.cartEmpty.tr,
                  style: TextStyle(fontSize: 16, color: Color(0xFF737373)),
                ),
                10.heightBox,
                CustomButton(
                    text: LocaleKeys.startShopping,
                    fontSize: 18,
                    onPressed: () {
                      cartController.navigateToDashboardScreen();
                    }),
                5.heightBox
              ],
            ))));
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
}
