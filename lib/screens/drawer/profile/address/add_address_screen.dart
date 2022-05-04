import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../../controller/add_address_controller.dart';
import '../../../../model/city_model.dart';
import '../../../../utils/views/circular_progress_bar.dart';
import '../../../../utils/views/custom_text_form_field.dart';

class AddAddressScreen extends StatelessWidget {
  late String language;

  final Address? address;

  AddAddressScreen({Key? key, this.address}) : super(key: key);

  final addressController = Get.put(AddAddressController());

  Future<bool> _onWillPop(AddAddressController addressController) async {
    addressController.exitScreen();
    return true;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String location = 'Null, Press Button';
  String addressData = 'search';

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    addressData =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    addressController.areaStreetController.text = place.street!;
    addressController.pincodeController.text = place.postalCode!;
    addressController.currentCountry = place.country!;
    addressController.currentState = place.administrativeArea!;
    addressController.currentCity = place.subAdministrativeArea!;

    for (var i = 0; i < addressController.countries.length; i++) {
      if (addressController.countries[i].countryName!.toLowerCase() ==
          addressController.currentCountry.toLowerCase()) {
        addressController.countryValue = addressController.countries[i];
        addressController.countrySearchController.text =
            addressController.countries[i].countryName!;
        addressController.getState(
            addressController.countries[i].countryCode, language);
        for (var i = 0; i < addressController.states.length; i++) {
          if (addressController.states[i].stateName!.toLowerCase() ==
              addressController.currentState.toLowerCase()) {
            addressController.stateValue = addressController.states[i];
            addressController.stateSearchController.text =
                addressController.states[i].stateName!;
            addressController.getCity(addressController.states[i].countryCode,
                addressController.states[i].stateCode, language);
            for (var i = 0; i < addressController.cities.length; i++) {
              if (addressController.cities[i].cityName!.toLowerCase() ==
                  addressController.currentCity.toLowerCase()) {
                addressController.cityValue = addressController.cities[i];
                addressController.citySearchController.text =
                    addressController.cities[i].cityName!;
                break;
              }
            }
            break;
          }
        }
        break;
      }
    }
    addressController.update();
  }

  getAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    addressController.onInit(address);
    return GetBuilder<AddAddressController>(
        init: AddAddressController(),
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
                          _bottomView(addressController)
                        ],
                      ))));
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
                        CustomButton(
                            text: LocaleKeys.useCurrentLocation.tr,
                            fontSize: 16,
                            onPressed: () {
                              getAddress();
                            }),
                        10.heightBox,
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.or.tr,
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            )),
                        10.heightBox,
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)),
                            height: 40,
                            child: TypeAheadFormField<Country>(
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                controller:
                                    addressController.countrySearchController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  FocusScope.of(addressController.context)
                                      .unfocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  isDense: true,
                                  hintText: LocaleKeys.selectCountry.tr,
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black45,
                                      )),
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return addressController.countries
                                    .where((item) => item.countryName!
                                        .toLowerCase()
                                        .startsWith(pattern.toLowerCase()))
                                    .toList();
                              },
                              itemBuilder: (context, Country suggestion) {
                                return ListTile(
                                  title: Text(suggestion.countryName!),
                                );
                              },
                              onSuggestionSelected: (Country value) {
                                addressController.updateCountry(
                                    value, language);
                              },
                            )),
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
                            hintFontSize: 14,
                            controller: addressController.fullNameController,
                            keyboardType: TextInputType.name,
                            hintText: LocaleKeys.enterFullName.tr,
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.userIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.emptyFullName.tr;
                              }
                              return null;
                            }),
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
                            hintFontSize: 14,
                            controller:
                                addressController.mobileNumberController,
                            keyboardType: TextInputType.phone,
                            hintText: LocaleKeys.enterMobileNumber.tr,
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.phoneCallIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.emptyMobileNumber.tr;
                              }
                              return null;
                            }),
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
                            hintFontSize: 14,
                            controller: addressController.pincodeController,
                            keyboardType: TextInputType.number,
                            hintText: LocaleKeys.enterPinCode.tr,
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.worldIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.emptyPinCode.tr;
                              }
                              return null;
                            }),
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
                            hintFontSize: 14,
                            controller: addressController.houseNoController,
                            keyboardType: TextInputType.text,
                            hintText: '${LocaleKeys.enter.tr} ${LocaleKeys.houseNo.tr}',
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.homeIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '${LocaleKeys.emptyEnter.tr} ${LocaleKeys.houseNo.tr}';
                              }
                              return null;
                            }),
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
                            hintFontSize: 14,
                            controller: addressController.areaStreetController,
                            keyboardType: TextInputType.text,
                            hintText: '${LocaleKeys.enter.tr} ${LocaleKeys.areaStreet.tr}',
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.homeIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '${LocaleKeys.emptyEnter.tr} ${LocaleKeys.areaStreet.tr}';
                              }
                              return null;
                            }),
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
                            hintFontSize: 14,
                            controller: addressController.landmarkController,
                            keyboardType: TextInputType.text,
                            hintText: '${LocaleKeys.enter.tr} ${LocaleKeys.landmark.tr}',
                            prefixIcon: SvgPicture.asset(
                              ImageConstanst.pinIcon,
                              color: AppColors.primaryColor,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '${LocaleKeys.emptyEnter.tr} ${LocaleKeys.landmark.tr}';
                              }
                              return null;
                            }),
                        10.heightBox,
                        Text(
                          LocaleKeys.state.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)),
                            height: 40,
                            child: TypeAheadFormField<States>(
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                controller:
                                    addressController.stateSearchController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  FocusScope.of(addressController.context)
                                      .unfocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  isDense: true,
                                  hintText: LocaleKeys.chooseState.tr,
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black45,
                                      )),
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return addressController.states
                                    .where((item) => item.stateName!
                                        .toLowerCase()
                                        .startsWith(pattern.toLowerCase()))
                                    .toList();
                              },
                              itemBuilder: (context, States suggestion) {
                                return ListTile(
                                  title: Text(suggestion.stateName!),
                                );
                              },
                              onSuggestionSelected: (States value) {
                                addressController.updateState(value, language);
                              },
                            )),
                        10.heightBox,
                        Text(
                          LocaleKeys.townCity.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF383838),
                              fontSize: 14),
                        ),
                        5.heightBox,
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Color(0xFFA7A7A7),
                                ),
                                color: Color(0xFFEEEEEE)),
                            height: 40,
                            child: TypeAheadFormField<City>(
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                controller:
                                    addressController.citySearchController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  FocusScope.of(addressController.context)
                                      .unfocus();
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.lightGrayColor),
                                  ),
                                  isDense: true,
                                  hintText: 'Choose a City',
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black45,
                                      )),
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return addressController.cities
                                    .where((item) => item.cityName!
                                        .toLowerCase()
                                        .startsWith(pattern.toLowerCase()))
                                    .toList();
                              },
                              itemBuilder: (context, City suggestion) {
                                return ListTile(
                                  title: Text(suggestion.cityName!),
                                );
                              },
                              onSuggestionSelected: (City value) {
                                addressController.updateCity(value);
                              },
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () =>
                                addressController.updateDefaultCheckBox(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Theme(
                                          data: Theme.of(
                                                  addressController.context)
                                              .copyWith(
                                            unselectedWidgetColor: Colors.grey,
                                          ),
                                          child: Checkbox(
                                              value:
                                                  addressController.isDefault,
                                              activeColor:
                                                  AppColors.primaryColor,
                                              onChanged: (value) {
                                                addressController
                                                    .updateDefaultCheckBox();
                                              }))),
                                  10.widthBox,
                                  Text(
                                    LocaleKeys.makeDefault.tr,
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF9C9C9C)),
                                  )
                                ])),
                        Text(
                          LocaleKeys.deliveryInstruction.tr,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF555555)),
                        ),
                        /*5.heightBox,
                        Text(
                          LocaleKeys.deliveryInstructionText.tr,
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF9C9C9C)),
                        ),*/
                        5.heightBox,
                        Stack(
                          children: [
                            CustomBoxTextFormField(
                                controller: addressController
                                    .deliveryInstructionController,
                                keyboardType: TextInputType.text,
                                hintText: '',
                                maxLines: 3,
                                prefixIcon: Container(),
                                validator: (value) {}),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    child: SvgPicture.asset(
                                      ImageConstanst.deliveryInstructionIcon,
                                      color: AppColors.primaryColor,
                                      width: 18,
                                      height: 18,
                                    )))
                          ],
                        ),
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
                                color: Color(0xFFEEEEEE)),
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
                            onTap: () {
                              addressController.isAddressOpened =
                                  !addressController.isAddressOpened;
                              addressController.update();
                            },
                            value: addressController.addressTypeValue,
                            onChanged: (value) {
                              var val = value as AddressTypeModel;
                              addressController.updateAddressType(val);
                            },
                            icon: addressController.isAddressOpened
                                ? Icon(
                                    Icons.keyboard_arrow_up_sharp,
                                    color: Colors.black45,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.black45,
                                  ),
                            iconSize: 24,
                            buttonHeight: 40,
                            buttonPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            offset: const Offset(0, 0),
                          ),
                        ),
                        30.heightBox,
                        CustomButton(
                            text: address == null
                                ? LocaleKeys.addNewAddress.tr
                                : LocaleKeys.updateAddress.tr,
                            fontSize: 16,
                            onPressed: () {
                              print('gdhgdhgh.......');
                              //    addressController.exitScreen();
                              if (address == null) {
                                addressController.addAddress(language);
                              } else {
                                addressController.editAddress(
                                    address!.id, language);
                              }
                            }),
                        Visibility(
                          visible: addressController.loading,
                          child: CircularProgressBar(),
                        ),
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
