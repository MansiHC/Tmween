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
  List<Address> addressList = [];
  int countPersonalAddress = 0;
  int countOfficeAddress = 0;

  @override
  void onInit() {
    countPersonalAddress = 0;
    countOfficeAddress = 0;
    print('....${Get.locale!.languageCode}');
    // if (Helper.isIndividual) {
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
    // }
    super.onInit();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  Future<void> getAddressList(language) async {
    countPersonalAddress = 0;
    countOfficeAddress = 0;
    addressList = [];
    Helper.showLoading();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        addressList = value.data!;
        if (addressList.length > 0) {
          if (addressList[0].addressType == "1") {
            addressList.sort((a, b) {
              return int.parse(a.addressType!)
                  .compareTo(int.parse(b.addressType!));
            });
          } else {
            addressList
              ..sort((a, b) => int.parse(b.addressType!)
                  .compareTo(int.parse(a.addressType!)));
          }
        }
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> onRefresh(language) async {
    await api.getCustomerAddressList(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        addressList = value.data!;
        if (addressList.length > 0) {
          if (addressList[0].addressType == "1") {
            addressList.sort((a, b) {
              return int.parse(a.addressType!)
                  .compareTo(int.parse(b.addressType!));
            });
          } else {
            addressList
              ..sort((a, b) => int.parse(b.addressType!)
                  .compareTo(int.parse(a.addressType!)));
          }
        }
        update();
      }
    }).catchError((error) {
      print('error....$error');
    });
  }

  Future<void> removeAddress(id, language) async {
    //  if (Helper.isIndividual) {

    countPersonalAddress = 0;
    countOfficeAddress = 0;
    Helper.showLoading();
    await api.deleteCustomerAddress(token, id, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        getAddressList(Get.locale!.languageCode);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      Helper.showGetSnackBar(value.message!);

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
    //  }
  }

  void exitScreen() {
    Get.delete<AddressController>();
    Navigator.of(context).pop(true);
  }

  void pop() {
    countPersonalAddress = 0;
    countOfficeAddress = 0;
    Navigator.of(context).pop(false);
    update();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }

  void navigateToAddAddressScreen([Address? address]) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddAddressScreen(address: address)))
        .then((value) {
      if (value) {
        countPersonalAddress = 0;
        countOfficeAddress = 0;
        getAddressList(Get.locale!.languageCode);
      }
    });
  }
}
