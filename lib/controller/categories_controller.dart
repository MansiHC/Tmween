import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/dashboard_model.dart';
import '../model/select_category_model.dart';
import '../service/api.dart';
import '../utils/helper.dart';

class CategoriesController extends GetxController {
  late BuildContext context;

  TextEditingController searchController = TextEditingController();
  List<SelectCategoryModel> categories = const <SelectCategoryModel>[
    const SelectCategoryModel(
        title: 'Furniture',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_1.jpg'),
    const SelectCategoryModel(
        title: 'Watches',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_2.jpg'),
    const SelectCategoryModel(
        title: 'Sunglasses',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_3.jpg'),
    const SelectCategoryModel(
        title: 'Electronics',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_4.jpg'),
    const SelectCategoryModel(
        title: 'Sports, Fitness & Outdoor',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_5.jpg'),
    const SelectCategoryModel(
        title: 'Computers & Gaming',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_6.jpg'),
    const SelectCategoryModel(
        title: 'Belts',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_7.jpg'),
    const SelectCategoryModel(
        title: 'Wallets & Clutches',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_8.jpg'),
    const SelectCategoryModel(
        title: 'Jewelry',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_9.jpg'),
    const SelectCategoryModel(
        title: 'Beauty',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_10.jpg'),
    const SelectCategoryModel(
        title: 'Outdoor',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_11.jpg'),
    const SelectCategoryModel(
        title: 'Daily Needs',
        offer: '50',
        image: 'asset/image/category_home_page_images/category_img_12.jpg'),
  ];

  final api = Api();
  bool loading = false;
  List<ShopByCategory>? shopByCategory = [];

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    loading = true;
    update();
    await api.getAllCategories('en').then((value) {
      if (value.statusCode == 200) {
        shopByCategory = value.data!.productAllCategory;

        update();

      } else {
        Helper.showGetSnackBar(value.message!);
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
    Get.delete<CategoriesController>();
    Navigator.of(context).pop(false);
  }
}
