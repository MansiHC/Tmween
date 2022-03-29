import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/address_list_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../utils/views/circular_progress_bar.dart';

class YourAddressesScreen extends StatelessWidget {
  late String language;
  final addressController = Get.put(AddressController());

  Future<bool> _onWillPop(AddressController addressController) async {
    addressController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (contet) {
          addressController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(addressController),
              child: Scaffold(
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
                          5.heightBox,
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: CustomButton(
                                  fontSize: 17,
                                  text: LocaleKeys.addNewAddress,
                                  onPressed: () {
                                    addressController
                                        .navigateToAddAddressScreen();
                                  })),
                          Visibility(
                            visible: addressController.loading,
                            child: CircularProgressBar(),
                          ),
                          Visibility(
                            visible: !addressController.loading &&
                                addressController.addressList.length == 0,
                            child: Expanded(
                              child: Center(
                                  child: Text(
                                'No Records',
                                style: TextStyle(
                                    color: Color(0xFF414141),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          Visibility(
                              visible: !addressController.loading &&
                                  addressController.addressList.length > 0,
                              child: Expanded(
                                  child: RefreshIndicator(
                                      onRefresh: () =>
                                          addressController.onRefresh(language)
                                      ,
                                      child:Container(
                                      padding: EdgeInsets.all(
                                        15,
                                      ),
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: addressController
                                              .addressList.length,
                                          itemBuilder: (context, index) {
                                            return AddressListContainer(
                                              address: addressController
                                                  .addressList[index],
                                              index: index,
                                            );
                                          }))))),
                        ],
                      ))));
        });
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
