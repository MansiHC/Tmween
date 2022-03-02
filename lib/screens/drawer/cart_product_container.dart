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

class CartProductContainer extends StatelessWidget {
  CartProductContainer({Key? key, required this.cartProductModel})
      : super(key: key);
  final CartProductModel cartProductModel;
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(cartProductModel.rating,
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
                    Image.network(
                      cartProductModel.image,
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    )
                  ],
                ),
                10.widthBox,
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.heightBox,
                    Text(cartProductModel.title,
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(0xFF333333), fontSize: 12,fontWeight: FontWeight.bold)),
                 5.heightBox,
                    Wrap(

                      children:
                    [
                      Text('${LocaleKeys.sar.tr} ${cartProductModel.price}',
                          textAlign: TextAlign.start,
                          style:
                          TextStyle(color: Color(0xFFF57051), fontSize: 12,fontWeight: FontWeight.bold)),
                      10.widthBox,
                      if (cartProductModel.isFulFilled)
                      RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: LocaleKeys.fulfilledBy.tr,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF888888)),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: LocaleKeys.appTitle.tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ]))
                    ],),
                    5.heightBox,
                   Wrap(children:
                       List.generate(cartProductModel.specifications.length, (index) => Wrap(children: [
                         Text('${cartProductModel.specifications[index]['title']}: ',
                             textAlign: TextAlign.start,
                             style:
                             TextStyle(color: Color(0xFF888888), fontSize: 12,fontWeight: FontWeight.bold)),
                         Text(
                             cartProductModel.specifications.length-1==index?
                             '${cartProductModel.specifications[index]['value']}':
                             '${cartProductModel.specifications[index]['value']}, ',
                             style:
                             TextStyle(color: Color(0xFF888888), fontSize: 12)),],)),


                    ),
                    5.heightBox,
                    if(cartProductModel.inStock)
                      Text(LocaleKeys.inStock.tr,
                          textAlign: TextAlign.start,
                          style:
                          TextStyle(color: Color(0xFF3B963C), fontSize: 12,fontWeight: FontWeight.bold)),
                    if(!cartProductModel.inStock)
                      Text('${LocaleKeys.orderNowOnly.tr} ${cartProductModel.stockCount} ${LocaleKeys.leftInStock}!',
                          textAlign: TextAlign.start,
                          style:
                          TextStyle(color: Color(0xFFF24F2B), fontSize: 12,fontWeight: FontWeight.bold)),
5.heightBox,
                     Wrap(
                          children: [
                            InkWell(
                                onTap: () {
                                  if (cartController.quntity != 1) {
                                    cartController.quntity--;
                                    cartController.update();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFF4F4F4))),
                                  height: 25,
                                  width: 25,
                                  child: Icon(
                                    Icons.keyboard_arrow_left_sharp,
                                    color: Color(0xFF48525E),
                                    size: 22,
                                  ),
                                )),
                            Container(
                              width: 30,
                              height: 25,
                              decoration: BoxDecoration(color: Colors.white,
                              border: Border.all(color: Color(0xFFF4F4F4))),
                              child:Center(child: Text(cartController.quntity.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF656565),
                                    fontSize: 12
                                  ) )),
                            ),
                            InkWell(
                                onTap: () {
                                  cartController.quntity++;
                                  cartController.update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color(0xFFF4F4F4))
                                      ),
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                      child: Icon(
                                        Icons.keyboard_arrow_right_sharp,
                                        color: Color(0xFF48525E),
                                        size: 22,
                                      )),
                                )),
                            5.widthBox,

                       Container(color:Color(0xFF0088CA),
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        child:Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                        SvgPicture.asset(ImageConstanst.save,height: 14,width: 14,),
                        5.widthBox,
                        Text(LocaleKeys.saveForLater.tr,
                            textAlign: TextAlign.start,
                            style:
                            TextStyle(color: Colors.white, fontSize: 12)),

                      ],),),
                      10.widthBox,
                      if(cartProductModel.isFree)
                      SvgPicture.asset(ImageConstanst.freeDelivery,height: 24,width: 24,),

                    ],),
                    10.heightBox
                  ],
                )),
                10.widthBox,
                InkWell(onTap:(){},child:SvgPicture.asset(ImageConstanst.delete,height: 16,width: 16,)),
              ])),
    );});
  }
}
