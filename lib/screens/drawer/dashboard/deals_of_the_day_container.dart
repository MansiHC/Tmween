import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/deals_of_the_day_model.dart';
import '../../../utils/global.dart';

class DealsOfTheDayContainer extends StatelessWidget {
  const DealsOfTheDayContainer({Key? key, required this.deal})
      : super(key: key);
  final DealsOfTheDayModel deal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            5.heightBox,
            Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.offerGreen,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(deal.rating,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 12,
                          )
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: AppColors.offerGreen,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Column(
                        children: [
                          Text('${deal.offer}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          Text('OFF',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ],
                      )),
                ])),
            5.heightBox,
            Padding(padding: EdgeInsets.symmetric(horizontal: 5),child:Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.network(
                      deal.image,
                      fit: BoxFit.cover,
                    )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.only(left: 5, right: 15),
                child: Text(deal.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black54, fontSize: 13))),
            5.heightBox,
            if (deal.fulfilled)
              Padding(
                  padding: EdgeInsets.only(left: 5, right: 15),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                              text: 'Fulfilled by ',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.blueBackground),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Tmween',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.blueBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]))))
            else
              13.heightBox,
            5.heightBox,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),

              decoration: BoxDecoration(
                  color: AppColors.darkGrayBackground,
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(4),bottomRight:Radius.circular(4))),
              child: Row(
                children: [
                  Text('SAR ${deal.price}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  2.widthBox,
                  Expanded(child: Text('SAR ${deal.beforePrice!}',
                      textAlign: TextAlign.start,
                      style: TextStyle( decoration: TextDecoration.lineThrough,color: Colors.black54, fontSize: 10))),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                      decoration: BoxDecoration(
                          color: AppColors.blueBackground,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white,fontSize: 14),

                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
