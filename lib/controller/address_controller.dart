import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../utils/global.dart';
import '../utils/my_shared_preferences.dart';

class AddressController extends GetxController {
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
  late CountryModel countryValue;

  @override
  void onInit() {
    countries = <CountryModel>[
      CountryModel(
        name: 'India',
      ),
      CountryModel(
        name: 'Sudan',
      ),
    ];
    countryValue = countries[0];
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

  void updateCountry(CountryModel? value) {
    countryValue = value!;
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
