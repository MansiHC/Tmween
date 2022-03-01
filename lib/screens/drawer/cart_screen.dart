import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/screens/drawer/cart_product_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/add_address_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  late String language;

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
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(cartController)),
                      _bottomView(cartController),
                    ],
                  )));
        });
  }

  Widget _bottomView(CartController cartController) {
    return Expanded(
        child: SingleChildScrollView(
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
                                style: TextStyle(color: Color(0xFF333333), fontSize: 14,fontWeight: FontWeight.bold),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '(2 items)',
                                    style: TextStyle(
                                        color: Color(0xFF39A0D4),
                                        fontSize: 14,
                                        ),
                                  ),TextSpan(
                                    text: ': ',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 14,
                                      fontWeight: FontWeight.bold
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'SAR 2680',
                                    style: TextStyle(
                                        color: Color(0xFFF4500F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                                cartController.freeChecked= !cartController.freeChecked;
                                cartController.update();
                                },
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 18.0,
                                      width: 18.0,
                                      child: Theme(
                                          data: Theme.of(cartController.context)
                                              .copyWith(
                                            unselectedWidgetColor:
                                            Colors.grey,
                                          ),
                                          child: Checkbox(
                                              value:
                                              cartController
                                                  .freeChecked,
                                              activeColor: AppColors
                                                  .primaryColor,
                                              onChanged: (value) {
                                                cartController.freeChecked = value!;
                                                cartController.update();
                                              }))),
                                  10.widthBox,
                                  RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          text: 'Eligible for ',
                                          style: TextStyle(color: Color(0xFF333333), fontSize: 14,fontWeight: FontWeight.bold),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: 'FREE ',
                                              style: TextStyle(
                                                color: Color(0xFF57A659),
                                                fontSize: 14,fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Shipping',
                                              style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 14,fontWeight: FontWeight.bold
                                                  ),
                                            ),
                                          ])),
                                ])),
                        5.heightBox,
                        CustomButton(text: 'PROCEED TO CHECKOUT',
                          fontSize: 17,
                          backgroundColor:Color(0xFF27AE61),onPressed: (){},),
                        10.heightBox,
                        ListView.builder(
                            padding: EdgeInsets.zero,
                          shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: cartController.cartProducts.length,
                            itemBuilder: (context, index) {
                              return Column(children: [CartProductContainer(
                                  cartProductModel:
                                  cartController.cartProducts[index]),
                              15.heightBox],);
                            }),
                        5.heightBox,
                        Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color:Color(0xFF232F3F),
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(6),topRight: Radius.circular(6))
                            ),
                            child:
                      Center(child:   RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: 'SUBTOTAL: ',
                                  style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: 'SAR ',
                                      style: TextStyle(
                                        color: Color(0xFFEF461F),
                                        fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),TextSpan(
                                      text: '2680',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),

                                  ]))),
                        ),
    Container(
    width: double.maxFinite,

    decoration: BoxDecoration(

    border: Border.all(color:Color(0xFFF9F9F9),),
    borderRadius: BorderRadius.only(bottomLeft:Radius.circular(6),bottomRight: Radius.circular(6))
    ),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        10.heightBox,
        SvgPicture.asset(ImageConstanst.info,height: 20,width: 20,),
10.heightBox,
       Padding(padding: EdgeInsets.symmetric(horizontal: 25),child: Text('Add 70.01 SAR of "Fulfilled by Tmween" items to your order to quality for Free Shipping.',
            textAlign: TextAlign.center,
            style:
            TextStyle(color: Color(0xFF333333), fontSize: 12,fontWeight: FontWeight.bold))),
        10.heightBox
      ],)
    ),
                        10.heightBox,
    ],
                    ))));
  }

  Widget topView(CartController cartController) {
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
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                'My Cart',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
