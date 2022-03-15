import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/add_address_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class AddressController extends GetxController {
  late BuildContext context;

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaStreetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController townCityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final api = Api();
  bool loading = false;
    List<Address> addressList=[];

  @override
  void onInit() {

    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
          token = value!;
          print('dhsh.....$token');
     MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      getAddressList(Get.locale!.languageCode);
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value!;
      });
    });
    });

    super.onInit();
  }

  Future<void> getAddressList(language) async {
    addressList = [];
    loading = true;
    update();
    await api
        .getCustomerAddressList(token, userId,'36', language)
        .then((value) {
      if (value.statusCode == 200) {
        loading = false;

        addressList = value.data!;
            update();
      } else {
        Helper.showGetSnackBar( value.message!);
      }
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }

  Future<void> removeAddress(id,language) async {


    loading = true;
    update();
    await api
        .deleteCustomerAddress(
        token,
        id,
        userId,
        '36',
        language)
        .then((value) {
      loading = false;
      update();
      if (value.statusCode == 200) {
        getAddressList(Get.locale!.languageCode);
      }
      Helper.showGetSnackBar(value.message!);
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }



  void exitScreen() {
    Get.delete<AddressController>();
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

  void navigateToAddAddressScreen( [Address? address]) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(address:address)))
    .then((value) {if(value) {
        getAddressList(Get.locale!.languageCode);
      }
    });
  }
}
