import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';

import '../screens/authentication/login/login_screen.dart';
import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class AddAddressController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController townCityController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late List<CountryModel> countries;
   CountryModel? countryValue;

   late List<StateModel> states;
   StateModel? stateValue;

   late List<AddressTypeModel> addressTypes;
  AddressTypeModel? addressTypeValue;

  bool isDefault = false;
  bool isAddressOpened = false;

  @override
  void onInit() {
    countries = <CountryModel>[
      CountryModel(name: 'India',),
      CountryModel(name: 'Sudan',),
    ];
    states = <StateModel>[
      StateModel(name: 'Gujarat',),
      StateModel(name: 'Ahmedabad',),
    ];
    addressTypes = <AddressTypeModel>[
      AddressTypeModel(name: LocaleKeys.personalAddress,),
      AddressTypeModel(name: LocaleKeys.officeAddress,),
    ];
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
    super.onInit();
  }

void updateCountry(CountryModel? value){
  countryValue = value!;
  update();
}
void updateState(StateModel? value){
  stateValue = value!;
  update();
}
void updateAddressType(AddressTypeModel? value){
  addressTypeValue = value!;
  update();
}

  void updateDefaultCheckBox() {
    isDefault = !isDefault;
    update();
  }

  void exitScreen() {
    Navigator.of(context).pop();
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
