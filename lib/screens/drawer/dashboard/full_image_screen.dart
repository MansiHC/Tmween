import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/full_image_controller.dart';




class FullImageScreen extends StatefulWidget     {
  FullImageScreen({Key? key, required this.image}) : super(key: key);
  final int image;
  @override
  State<StatefulWidget> createState() {
   return FullImageScreenState();
  }

}
class FullImageScreenState extends State<FullImageScreen>     {
  late String   language;


  final fullImageController = Get.put(FullImageController());

  @override
  void initState() {
    fullImageController.current = widget.image;

    super.initState();
  }

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
        child: Stack(
          children: [
            Container(
                height: double.maxFinite,
                width: double.maxFinite,
                padding: EdgeInsets.all(15),
                child: CarouselSlider(

                      items: fullImageController
                          .imageSliders,
                      carouselController:
                      fullImageController.controller,
                      options: CarouselOptions(
                        height: MediaQuery.of(fullImageController.context).size.height,
                        autoPlay: false,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        aspectRatio: 1.6,
                        initialPage: fullImageController.current,
                        pageSnapping: true,
                        onPageChanged: (index, reason) {
                          fullImageController
                              .changPage(index);
                        },
                      ),
                    )),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: fullImageController.imgList
                      .asMap()
                      .entries
                      .map((entry) {
                    return  Container(
                        width: 8.0,
                        height: 2,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: fullImageController
                                .current ==
                                entry.key
                                ? AppColors.darkblue
                                : Colors.grey),
                      );
                  }).toList(),
                )),
          ],
        )/*Container(
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
                )))*/);
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
