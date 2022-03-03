import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/full_image_controller.dart';

class FullImageScreen extends StatelessWidget {
  late String language;
  final fullImageController = Get.put(FullImageController());

  FullImageScreen({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<FullImageController>(
        init: FullImageController(),
        builder: (contet) {
          fullImageController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(fullImageController)),
                      _bottomView(fullImageController),
                    ],
                  )));
        });
  }

  Widget _bottomView(FullImageController fullImageController) {
    return Expanded(
        child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: EdgeInsets.all(15),
            child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.1,
                maxScale: 4,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ))));
  }

  Widget topView(FullImageController fullImageController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Material(
                color: Colors.white, // Button color
                child: InkWell(
                  onTap: () {
                    fullImageController.exitScreen();
                  },
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.keyboard_arrow_left_sharp,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
