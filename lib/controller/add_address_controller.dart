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

  late List<Country> countries = [];
  Country? countryValue;

  late List<States> states = [];
  States? stateValue;

  late List<City> cities = [];
  City? cityValue;

  late List<AddressTypeModel> addressTypes;
  AddressTypeModel? addressTypeValue;

  bool isDefault = false;
  bool isAddressOpened = false;
  final api = Api();
  bool loading = false;
  Address? address;


  @override
  void onInit([Address? address]) {
    /*countries = <CountryModel>[
      CountryModel(
        name: 'India',
      ),
      CountryModel(
        name: 'Sudan',
      ),
    ];
    states = <StateModel>[
      StateModel(
        name: 'Gujarat',
      ),
      StateModel(
        name: 'Ahmedabad',
      ),
    ];
    cities = <CityModel>[
      CityModel(
        name: 'Gujarat',
      ),
      CityModel(
        name: 'Ahmedabad',
      ),
    ];*/
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
    if(address!=null){
      /*countryValue = Country(countryCode: address.countryCode,countryName: address.countryName);
      stateValue = States(stateCode: address.stateCode,stateName: address.stateName,countryCode:  address.countryCode);
      cityValue = City(cityCode: address.cityCode,cityName: address.cityName,stateCode: address.stateCode,countryCode: address.countryCode);
      addressTypeValue = AddressTypeModel(name: address.addressType!);
*/
      for(var i=0;i<addressTypes.length;i++){
        if(addressTypes[i].id == address.addressType){
          addressTypeValue = addressTypes[i];
          break;
        }
      }
print('sdhddhs........${address.addressType}.....${address.defaultAddress}');
      fullNameController.text = address.fullname!;
      mobileNumberController.text = address.mobile1!;
      pincodeController.text = address.zip!;
      houseNoController.text = address.address1!;
      areaStreetController.text = address.address2!;
      landmarkController.text = address.landmark!;
      address.defaultAddress==1?isDefault=true:isDefault=false;
      deliveryInstructionController.text = address.deliveryInstruction!=null?address.deliveryInstruction!:'';

    }

    super.onInit();
  }

  Future<void> getCountry(language) async {

    await api.getCountries(language).then((value) {
      countries = value.data!.country!;
      for(var i=0;i<value.data!.country!.length;i++){
        if(value.data!.country![i].countryName== address!.countryName && value.data!.country![i].countryCode == address!.countryCode){
          countryValue = value.data!.country![i];
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

      for(var i=0;i<value.data!.state!.length;i++){
        if(value.data!.state![i].stateName== address!.stateName
            &&
            value.data!.state![i].stateCode== address!.stateCode
            &&
            value.data!.state![i].countryCode == address!.countryCode){
          stateValue = value.data!.state![i];
          getCity(value.data!.state![i].countryCode, value.data!.state![i].stateCode, language);
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
      for(var i=0;i<value.data!.city!.length;i++){
        if(value.data!.city![i].cityName== address!.cityName
            &&
            value.data!.city![i].cityCode== address!.cityCode
            &&
            value.data!.city![i].stateCode== address!.stateCode
            &&
            value.data!.city![i].countryCode == address!.countryCode){
          cityValue = value.data!.city![i];
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

    if(countryValue==null){
      Helper.showGetSnackBar('Please Select Country');
    }else
    if (formKey.currentState!.validate()) {
      if(stateValue==null){
      Helper.showGetSnackBar('Please Select State');
    }else  if(cityValue==null){
      Helper.showGetSnackBar('Please Select City');
    }else  if(addressTypeValue==null){
      Helper.showGetSnackBar('Please Select Address Type');
    }else{
    loading = true;
    update();
    await api
        .addCustomerAddress(
            token,
            userId,
            '36',
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
      loading = false;
      update();
      if (value.statusCode == 200) {
        Get.delete<AddAddressController>();
        Navigator.of(context).pop(true);
      }
      Helper.showGetSnackBar(value.message!);
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });}}
  }
  Future<void> editAddress(id,language) async {

    if(countryValue==null){
      Helper.showGetSnackBar('Please Select Country');
    }else
    if (formKey.currentState!.validate()) {
      if(stateValue==null){
      Helper.showGetSnackBar('Please Select State');
    }else  if(cityValue==null){
      Helper.showGetSnackBar('Please Select City');
    }else  if(addressTypeValue==null){
      Helper.showGetSnackBar('Please Select Address Type');
    }else{
    loading = true;
    update();
    await api
        .editCustomerAddress(
            token,
            id,
            userId,
            '36',
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
      loading = false;
      update();
      if (value.statusCode == 200) {
        Get.delete<AddAddressController>();
        Navigator.of(context).pop(true);
      }
      Helper.showGetSnackBar(value.message!);
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });}}
  }


  void updateCountry(Country? value, String language) {
    countryValue = value!;
    states = [];
    stateValue=null;
    update();
    getState(value.countryCode, language);
update();
  }

  void updateState(States? value, String language) {
    stateValue = value!;
    cities = [];
    cityValue=null;
    update();
    getCity(value.countryCode, value.stateCode, language);
    update();
  }

  void updateCity(City? value) {
    cityValue = value!;
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
