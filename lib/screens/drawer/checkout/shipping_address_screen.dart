import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/shipping_address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_cart_products_model.dart';
import 'package:tmween/screens/drawer/checkout/payment_option_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../utils/views/circular_progress_bar.dart';

class ShippingAddressScreen extends StatelessWidget {
  late String language;

  final CartData? cartData;

  ShippingAddressScreen({Key? key, required this.cartData}) : super(key: key);

  final addressController = Get.put(ShippingAddressController());

  Future<bool> _onWillPop(ShippingAddressController addressController) async {
    addressController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ShippingAddressController>(
        init: ShippingAddressController(),
        builder: (contet) {
          addressController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(addressController),
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
                              child: topView(addressController)),
                          5.heightBox,
                          Expanded(
                              child: SingleChildScrollView(
                                  child: _bottomView(addressController))),
                        ],
                      ))));
        });
  }

  _bottomView(ShippingAddressController addressController) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: addressController.loading,
              child: CircularProgressBar(),
            ),
            Visibility(
              visible: !addressController.loading &&
                  addressController.addressList.length == 0,
              child: Center(
                  child: Text(
                'No Address',
                style: TextStyle(
                    color: Color(0xFF414141),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Visibility(
                visible: !addressController.loading &&
                    addressController.addressList.length > 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.heightBox,
                      Text(
                        'Select a shipping address',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      5.heightBox,
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: addressController.addressList.length,
                              itemBuilder: (context, index) {
                                return _addressContainer(
                                  addressController,
                                  addressController.addressList[index],
                                  index,
                                );
                              }))
                    ])),
            10.heightBox,
            CustomButton(
                fontSize: 17,
                text: LocaleKeys.addNewAddress,
                onPressed: () {
                  addressController.navigateToAddAddressScreen();
                }),
            10.heightBox,
            Text('Your order',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            5.heightBox,
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Product',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                            Text('Total',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                          ],
                        )),
                    Divider(
                      color: Colors.grey[300]!,
                      height: 1,
                      thickness: 1,
                    ),
                   for (var i = 0; i < cartData!.cartDetails!.length; i++)
                      Column(children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                        cartData!.cartDetails![i].productName!,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Color(0xFF666666),
                                            fontSize: 15))),
                                Text(cartData!.cartDetails![i].finalPrice!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontSize: 15,
                                    )),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Item(${cartData!.cartDetails![i].quantity!})',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontSize: 15)),
                                Text(
                                    '${cartData!.currencyCode} ${cartData!.cartDetails![i].itemFinalTotal!.toString()}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontSize: 15,
                                    )),
                              ],
                            )),
                        Divider(
                          color: Colors.grey[300]!,
                          height: 1,
                          thickness: 1,
                        ),
                      ]),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                            Text(
                                '${cartData!.currencyCode} ${cartData!.totalDeliveryPrice}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                            Text(
                                '${cartData!.currencyCode} ${cartData!.totalTaxAmount}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        )),
                    Divider(
                      color: Colors.grey[300]!,
                      height: 1,
                      thickness: 1,
                    ),
                    Container(
                        color: Colors.grey[200]!,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                '${cartData!.currencyCode} ${cartData!.totalPrice}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15)),
                          ],
                        )),
                  ],
                )),
            15.heightBox,
            Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Wrap(spacing: 10, children: [
                    Text(
                      'Proceed to Pay',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SvgPicture.asset(
                      ImageConstanst.payIcon,
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    )
                  ]),
                  onPressed: () {
                    addressController.navigateTo(PaymentOptionScreen());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF27AF61)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10)),
                  ),
                )),
            15.heightBox,
          ],
        ));
  }

  _addressContainer(
      ShippingAddressController addressController, address, index) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: InkWell(
              onTap: (){
                addressController.radioCurrentValue = addressController.radioValue[index];
                addressController.update();
              },
              child:

          Row(
            children: [
              Container(
                height: 40,
                child: Radio(
                  value: addressController.radioValue[index],
                  groupValue: addressController.radioCurrentValue,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  activeColor: Color(0xFF1992CE),
                  onChanged: (int? value) {
                    addressController.radioCurrentValue = value!;
                    addressController.update();
                  },
                ),
              ),
              5.widthBox,
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(address.fullname!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    3.heightBox,
                    Text('${address.address1!}, ${address.address2!}',
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(color: Color(0xFF666666), fontSize: 15)),
                    3.heightBox,
                    if (address.landmark != null)
                      Text('${address.landmark!}, ${address.zip!}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xFF666666), fontSize: 15)),
                    if (address.landmark == null)
                      Text('${address.zip!}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xFF666666), fontSize: 15)),
                    3.heightBox,
                    if (address.stateName != null)
                      Text(
                          '${address.cityName!}, ${address.stateName!}, ${address.countryName!}',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: TextStyle(
                              color: Color(0xFF666666), fontSize: 15)),
                    3.heightBox,
                  ]),
            ],
          )))
    ]);
  }

  Widget topView(ShippingAddressController addressController) {
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
                'Shipping Address',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
