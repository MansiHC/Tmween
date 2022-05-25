import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/wallet_history_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/get_wallet_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class MyWalletController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  TextEditingController amountController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  List<WalletTransactions> walletHistoryList = [];
  final List<String> amounts = [
    '200',
    '500',
    '1000',
    '2000',
  ];
  String token = '';

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
        getWalletData(Get.locale!.languageCode);

        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  final api = Api();
  bool loading = false;
  WalletData? walletData=null;

  Future<void> getWalletData(language) async {

    Helper.showLoading();
    await api.getWalletData(token, userId, language).then((value) {
      if (value.statusCode == 200) {
        Helper.hideLoading(context);
        walletData = value.data;
        walletHistoryList = value.data!.walletTransactions!;

      } else if (value.statusCode == 401) {
        Helper.hideLoading(context);
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }else{
        walletData = value.data;
        Helper.hideLoading(context);
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }


  void exitScreen() {
    Get.delete<MyWalletController>();
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
