import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FullImageController extends GetxController {
  late BuildContext context;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late bool visibleList = false;

  int current = 0;
  int image = 0;
  final CarouselController controller = CarouselController();

  void changPage(int index) {
    current = index;
    update();
  }

  final List<String> items = ['Sofa', 'Bed'];

  late final List<Widget> imageSliders = imgList
      .map((item) => Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.1,
            maxScale: 4,
            child: Image.asset(item, fit: BoxFit.contain),
          )))
      .toList();

  final List<String> imgList = [
    'asset/image/product_detail_page_images/slider_thumb_1.jpg',
    'asset/image/product_detail_page_images/slider_thumb_2.jpg',
    'asset/image/product_detail_page_images/slider_thumb_3.jpg',
    'asset/image/product_detail_page_images/slider_thumb_4.jpg',
    'asset/image/product_detail_page_images/slider_thumb_5.jpg',
  ];

  @override
  void onInit() {
    super.onInit();
  }

  void navigateTo(Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }

  void closeDrawer() {
    Navigator.pop(context);
  }

  void exitScreen() {
    Navigator.of(context).pop();
  }

  void pop() {
    Navigator.of(context).pop(false);
    update();
  }

  void exit() {
    SystemNavigator.pop();
    update();
  }
}
