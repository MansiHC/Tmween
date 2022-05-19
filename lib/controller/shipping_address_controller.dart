import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/address/add_address_screen.dart';

import '../model/get_cart_products_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ShippingAddressController extends GetxController {
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
  List<int> radioValue = [];
  int radioCurrentValue = 1;
  int countPersonalAddress = 0;
  int countOfficeAddress = 0;
  CartDetails? cartData;
  List<RecommendationProducts>? recommendedProductsData;
  List<RecentlyViewedProducts>? recentlyViewedProducts;
  late double totalAmount;
  late double shippingAmount;
  late double taxAmount;

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

  Future<void> getCartProducts(language) async {
    cartData = null;
    await api.getCartItems(token, userId, language).then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        cartData = value.data!.cartDetails;

        recommendedProductsData = value.data!.recommendationProducts;
        recentlyViewedProducts = value.data!.recentlyViewedProducts;
        totalAmount = cartData!.totalPrice!.toPrecision(1);
        shippingAmount = cartData!.totalDeliveryPrice!.toPrecision(1);
        taxAmount = cartData!.totalTaxAmount!;
        for (var i = 0; i < addressList.length; i++) {
          if (addressList[i].id ==
              value.data!.cartDetails!.customerAddressDetails![0].id!) {
            radioCurrentValue = addressList[i].id!;
          }
        }
        update();
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        update();
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  Future<void> changeAddress(addressId, language) async {
    Helper.showLoading();
    cartData = null;
    await api
        .updateQuoteAddress(token, userId, addressId, language)
        .then((value) {
      Helper.hideLoading(context);
      if (value.statusCode == 200) {
        getAddressList(language);
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        update();
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  Future<void> getAddressList(language) async {
    countPersonalAddress = 0;
    countOfficeAddress = 0;
    addressList = [];
    radioValue = [];
    Helper.showLoading();
    await api.getCustomerAddressList(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        addressList = value.data!;
        if (addressList.length > 0) {
          radioCurrentValue = addressList[0].id!;
          for (var i = 0; i < addressList.length; i++) {
            radioValue.add(addressList[i].id!);
          }
        }
        getCartProducts(Get.locale!.languageCode);
      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      } else {
        Helper.hideLoading(context);
      }
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void exitScreen() {
    Get.delete<ShippingAddressController>();
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
        getCartProducts(Get.locale!.languageCode);
      }
    });
  }
}
