import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_customer_address_list_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/profile/address/add_address_screen.dart';

import '../model/review_order_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class RadioModel {
   RadioModel(
      {required this.id,required this.currentId});

   List<int> id;
   int currentId;

  static fromJson(responseJson) {
    return null;
  }
}


class ReviewOrderController extends GetxController {
  late BuildContext context;

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  bool agree = false;
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
  List<int> radio1Value = [];
  List<RadioModel> radioValue = [];
  int countPersonalAddress = 0;
  int countOfficeAddress = 0;
  ReviewOrderData? reviewOrderData;
  CustomerAddressDetails? addressDetails;
  List<QuoteItemData>? quoteItemDetails;

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
        getReviewOrderData(Get.locale!.languageCode);

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

  void notifyCheckBox() {
    agree = !agree;
    update();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  Future<void> getReviewOrderData(language) async {
    countPersonalAddress = 0;
    countOfficeAddress = 0;
    addressList = [];
    Helper.showLoading();
    await api.getReviewOrder(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        reviewOrderData = value.data!;
        addressDetails = value.data!.cartDetail!.customerAddressDetails![0];
        quoteItemDetails= value.data!.quotesData!.quoteItemData!;
        if(quoteItemDetails!.length>0) {
          for (var i = 0; i < quoteItemDetails!.length; i++) {
            radio1Value.add(quoteItemDetails![i].id!);
            List<int> ids = [];
            ids.add(quoteItemDetails![i].id!+11);
            ids.add(quoteItemDetails![i].id!+12);
            radioValue.add(RadioModel(id: ids,currentId: quoteItemDetails![i].id!+11));
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

  Future<void> changeDeliverySpeed(quoteItemId,deliveryMode, language) async {
    Helper.showLoading();
    await api
        .changeDeliverySpeed(token, userId, quoteItemId,deliveryMode, language)
        .then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        Helper.showGetSnackBar(value.message!, AppColors.successColor);
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
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }


  void exitScreen() {
    Get.delete<ReviewOrderController>();
    Navigator.of(context).pop(true);
  }

  void pop() {
    Get.delete<ReviewOrderController>();
    Navigator.of(context).pop(false);
    //update();
  }

  void navigateToDashboardScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DrawerScreen()),
        (Route<dynamic> route) => false);
  }


}
