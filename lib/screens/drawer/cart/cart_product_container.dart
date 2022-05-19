import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_cart_products_model.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../../utils/global.dart';
import '../../../controller/cart_controller.dart';

class CartProductContainer extends StatelessWidget {
  CartProductContainer(
      {Key? key, required this.cartProductModel, required this.index})
      : super(key: key);
  final CartItemDetails cartProductModel;
  int index;

  var language;
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    print('....${cartController.cartQuantityList.length}....$index');
    return GetBuilder<CartController>(
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
                          cartProductModel.reviewsAvg == 0
                              ? Container(
                                  width: 10,
                                )
                              : Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: AppColors.offerGreen,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                          cartProductModel.reviewsAvg
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    ],
                                  )),
                          5.heightBox,
                          cartProductModel.largeImageUrl!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: cartProductModel.largeImageUrl!,
                                  height:
                                      MediaQuery.of(context).size.width / 4.5,
                                  placeholder: (context, url) => Center(
                                      child: CupertinoActivityIndicator()),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.width / 5.3,
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
                          Text(cartProductModel.productName!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                          5.heightBox,
                          Wrap(
                            children: [
                              Text('${cartProductModel.finalPrice}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFFF57051),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              10.widthBox,
                              if (true)
                                RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: LocaleKeys.fulfilledBy.tr,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF888888)),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: LocaleKeys.appTitle.tr,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ]))
                            ],
                          ),
                          5.heightBox,
                          Wrap(
                            children: List.generate(
                                cartProductModel
                                    .attributeOptionsDetails!.length,
                                (index) => Wrap(
                                      children: [
                                        Text(
                                            '${cartProductModel.attributeOptionsDetails![index].attributeName}: ',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Color(0xFF888888),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            cartProductModel.attributeOptionsDetails!
                                                            .length -
                                                        1 ==
                                                    index
                                                ? '${cartProductModel.attributeOptionsDetails![index].attributeOptionValue}'
                                                : '${cartProductModel.attributeOptionsDetails![index].attributeOptionValue}, ',
                                            style: TextStyle(
                                                color: Color(0xFF888888),
                                                fontSize: 12)),
                                      ],
                                    )),
                          ),
                          if (cartProductModel.attributeOptionsDetails!.length >
                              0)
                            5.heightBox,
                          if (true)
                            Text(LocaleKeys.inStock.tr,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF3B963C),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          if (!true)
                            Text(
                                '${LocaleKeys.orderNowOnly.tr} ${cartProductModel} ${LocaleKeys.leftInStock}!',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFFF24F2B),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          5.heightBox,
                          Wrap(
                            children: [
                              InkWell(
                                  onTap: () {
                                    var qty = cartController
                                        .cartQuantityList[index].quantity;
                                    if (qty != 1) {
                                      /* cartProductModel.quantity = qty--;
                                     cartController.cartQuantityList[index]
                                         .setQuantity = qty--;
                                     cartController.update();
*/
                                      cartController.editCartProductDecrease(
                                          cartProductModel.id,
                                          cartProductModel.productId,
                                          cartProductModel.quoteId,
                                          qty,
                                          language,
                                          cartProductModel.quantity,
                                          index);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xFFF4F4F4))),
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
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Color(0xFFF4F4F4))),
                                child: Center(
                                    child: Text(
                                        cartController
                                            .cartQuantityList[index].quantity
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFF656565),
                                            fontSize: 12))),
                              ),
                              InkWell(
                                  onTap: () {
                                    var qty = cartController
                                        .cartQuantityList[index].quantity;
                                    /*cartProductModel.quantity = qty++;
                                    cartController.cartQuantityList[index]
                                        .setQuantity = qty++;
                                    cartController.update();*/
                                    cartController.editCartProductIncrease(
                                        cartProductModel.id,
                                        cartProductModel.productId,
                                        cartProductModel.quoteId,
                                        qty,
                                        language,
                                        cartProductModel.quantity,
                                        index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Color(0xFFF4F4F4))),
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
                              if (!cartController.wishListedProduct
                                  .contains(cartProductModel.productId))
                                InkWell(
                                    onTap: () {
                                      cartController.addToWishlist(
                                          cartProductModel.productId, language);
                                    },
                                    child: Container(
                                      color: Color(0xFF0088CA),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            ImageConstanst.save,
                                            height: 14,
                                            width: 14,
                                          ),
                                          5.widthBox,
                                          Text(LocaleKeys.saveForLater.tr,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    )),
                              10.widthBox,
                              /* if (cartProductModel.isFree)
                                SvgPicture.asset(
                                  ImageConstanst.freeDelivery,
                                  height: 24,
                                  width: 24,
                                ),*/
                            ],
                          ),
                          10.heightBox
                        ],
                      )),
                      10.widthBox,
                      InkWell(
                          onTap: () {
                            print(
                                '..${cartProductModel.productId}...${cartProductModel.quoteId}....${cartProductModel.productItemId}....${cartProductModel.customerAddressId}....');
                            cartController.deleteCartProduct(
                                cartProductModel.quoteId,
                                cartProductModel.id,
                                language,
                                cartProductModel.quantity!);
                          },
                          child: SvgPicture.asset(
                            ImageConstanst.delete,
                            height: 16,
                            width: 16,
                          )),
                    ])),
          );
        });
  }
}
