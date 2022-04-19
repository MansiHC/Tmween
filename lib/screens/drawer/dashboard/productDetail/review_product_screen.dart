import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/review_product_controller.dart';
import 'package:tmween/model/product_detail_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/circular_progress_bar.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../../utils/views/custom_text_form_field.dart';

class ReviewProductScreen extends StatefulWidget {
  final ProductData? product;

  ReviewProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReviewProductScreenState();
  }
}

class ReviewProductScreenState extends State<ReviewProductScreen> {
  late String language;

  final reviewProductController = Get.put(ReviewProductController());

  @override
  void initState() {
    reviewProductController.productId = widget.product!.id!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ReviewProductController>(
        init: ReviewProductController(),
        builder: (contet) {
          reviewProductController.context = context;
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
                          child: topView(reviewProductController)),
                      _bottomView(reviewProductController),
                    ],
                  )));
        });
  }

  Widget _bottomView(ReviewProductController reviewProductController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  children: [
                    20.heightBox,
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            width: 120,
                            height: 100,
                            child: widget.product!.largeImageUrl!
                                .setNetworkImage())),
                    20.heightBox,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.product!.productName!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF596067),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    50.heightBox,
                    Text(
                      'Rate the Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF363D49),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    5.heightBox,
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'How did you find the product based on your usage?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF596067),
                            fontSize: 13,
                          ),
                        )),
                    20.heightBox,
                    Container(
                        width: 260,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _emojiView(reviewProductController,
                                ImageConstanst.star1MoodIcon, 1),
                            _emojiView(reviewProductController,
                                ImageConstanst.star2MoodIcon, 2),
                            _emojiView(reviewProductController,
                                ImageConstanst.star3MoodIcon, 3),
                            _emojiView(reviewProductController,
                                ImageConstanst.star4MoodIcon, 4),
                            _emojiView(reviewProductController,
                                ImageConstanst.star5MoodIcon, 5),
                          ],
                        )),
                    5.heightBox,
                    Container(
                        width: 240,
                        child: RatingBar.builder(
                          initialRating: reviewProductController.currentRating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: Color(0xFFDDDDDD),
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color(0xFFFEBD06),
                          ),
                          onRatingUpdate: (rating) {
                            reviewProductController.currentRating = rating;
                            reviewProductController.update();
                          },
                        )),
                    Visibility(
                        visible: reviewProductController.loading,
                        child: CircularProgressBar()),
                    30.heightBox,
                    Text(
                      'Leave a comment',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF363D49),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    20.heightBox,
                    CustomBoxTextFormField(
                        maxLines: 5,
                        borderColor: Color(0xFFB3B3B3),
                        filled: true,
                        fillColor: Color(0xFFF1F1F1),
                        controller: reviewProductController.commentController,
                        keyboardType: TextInputType.text,
                        hintText: 'Write any comments',
                        validator: (value) {}),
                    10.heightBox,
                    CustomButton(
                      text: 'Submit',
                      onPressed: () {
                        reviewProductController.rateProduct(language);
                      },
                      fontSize: 16,
                    ),
                    30.heightBox
                  ],
                ))));
  }

  _emojiView(ReviewProductController reviewProductController, String image,
      int number) {
    return Container(
        foregroundDecoration: number > reviewProductController.currentRating
            ? BoxDecoration(
                color: Color(0xFFFFE19B),
                backgroundBlendMode: BlendMode.saturation,
              )
            : BoxDecoration(),
        child: SvgPicture.asset(
          image,
          height: 34,
          width: 34,
        ));
  }

  Widget topView(ReviewProductController reviewProductController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    reviewProductController.exitScreen();
                  },
                  child: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 42,
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Review Product',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
