import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../../model/get_customer_address_list_model.dart';
import '../../../../utils/global.dart';

class AddressListContainer extends StatelessWidget {
  AddressListContainer({Key? key, required this.address, required this.index})
      : super(key: key);
  final Address address;
  final int index;
  var language;

  final addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (contet) {
          addressController.context = context;
          if (address.addressType == "1")
            addressController.countPersonalAddress++;
          if (address.addressType == "2")
            addressController.countOfficeAddress++;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (address.addressType == "1" &&
                    addressController.countPersonalAddress == 1)
                  15.heightBox,
                if (address.addressType == "1" &&
                    addressController.countPersonalAddress == 1)
                  Text(
                    LocaleKeys.personalAddress.tr,
                    style: TextStyle(
                        color: Color(0xFF414141),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                if (address.addressType == "2" &&
                    addressController.countOfficeAddress == 1)
                  15.heightBox,
                if (address.addressType == "2" &&
                    addressController.countOfficeAddress == 1)
                  Text(
                    LocaleKeys.officeAddress.tr,
                    style: TextStyle(
                        color: Color(0xFF414141),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                5.heightBox,
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: address.defaultAddress == 1
                              ? AppColors.blue
                              : Colors.white),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(address.fullname!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF666666), fontSize: 15)),
                              if (address.defaultAddress == 1)
                                Text(LocaleKeys.defaultText.tr,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Color(0xFF55AFD5),
                                        fontSize: 14)),
                            ]),
                        3.heightBox,
                        Text(address.address1!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(0xFF666666), fontSize: 15)),
                        3.heightBox,
                        Text(address.address2!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(0xFF666666), fontSize: 15)),
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
                        if (address.cityName != null)
                          Text(address.cityName!,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 15)),
                        3.heightBox,
                        if (address.stateName != null)
                          Text('${address.stateName!}, ${address.countryName!}',
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 15)),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 120,
                                child: ElevatedButton(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      5.widthBox,
                                      Text(
                                        LocaleKeys.edit.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    addressController
                                        .navigateToAddAddressScreen(address);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.primaryColor),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10)),
                                  ),
                                )),
                            Container(
                                width: 120,
                                child: ElevatedButton(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageConstanst.delete,
                                        color: Colors.white,
                                        height: 16,
                                        width: 16,
                                      ),
                                      5.widthBox,
                                      Text(
                                        LocaleKeys.remove.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    _removeAddress(addressController);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10)),
                                  ),
                                ))
                          ],
                        ),
                        10.heightBox
                      ]),
                )
              ]);
        });
  }

  void _removeAddress(AddressController addressController) async {
    await showDialog(
        context: addressController.context,
        builder: (_) => AlertDialog(
              title: GetBuilder<AddressController>(
                  init: AddressController(),
                  builder: (contet) {
                    return Column(children: [
                      Text(
                        LocaleKeys.wantToDelete.tr,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ]);
                  }),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.no.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    addressController.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    addressController.pop();
                    addressController.removeAddress(address.id, language);
                  },
                ),
              ],
            ));
  }
}
