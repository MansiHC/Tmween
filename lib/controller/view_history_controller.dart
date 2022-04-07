import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/wallet_history_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

class ViewHistoryController extends GetxController {
  late BuildContext context;

  int userId = 0;
  int loginLogId = 0;
  TextEditingController amountController = TextEditingController();
  String fromDate = "",toDate="";
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  final formKey = GlobalKey<FormState>();

  List<String> walletActivitys = const <String>[
    'December 2021',
    'November 2021',
    'October 2021'
  ];

  List months =
  ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  selectFromDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedFromDate) {
      selectedFromDate = selected;
      fromDate= '${selectedFromDate.day} ${months[selectedFromDate.month-1]} ${selectedFromDate.year}';
    }
    update();
  }

  selectToDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedToDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedToDate) {
      selectedToDate = selected;
      toDate= '${selectedToDate.day} ${months[selectedToDate.month-1]} ${selectedToDate.year}';

    }
    update();
  }


  List<WalletHistoryModel> walletHistoryList = const <WalletHistoryModel>[
    WalletHistoryModel(title: 'December 2021',historyItemList:[HistoryItem(title: 'Added to Wallet', date: '10 Nov, 9:05 AM', isSuccess: true, successText: 'Received in Wallet'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Paid from Waller'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Failed'),
    ] ),
    WalletHistoryModel(title:'November 2021',historyItemList: [
      HistoryItem(title: 'Added to Wallet', date: '10 Nov, 9:05 AM', isSuccess: true, successText: 'Received in Wallet'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Paid from Waller'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Failed'),

    ]),
    WalletHistoryModel(title:'October 2021',historyItemList:
    [HistoryItem(title: 'Added to Wallet', date: '10 Nov, 9:05 AM', isSuccess: true, successText: 'Received in Wallet'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Paid from Waller'),
      HistoryItem(title: 'Paid for order', date: '10 Nov, 9:05 AM', isSuccess: false, successText: 'Failed'),
    ]),
  ];
  final List<String> amounts = [
    '200',
    '500',
    '1000',
    '2000',
  ];

  @override
  void onInit() {
    /* MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value!;
      });
    });*/

    super.onInit();
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