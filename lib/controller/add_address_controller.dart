import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/city_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class AddAddressController extends GetxController {
  late BuildContext context;

  TextEditingController countrySearchController = TextEditingController();
  TextEditingController stateSearchController = TextEditingController();
  TextEditingController citySearchController = TextEditingController();

  int userId = 0;
  int loginLogId = 0;
  String token = '';
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  TextEditingController deliveryInstructionController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final List<String> countryNames = [];

  late List<Country> countries = [];
  Country? countryValue;

  String currentCountry = "", currentState = "", currentCity = "";

  late List<States> states = [];
  States? stateValue;

  late List<City> cities = [];
  City? cityValue;

  late List<AddressTypeModel> addressTypes;
  AddressTypeModel? addressTypeValue;

  bool isDefault = false;
  final api = Api();
  bool loading = false;
  Address? address;

  @override
  void onInit([Address? address]) {
    addressTypes = <AddressTypeModel>[
      AddressTypeModel(
        id: '1',
        name: LocaleKeys.personalAddress.tr,
      ),
      AddressTypeModel(
        id: '2',
        name: LocaleKeys.officeAddress.tr,
      ),
    ];
    this.address = address;
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    var language = Get.locale!.languageCode;
    getCountry(language);
    if (address != null) {
      for (var i = 0; i < addressTypes.length; i++) {
        if (addressTypes[i].id == address.addressType) {
          addressTypeValue = addressTypes[i];
          break;
        }
      }
      fullNameController.text = address.fullname!;
      mobileNumberController.text = address.mobile1!;
      pincodeController.text = address.zip!;
      houseNoController.text = address.address1!;
      areaStreetController.text = address.address2!;
      landmarkController.text = address.landmark!;
      address.defaultAddress == 1 ? isDefault = true : isDefault = false;
      deliveryInstructionController.text = address.deliveryInstruction != null
          ? address.deliveryInstruction!
          : '';
    }
    super.onInit();
  }

  Future<void> getCountry(language) async {
    await api.getCountries(language).then((value) {
      countries = value.data!.country!;
      for (var i = 0; i < value.data!.country!.length; i++) {
        countryNames.add(value.data!.country![i].countryName!);
        if (address != null) if (value.data!.country![i].countryName ==
                address!.countryName &&
            value.data!.country![i].countryCode == address!.countryCode) {
          countryValue = value.data!.country![i];
          countrySearchController.text = countryValue!.countryName!;
          stateSearchController.clear();
          getState(value.data!.country![i].countryCode, language);
          break;
        }
        if (currentCountry.isNotEmpty) if (countries[i]
                .countryName!
                .toLowerCase() ==
            currentCountry.toLowerCase()) {
          countryValue = countries[i];
          countrySearchController.text = countries[i].countryName!;
          stateSearchController.clear();
          getState(value.data!.country![i].countryCode, language);
          break;
        }
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
    });
  }

  Future<void> getState(countryCode, language) async {
    await api.getStates(countryCode, language).then((value) {
      states = value.data!.state!;

      for (var i = 0; i < value.data!.state!.length; i++) {
        if (address != null) if (value.data!.state![i].stateName ==
                address!.stateName &&
            value.data!.state![i].stateCode == address!.stateCode &&
            value.data!.state![i].countryCode == address!.countryCode) {
          stateValue = value.data!.state![i];
          stateSearchController.text = stateValue!.stateName!;
          citySearchController.clear();
          getCity(value.data!.state![i].countryCode,
              value.data!.state![i].stateCode, language);
          break;
        }
        if (currentState.isNotEmpty) if (states[i].stateName!.toLowerCase() ==
            currentState.toLowerCase()) {
          stateValue = states[i];
          stateSearchController.text = states[i].stateName!;
          citySearchController.clear();
          getCity(value.data!.state![i].countryCode,
              value.data!.state![i].stateCode, language);
          break;
        }
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
    });
  }

  Future<void> getCity(countryCode, stateCode, language) async {
    print('city.....$countryCode.....$stateCode');
    await api.getCity(countryCode, stateCode, language).then((value) {
      cities = value.data!.city!;
      for (var i = 0; i < value.data!.city!.length; i++) {
        if (address != null) if (value.data!.city![i].cityName ==
                address!.cityName &&
            value.data!.city![i].cityCode == address!.cityCode &&
            value.data!.city![i].stateCode == address!.stateCode &&
            value.data!.city![i].countryCode == address!.countryCode) {
          cityValue = value.data!.city![i];
          citySearchController.text = cityValue!.cityName!;
          break;
        }
        if (currentCity.isNotEmpty) if (cities[i].cityName!.toLowerCase() ==
            currentCity.toLowerCase()) {
          cityValue = cities[i];
          citySearchController.text = cities[i].cityName!;
          break;
        }
      }
      update();
    }).catchError((error) {
      update();
      print('error....$error');
    });
  }

  get defaultValue => isDefault ? 1 : 0;

  Future<void> addAddress(language) async {
    // if (Helper.isIndividual) {
    print('gdhgdhgh.......');
    if (countryValue == null) {
      Helper.showGetSnackBar('Please Select Country', AppColors.errorColor);
    } else if (formKey.currentState!.validate()) {
      if (stateValue == null) {
        Helper.showGetSnackBar('Please Select State', AppColors.errorColor);
      } else if (cityValue == null) {
        Helper.showGetSnackBar('Please Select City', AppColors.errorColor);
      } else if (addressTypeValue == null) {
        Helper.showGetSnackBar(
            'Please Select Address Type', AppColors.errorColor);
      } else {
        //loading = true;
        Helper.showLoading();
        // update();
        await api
            .addCustomerAddress(
                token,
                userId,
                fullNameController.text,
                houseNoController.text,
                areaStreetController.text,
                landmarkController.text,
                countryValue!.countryCode,
                stateValue!.stateCode,
                cityValue!.cityCode,
                pincodeController.text,
                mobileNumberController.text,
                addressTypeValue!.id,
                deliveryInstructionController.text,
                defaultValue,
                language)
            .then((value) {
          if (value.statusCode == 200) {
            Helper.hideLoading(context);
            Get.delete<AddAddressController>();
            Navigator.of(context).pop(true);
            Helper.showGetSnackBar(value.message!, AppColors.successColor);
          } else if (value.statusCode == 401) {
            Helper.hideLoading(context);
            MySharedPreferences.instance
                .addBoolToSF(SharedPreferencesKeys.isLogin, false);
            Get.deleteAll();
            Get.offAll(DrawerScreen());
          } else {
            Helper.showGetSnackBar(value.message!, AppColors.errorColor);
          }
          update();
        }).catchError((error) {
          Helper.hideLoading(context);
          update();
          print('error....$error');
        });
      }
    }
    // }
  }

  Future<void> editAddress(id, language) async {
    // if (Helper.isIndividual) {

    if (countryValue == null) {
      Helper.showGetSnackBar('Please Select Country', AppColors.errorColor);
    } else if (formKey.currentState!.validate()) {
      if (stateValue == null) {
        Helper.showGetSnackBar('Please Select State', AppColors.errorColor);
      } else if (cityValue == null) {
        Helper.showGetSnackBar('Please Select City', AppColors.errorColor);
      } else if (addressTypeValue == null) {
        Helper.showGetSnackBar(
            'Please Select Address Type', AppColors.errorColor);
      } else {
        print(
            '........${countryValue!.countryCode}...${stateValue!.stateCode}.....${cityValue!.cityCode}');
        Helper.showLoading();
        await api
            .editCustomerAddress(
                token,
                id,
                userId,
                fullNameController.text,
                houseNoController.text,
                areaStreetController.text,
                landmarkController.text,
                countryValue!.countryCode,
                stateValue!.stateCode,
                cityValue!.cityCode,
                pincodeController.text,
                mobileNumberController.text,
                addressTypeValue!.id,
                deliveryInstructionController.text,
                defaultValue,
                language)
            .then((value) {
          if (value.statusCode == 200) {
            Helper.hideLoading(context);
            Helper.showGetSnackBar(value.message!, AppColors.successColor);
            Get.delete<AddAddressController>();
            Navigator.of(context).pop(true);
          } else if (value.statusCode == 401) {
            Helper.hideLoading(context);
            MySharedPreferences.instance
                .addBoolToSF(SharedPreferencesKeys.isLogin, false);
            Get.deleteAll();
            Get.offAll(DrawerScreen());
          } else {
            Helper.hideLoading(context);
            Helper.showGetSnackBar(value.message!, AppColors.errorColor);
          }
          update();
        }).catchError((error) {
          Helper.hideLoading(context);
          update();
          print('error....$error');
        });
      }
    }
    // }
  }

  void updateCountry(Country? value, String language) {
    countryValue = value!;
    states = [];
    stateValue = null;
    update();
    countrySearchController.text = value.countryName!;
    stateSearchController.clear();
    citySearchController.clear();
    getState(value.countryCode, language);
    update();
  }

  void updateState(States? value, String language) {
    stateValue = value!;
    cities = [];
    cityValue = null;
    update();
    stateSearchController.text = value.stateName!;
    citySearchController.clear();
    getCity(value.countryCode, value.stateCode, language);
    update();
  }

  void updateCity(City? value) {
    cityValue = value!;
    citySearchController.text = value.cityName!;
    update();
  }

  void updateAddressType(AddressTypeModel? value) {
    addressTypeValue = value!;
    update();
  }

  void updateDefaultCheckBox() {
    isDefault = !isDefault;
    update();
  }

  void exitScreen() {
    Get.delete<AddAddressController>();
    Navigator.of(context).pop(false);
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
