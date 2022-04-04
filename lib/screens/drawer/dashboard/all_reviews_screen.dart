import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tmween/controller/all_review_controller.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/circular_progress_bar.dart';

import '../../../utils/views/expandable_text.dart';

class AllReviewScreen extends StatefulWidget {
  final int? productId;

  AllReviewScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AllReviewScreenState();
  }
}

class AllReviewScreenState extends State<AllReviewScreen> {
  late String language;

  final allReviewController = Get.put(AllReviewController());

  Future<bool> _onWillPop(AllReviewController allReviewController) async {
    allReviewController.exitScreen();
    return true;
  }

  @override
  void initState() {
    allReviewController.productId = widget.productId!;
    allReviewController.getAllReviews(Get.locale!.languageCode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<AllReviewController>(
        init: AllReviewController(),
        builder: (contet) {
          allReviewController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(allReviewController),
              child: Scaffold(
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
                              child: topView(allReviewController)),
                          allReviewController.loading &&
                                  allReviewController.reviewsList.length > 0
                              ? Expanded(child: CircularProgressBar())
                              : _bottomView(allReviewController),
                        ],
                      ))));
        });
  }

  Widget _bottomView(AllReviewController allReviewController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                width: double.maxFinite,
                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.heightBox,
                    Text(
                      allReviewController.averageRating.toString(),
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                    5.heightBox,
                    AbsorbPointer(
                        absorbing: true,
                        child: Container(
                            width: 240,
                            child: Center(
                                child: RatingBar.builder(
                              initialRating: allReviewController.currentRating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              unratedColor: Color(0xFFDDDDDD),
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemSize: 26,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Color(0xFFFEBD06),
                              ),
                              onRatingUpdate: (rating) {
                                allReviewController.currentRating = rating;
                                allReviewController.update();
                              },
                            )))),
                    5.heightBox,
                    Text(
                      'based on  ${allReviewController.reviewsList.length} reviews',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold),
                    ),
                    20.heightBox,
                    Row(children: [
                      Text(
                        '5 star',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 10.0,
                          percent: allReviewController.averageRating5,
                          linearStrokeCap: LinearStrokeCap.round,
                          backgroundColor: Colors.grey[200],
                          progressColor: Color(0xFFFEBD06),
                        ),
                      ),
                      Text(
                          '${allReviewController.percent5.toString().substring(0, allReviewController.percent5.toString().indexOf('.'))}%',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    5.heightBox,
                    Row(children: [
                      Text(
                        '4 star',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 10.0,
                          percent: allReviewController.averageRating4,
                          linearStrokeCap: LinearStrokeCap.round,
                          backgroundColor: Colors.grey[200],
                          progressColor: Color(0xFFFEBD06),
                        ),
                      ),
                      Text(
                        '${allReviewController.percent4.toString().substring(0, allReviewController.percent4.toString().indexOf('.'))}%',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    5.heightBox,
                    Row(children: [
                      Text(
                        '3 star',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 10.0,
                          percent: allReviewController.averageRating3,
                          linearStrokeCap: LinearStrokeCap.round,
                          backgroundColor: Colors.grey[200],
                          progressColor: Color(0xFFFEBD06),
                        ),
                      ),
                      Text(
                        '${allReviewController.percent3.toString().substring(0, allReviewController.percent3.toString().indexOf('.'))}%',

                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    5.heightBox,
                    Row(children: [
                      Text(
                        '2 star',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 10.0,
                          percent: allReviewController.averageRating2,
                          linearStrokeCap: LinearStrokeCap.round,
                          backgroundColor: Colors.grey[200],
                          progressColor: Color(0xFFFEBD06),
                        ),
                      ),
                      Text(
                        '${allReviewController.percent2.toString().substring(0, allReviewController.percent2.toString().indexOf('.'))}%',

                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    5.heightBox,
                    Row(children: [
                      Text(
                        '1 star',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 10.0,
                          percent: allReviewController.averageRating1,
                          linearStrokeCap: LinearStrokeCap.round,
                          backgroundColor: Colors.grey[200],
                          progressColor: Color(0xFFFEBD06),
                        ),
                      ),
                      Text(
                        '${allReviewController.percent1.toString().substring(0, allReviewController.percent1.toString().indexOf('.'))}%',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    20.heightBox,
                    Divider(thickness: 1,height: 1,color: Colors.grey[300],),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount:  allReviewController.reviewsList.length ,
                        itemBuilder: (context, index) {
                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              10.heightBox,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      allReviewController.reviewsList[index].largeImageUrl!
                                          .isEmpty
                                          ? SvgPicture.asset(
                                        ImageConstanst.user,
                                        height: 35,
                                        width: 35,
                                      )
                                          : CircleAvatar(
                                        radius: 24,
                                        foregroundColor:
                                        Colors.transparent,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          allReviewController.reviewsList[index].largeImageUrl!,
                                          placeholder: (context,
                                              url) =>
                                              CupertinoActivityIndicator(),
                                          imageBuilder:
                                              (context, image) =>
                                              CircleAvatar(
                                                backgroundImage: image,
                                                radius: 45,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                              SvgPicture.asset(
                                                ImageConstanst.user,
                                                height: 50,
                                                width: 50,
                                              ),
                                        ),
                                      ),
                                      5.heightBox,
                                      if (allReviewController.reviewsList[index].rating !=
                                          0)
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        4))),
                                            child: Wrap(
                                              alignment:
                                              WrapAlignment.start,
                                              crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                    allReviewController.reviewsList[index]    .rating!
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold)),
                                                2.widthBox,
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 12,
                                                )
                                              ],
                                            )),
                                    ],
                                  ),
                                  10.widthBox,
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                      text: allReviewController.reviewsList[index] .fullname,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Color(
                                                              0xFF000000)),
                                                      children: <InlineSpan>[
                                                        TextSpan(
                                                            text:
                                                            ' - ${allReviewController.reviewsList[index].createdAt!.split(' ')[0]}',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF888888),
                                                              fontSize: 12,
                                                            )),
                                                      ]))),
                                          5.heightBox,
                                          if (allReviewController.reviewsList[index].review!
                                              .length <
                                              140)
                                            Text(
                                                allReviewController.reviewsList[index]  .review!,
                                                style: TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 12,
                                                )),
                                          if (allReviewController.reviewsList[index]  .review!
                                              .length >
                                              140)
                                            ExpandableText(
                                              allReviewController.reviewsList[index]    .review!,
                                              trimLines: 4,
                                            ),
                                          5.heightBox,
                                          Row(
                                            children: [
                                              Text('Helpful',
                                                  style: TextStyle(
                                                    color: Color(0xFF333333),
                                                    fontSize: 12,
                                                  )),
                                              5.widthBox,
                                              Container(
                                                width: 1,
                                                height: 12,
                                                color: Color(0xFF333333),
                                              ),
                                              5.widthBox,
                                              Text('Report abuse',
                                                  style: TextStyle(
                                                    color: Color(0xFF333333),
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                          10.heightBox
                                        ],
                                      ))
                                ],
                              ),
                              if (allReviewController.reviewsList.length-1 !=
                                  index)
                                Divider(
                                  thickness: 1,
                                  height: 5,
                                  color: Color(0xFFF7F7F7),
                                ),
                            ],
                          );

                        }),
                    30.heightBox
                  ],
                ))));
  }

  Widget topView(AllReviewController allReviewController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
              alignment: language == 'ar'
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // Button color
                  child: InkWell(
                    onTap: () {
                      allReviewController.exitScreen();
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
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'All Reviews',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
