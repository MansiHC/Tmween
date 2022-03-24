import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/dashboard_model.dart';
import '../../../model/select_category_model.dart';

class SelectCategoryContainer extends StatelessWidget {
  SelectCategoryContainer(
      {Key? key, required this.category, this.offerVisible = true})
      : super(key: key);
  final ShopByCategory category;
  final bool offerVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
                visible: offerVisible,
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        width: 55,
                        padding:
                        EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Color(0xFFFF9529),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            Text(/*'${category.offer}%'*/'30%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                            2.widthBox,
                            Text(LocaleKeys.off.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                    height: 32,
                    child: Text(category.categoryName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.5,
                        )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: category.smallImageUrl!.isNotEmpty?CachedNetworkImage(
                  imageUrl: category.smallImageUrl!,
                  height: 80,
                  width: 80,
                  placeholder: (context, url) =>
                      Center(child:CupertinoActivityIndicator()),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.image_not_supported,color: Colors.grey,),
                ): Container(height: 80,
                    width: 80,child:Icon(Icons.image_not_supported,color: Colors.grey,))),
            5.heightBox
          ]),
    );
  }
}



/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/select_category_model.dart';

class SelectCategoryContainer extends StatelessWidget {
  SelectCategoryContainer(
      {Key? key, required this.category, this.offerVisible = true})
      : super(key: key);
  final SelectCategoryModel category;
  final bool offerVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
                visible: offerVisible,
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        width: 55,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Color(0xFFFF9529),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Row(
                          children: [
                            Text('${category.offer}%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                            2.widthBox,
                            Text(LocaleKeys.off.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                    height: 32,
                    child: Text(category.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.5,
                        )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Image.asset(
                  category.image,
                  fit: BoxFit.contain,
                  height: 55,
                  width: 80,
                )),
            5.heightBox
          ]),
    );
  }
}
*/
