import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tmween/model/get_reviews_model.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';

import '../service/api.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/my_shared_preferences.dart';

class AllReviewController extends GetxController {
  late BuildContext context;

  final formKey = GlobalKey<FormState>();

  TextEditingController commentController = TextEditingController();

  double currentRating = 0;
  double averageRating = 0;
  double averageRating5 = 0;
  double averageRating4 = 0;
  double averageRating3 = 0;
  double averageRating2 = 0;
  double averageRating1 = 0;
  double percent1 = 0;
  double percent2 = 0;
  double percent3 = 0;
  double percent4 = 0;
  double percent5 = 0;



  bool isCreditChecked = false;

  List<String> walletActivitys = const <String>[
    'December 2021',
    'November 2021',
    'October 2021'
  ];

  int userId = 0;
  String token = '';
  int loginLogId = 0;
  int productId=0;
  final api = Api();
  bool loading = false;
  List<ReviewProductData> reviewsList = [];

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
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.onInit();
  }

  Future<void> getAllReviews(language) async {
    loading = true;
    update();
    await api.getProductReviewsList(productId,language).then((value) {
      if (value.statusCode == 200) {
        reviewsList =  value.data!.reviewProductData!;
        List<double> ratings = reviewsList.map((e) => e.rating!).toList();
        List<double> ratings1 = reviewsList.map((e) => e.rating!).where((element) => element==0.5 || element==1 || element==1.5).toList();
        List<double> ratings2 = reviewsList.map((e) => e.rating!).where((element) => element==2 || element==2.5).toList();
        List<double> ratings3 = reviewsList.map((e) => e.rating!).where((element) => element==3 || element==3.5).toList();
        List<double> ratings4 = reviewsList.map((e) => e.rating!).where((element) => element==4 || element==4.5).toList();
        List<double> ratings5 = reviewsList.map((e) => e.rating!).where((element) => element==5).toList();
       print('object.....${ratings4.length}');
        double sum = ratings.fold(0, (p, c) => p + c);
        double sum1 = ratings1.fold(0, (p, c) => p + c);
        double sum2 = ratings2.fold(0, (p, c) => p + c);
        double sum3 = ratings3.fold(0, (p, c) => p + c);
        double sum4 = ratings4.fold(0, (p, c) => p + c);
        double sum5 = ratings5.fold(0, (p, c) => p + c);
        if (sum > 0) {
           averageRating = sum / ratings.length;
           currentRating = averageRating;
        }if (sum1 > 0) {
           averageRating1 = sum1 / ratings.length;
           averageRating1 = averageRating1/5;
           percent1 = averageRating1*100;
        }if (sum2 > 0) {
           averageRating2 = sum2 / ratings.length;
           averageRating2 = averageRating2/5;
           percent2 = averageRating2*100;
        }if (sum3 > 0) {
           averageRating3 = sum3 / ratings.length;
           averageRating3 = averageRating3/5;
           percent3 = averageRating3*100;
        }if (sum4 > 0) {
           averageRating4 = sum4 / ratings.length;
           averageRating4 = averageRating4/5;
           percent4 = averageRating4*100;
        }if (sum5 > 0) {
           averageRating5 = sum5 / ratings.length;
           averageRating5 = averageRating5/5;
           percent5 = averageRating5*100;

        }
      } else if (value.statusCode == 401) {
        MySharedPreferences.instance
            .addBoolToSF(SharedPreferencesKeys.isLogin, false);
        Get.deleteAll();
        Get.offAll(DrawerScreen());
      }
      loading = false;
      update();
    }).catchError((error) {
      loading = false;
      update();
      print('error....$error');
    });
  }


  void exitScreen() {
    Get.delete<AllReviewController>();
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
