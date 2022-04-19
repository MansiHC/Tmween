import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/review_order_controller.dart';
import 'package:tmween/screens/drawer/checkout/item_shipped_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../utils/views/circular_progress_bar.dart';

class ReviewOrderScreen extends StatelessWidget {
  late String language;

  /*final CartData? cartData;

  ReviewOrderScreen({Key? key, this.cartData}) : super(key: key);*/

  final reviewOrderController = Get.put(ReviewOrderController());

  Future<bool> _onWillPop(ReviewOrderController reviewOrderController) async {
    reviewOrderController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ReviewOrderController>(
        init: ReviewOrderController(),
        builder: (contet) {
          reviewOrderController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(reviewOrderController),
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
                              child: topView(reviewOrderController)),
                          5.heightBox,
                          Expanded(
                              child: SingleChildScrollView(
                                  child: _bottomView(reviewOrderController))),
                        ],
                      ))));
        });
  }

  _bottomView(ReviewOrderController reviewOrderController) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: reviewOrderController.loading,
              child: CircularProgressBar(),
            ),
            Visibility(
                visible: !reviewOrderController.loading &&
                    reviewOrderController.addressList.length > 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.heightBox,
                      Text(
                        'Review your order',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      5.heightBox,
                      Text(
                        "By clicking on the 'Place Your Order and Pay' button, you agree to Tmween.com's privacy notice and conditions of use.",
                        style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      10.heightBox,
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF0288CA)),
                          borderRadius: BorderRadius.circular(4),
                          gradient: new LinearGradient(
                              stops: [0.03, 0.03],
                              colors: [Color(0xFF0288CA), Colors.white]),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 5, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Important message",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              5.heightBox,
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () =>
                                      reviewOrderController.notifyCheckBox(),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Theme(
                                                data: Theme.of(
                                                        reviewOrderController
                                                            .context)
                                                    .copyWith(
                                                  unselectedWidgetColor:
                                                      Colors.grey,
                                                ),
                                                child: Checkbox(
                                                    value: reviewOrderController
                                                        .agree,
                                                    activeColor:
                                                        AppColors.primaryColor,
                                                    onChanged: (value) {
                                                      reviewOrderController
                                                          .notifyCheckBox();
                                                    }))),
                                        5.widthBox,
                                        Expanded(
                                          child: Text(
                                            "Check this box to these delivery and payment options in the future.",
                                            style: TextStyle(
                                                color: Color(0xFF666666),
                                                fontSize: 14),
                                          ),
                                        )
                                      ])),
                            ],
                          ),
                        ),
                      ),
                    ])),
            20.heightBox,
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: 'Shipping to ',
                                    style: TextStyle(
                                        color: Color(0xFF666666), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Salim Akka 24 Water View Way, Reno,nv,8,ghgh',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ])),
                            3.heightBox,
                            RichText(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: 'Guarantee delivery: ',
                                    style: TextStyle(
                                        color: Color(0xFF666666), fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: '29 Mar 2022',
                                        style: TextStyle(
                                            color: Color(0xFF27AF61),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                    ])),
                          ],
                        )),
                    Divider(
                      color: Colors.grey[300]!,
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Product',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                            Text('Total',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                          ],
                        )),
                    Divider(
                      color: Colors.grey[300]!,
                      height: 1,
                      thickness: 1,
                    ),
                    //   for (var i = 0; i < cartData!.cartDetails!.length; i++)
                    Column(children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text('Dream Choice',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 15))),
                              Text('SAR 33',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item(2)',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color(0xFF666666), fontSize: 15)),
                              Text('SAR 343',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 15,
                                  )),
                            ],
                          )),
                      Divider(
                        color: Colors.grey[300]!,
                        height: 1,
                        thickness: 1,
                      ),
                    ]),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Shipping',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                            Text('SAR 10',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                            Text('SAR 2.6',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        )),
                    Divider(
                      color: Colors.grey[300]!,
                      height: 1,
                      thickness: 1,
                    ),
                    Container(
                        color: Colors.grey[200]!,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text('SAR 344',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15)),
                          ],
                        )),
                  ],
                )),
            20.heightBox,
            Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pay with',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            6.heightBox,
                            Text('Cash on Delivery',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xFF666666),
                        )
                      ],
                    ))),
            20.heightBox,
            Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deliver to',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            6.heightBox,
                            Text('Salim Akka',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text('24 water view way, rengshjgshgsdhjgshjdghsg',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF666666), fontSize: 15)),
                          ],
                        )),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color(0xFF666666),
                        )
                      ],
                    ))),
            20.heightBox,
            Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ItemShippedContainer())),
            25.heightBox,
            Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Wrap(spacing: 10, children: [
                    Text(
                      'Proceed to Pay',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    SvgPicture.asset(
                      ImageConstanst.payIcon,
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    )
                  ]),
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF27AF61)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10)),
                  ),
                )),
            25.heightBox,
          ],
        ));
  }

  _itemShippedContainer(
      ReviewOrderController reviewOrderController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Item shipped from Tmween',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),

      ],
    );
  }

  Widget topView(ReviewOrderController reviewOrderController) {
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
                        reviewOrderController.exitScreen();
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
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Complete Payment',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
