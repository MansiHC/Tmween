import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class AddressContainer extends StatelessWidget {
  AddressContainer({Key? key, required this.address}) : super(key: key);
  final AddressModel address;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 150,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color:
              address.isDefault ? AppColors.lightBlueBackground : Colors.white,
          border: Border.all(color: AppColors.lightBlue),
          boxShadow: [
            if (address.isDefault)
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
            Align(
                alignment:
                    language == 'ar' ? Alignment.topRight : Alignment.topLeft,
                child: Text(address.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold))),
            5.heightBox,
            Text(address.addressLine1,
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontSize: 13)),
            if (address.addressLine2.isNotEmpty)
              Text(address.addressLine2,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 13)),
            Row(
              children: [
                Text('${address.city},',
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                5.widthBox,
                Text('${address.state},',
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 13))
              ],
            ),
            Text(address.country,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 13)),
            Expanded(
                child: Text(address.pincode,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 13))),
            10.heightBox,
            Visibility(
                visible: address.isDefault,
                child: Align(
                    alignment: language == 'ar'
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    child: Text(LocaleKeys.defaultAddress.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold))))
          ]),
    );
  }
}
