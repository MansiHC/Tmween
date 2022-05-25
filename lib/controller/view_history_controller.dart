import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../model/get_wallet_model.dart';
import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class ViewHistoryController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  TextEditingController amountController = TextEditingController();
  String fromDate = "", toDate = "", fromApiDate = "", toApiDate = "",paymentStatus="",transactionType="";
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  final formKey = GlobalKey<FormState>();

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  selectFromDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != selectedFromDate) {
      selectedFromDate = selected;
      fromDate =
          '${selectedFromDate.day} ${months[selectedFromDate.month - 1]} ${selectedFromDate.year}';
      fromApiDate =
          '${selectedFromDate.year}-${selectedFromDate.month}-${selectedFromDate.day}';
    }
    update();
  }

  selectToDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: selectedFromDate,
      lastDate: DateTime(2100),
    );
    if (selected != null && selected != selectedToDate) {
      selectedToDate = selected;
      toDate =
          '${selectedToDate.day} ${months[selectedToDate.month - 1]} ${selectedToDate.year}';
      toApiDate =
      '${selectedToDate.year}-${selectedToDate.month}-${selectedToDate.day}';

    }
    update();
  }

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
        getWalletHistoryData(Get.locale!.languageCode);

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
  WalletData? walletData = null;

  Future<void> getWalletHistoryData(language) async {
    print('.$paymentStatus...$transactionType...$fromApiDate..$toApiDate.');
    Helper.showLoading();
    await api.getWalletHistoryData(token, userId,paymentStatus,transactionType,fromApiDate,toApiDate, language).then((value) {
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
      }

      update();
    }).catchError((error) {
      Helper.hideLoading(context);
      update();
      print('error....$error');
    });
  }

  void exitScreen() {
    Get.delete<ViewHistoryController>();
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
