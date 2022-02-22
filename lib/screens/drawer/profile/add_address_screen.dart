import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/add_address_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


class AddAddressScreen extends StatelessWidget {
  late String language;

  final addressController = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<AddAddressController>(
        init: AddAddressController(),
        builder: (contet) {
          addressController.context = context;
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
                          child: topView(addressController)),
                      _bottomView(addressController),
                    ],
                  )));
        });
  }

  Widget _bottomView(AddAddressController addressController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(
                  15,
                ),
                child: Form(
                    key: addressController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)
                            ),
                            isExpanded: true,
                            hint: Text(
                              LocaleKeys.selectCountry.tr,
                              style: TextStyle(fontSize: 14),
                            ),
                            items: addressController.countries
                                .map((item) =>
                                DropdownMenuItem<CountryModel>(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                .toList(),
                            value: addressController.countryValue,
                            onChanged: (value) {
                              var val = value as CountryModel;
                              addressController.updateCountry(val);
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                            buttonHeight: 40,
                            buttonPadding: const EdgeInsets.only(
                                left: 10, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            offset: const Offset(0, 0),
                          ),),
                        10.heightBox,
                        Text(
                          LocaleKeys.fullName.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.fullNameController,
                            keyboardType: TextInputType.name,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.mobileNumber.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller:
                            addressController.mobileNumberController,
                            keyboardType: TextInputType.phone,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.pincode.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.pincodeController,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.houseNo.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.houseNoController,
                            keyboardType: TextInputType.text,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.areaStreet.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.areaStreetController,
                            keyboardType: TextInputType.text,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.landmark.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.landmarkController,
                            keyboardType: TextInputType.text,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.townCity.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        CustomBoxTextFormField(
                            controller: addressController.townCityController,
                            keyboardType: TextInputType.text,
                            hintText: '',
                            validator: (value) {}),
                        10.heightBox,
                        Text(
                          LocaleKeys.state.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)
                            ),
                            isExpanded: true,
                            hint: Text(
                              LocaleKeys.chooseState.tr,
                              style: TextStyle(fontSize: 14),
                            ),
                            items: addressController.states
                                .map((item) =>
                                DropdownMenuItem<StateModel>(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                .toList(),
                            value: addressController.stateValue,
                            onChanged: (value) {
                              var val = value as StateModel;
                              addressController.updateState(val);
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                            buttonHeight: 40,
                            buttonPadding: const EdgeInsets.only(
                                left: 10, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            offset: const Offset(0, 0),
                          ),),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () =>
                                addressController.updateDefaultCheckBox(),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Theme(
                                          data: Theme.of(
                                              addressController.context)
                                              .copyWith(
                                            unselectedWidgetColor:
                                            Colors.grey,
                                          ),
                                          child: Checkbox(
                                              value:
                                              addressController
                                                  .isDefault,
                                              activeColor: AppColors
                                                  .primaryColor,
                                              onChanged: (value) {
                                                addressController
                                                    .updateDefaultCheckBox();
                                              }))),
                                  10.widthBox,
                                  Text(
                                    LocaleKeys.makeDefault.tr,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF9C9C9C)),
                                  )
                                ])),
                        Text(
                          LocaleKeys.deliveryInstruction.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF555555)),),
                        5.heightBox,
                        Text(
                          LocaleKeys.deliveryInstructionText.tr,
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9C9C9C)),),
                        10.heightBox,
                        Text(
                          LocaleKeys.addressType.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)
                            ),
                            isExpanded: true,
                            hint: Text(
                              LocaleKeys.selectAddressType.tr,
                              style: TextStyle(fontSize: 14),
                            ),
                            items: addressController.addressTypes
                                .map((item) =>
                                DropdownMenuItem<AddressTypeModel>(
                                  value: item,
                                  child: Text(
                                    item.name.tr,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                .toList(),
                            onTap: (){
                              addressController.isAddressOpened = !addressController.isAddressOpened;
                              addressController.update();
                            },
                            value: addressController.addressTypeValue,
                            onChanged: (value) {
                              var val = value as AddressTypeModel;
                              addressController.updateAddressType(val);
                            },
                            icon: addressController.isAddressOpened?
                            Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: Colors.black45,
                            )
                                : Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                            buttonHeight: 40,
                            buttonPadding: const EdgeInsets.only(
                                left: 10, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            offset: const Offset(0, 0),
                          ),),
                        30.heightBox,
                        CustomButton(text: LocaleKeys.addNewAddress.tr,fontSize: 16, onPressed: (){
                          addressController.exitScreen();
                        }),
                        30.heightBox,
                      ],
                    )))));
  }

  Widget topView(AddAddressController addressController) {
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
