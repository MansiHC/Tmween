import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../model/get_customer_address_list_model.dart';

class AddressContainer extends StatelessWidget {
  AddressContainer({Key? key, required this.address}) : super(key: key);
  final Address address;
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return Container(
      width: 160,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: address.defaultAddress == 1
              ? AppColors.lightBlueBackground
              : Colors.white,
          border: Border.all(color: AppColors.lightBlue),
          boxShadow: [
            if (address.defaultAddress == 1)
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
                child: Text(address.fullname!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xFF33383C),
                        fontSize: 15,
                        fontWeight: FontWeight.bold))),
            5.heightBox,
            Text(address.address1!,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF626E7A), fontSize: 15)),
            if (address.address2!.isNotEmpty)
              Text(address.address2!,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF626E7A), fontSize: 15)),

            RichText(
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: '${address.cityName}, ',
                    style: TextStyle(color: Color(0xFF626E7A), fontSize: 15),
                    children: [
                      TextSpan(
                          text: '${address.zip},',
                          style:
                              TextStyle(color: Color(0xFF626E7A), fontSize: 15))
                    ])), RichText(
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: '${address.stateName}, ',
                    style: TextStyle(color: Color(0xFF626E7A), fontSize: 15),
                    children: [
                      TextSpan(
                          text: '${address.countryName},',
                          style:
                              TextStyle(color: Color(0xFF626E7A), fontSize: 15))
                    ])),
      10.heightBox,
            Visibility(
                visible: address.defaultAddress == 1,
                child: Align(
                    alignment: language == 'ar'
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
                    child: Text(LocaleKeys.defaultAddress.tr,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF2F302F),
                            fontSize: 15,
                            fontWeight: FontWeight.bold))))
          ]),
    );
  }
}
