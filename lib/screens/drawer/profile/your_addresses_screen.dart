import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/controller/your_order_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/add_address_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

class YourAddressesScreen extends StatelessWidget {
  late String language;
  final addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (contet) {
          addressController.context = context;
          return Scaffold(
              body: Container(
                  color: Color(0xFFF2F2F2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(addressController)),
                      Expanded(
                          child: SingleChildScrollView(
                              child:_bottomView(addressController))),

                    ],
                  )));
        });
  }

  Widget _bottomView(AddressController addressController) {
    return Container(
        padding: EdgeInsets.all(
          15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.heightBox,
            CustomButton(
                fontSize: 17,
                text: LocaleKeys.addNewAddress,
                onPressed: () {
                  addressController.navigateTo(AddAddressScreen());
                }),
            15.heightBox,
            Text(
              LocaleKeys.personalAddress.tr,
              style: TextStyle(
                  color: Color(0xFF414141),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            5.heightBox,
            _addressContainer(addressController, true),
            5.heightBox,
            _addressContainer(addressController, false),
            15.heightBox,
            Text(
              LocaleKeys.officeAddress.tr,
              style: TextStyle(
                  color: Color(0xFF414141),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            5.heightBox,
            _addressContainer(addressController, false),
            20.heightBox,
          ],
        ));
  }

  Widget _addressContainer(
      AddressController addressController, bool isDefault) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: isDefault?AppColors.blue:Colors.white),
          boxShadow: [
            if (isDefault)
              BoxShadow(
                color: AppColors.lightBlue,
                blurRadius: 4.0,
                spreadRadius: 1.0,
              )
          ],
          borderRadius: BorderRadius.all(Radius.circular(2))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Salim Akka',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 15)),
              if(isDefault)
              Text(LocaleKeys.defaultText.tr,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xFF55AFD5), fontSize: 14)),
            ]),
            3.heightBox,
            Text('102/11',
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(0xFF666666), fontSize: 15)),
            3.heightBox,
            Text('Street colony, New Jersey,',
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(0xFF666666), fontSize: 15)),
            3.heightBox,
            Row(
              children: [
                Text('Columbia,',
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 15)),
                5.widthBox,
                Text('22011,',
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 15))
              ],
            ),
            3.heightBox,
            Text('United State',
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(color: Color(0xFF666666), fontSize: 15)),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  horizontalPadding: 20,
                  width: 120,
                    fontSize: 16,
                    text: LocaleKeys.edit,
                    onPressed: () {
                      addressController.navigateTo(AddAddressScreen());
                    }),
                CustomButton(
                    horizontalPadding: 20,
                  width: 120,
                    fontSize: 16,
                    text: LocaleKeys.remove,
                    onPressed: () {
                    }),
              ],
            ),
            10.heightBox
          ]),
    );
  }

  Widget topView(AddressController addressController) {
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
                LocaleKeys.yourAddresses.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
