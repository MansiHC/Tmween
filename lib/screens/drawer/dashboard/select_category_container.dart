import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/categories_controller.dart';
import '../../../model/dashboard_model.dart';

class SelectCategoryContainer extends StatelessWidget {
  SelectCategoryContainer(
      {Key? key,
      required this.category,
      required this.image,
      this.offerVisible = true})
      : super(key: key);
  final ShopByCategory category;
  final String image;
  final bool offerVisible;
  final categoriesController = Get.put(CategoriesController());
  var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (contet) {
          categoriesController.context = context;

          return InkWell(
              onTap: () {
                categoriesController.getSubCategories(category.id!,
                    category.categoryName!, category.slugName!, language);
              },
              child: Container(
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFFF9529),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(/*'${category.offer}%'*/ '30%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold)),
                                      2.widthBox,
                                      Text(LocaleKeys.off.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11)),
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
                          child: image.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: image,
                                  height:
                                      MediaQuery.of(context).size.width / 4.5,
                                  placeholder: (context, url) => Center(
                                      child: CupertinoActivityIndicator()),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                )
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.width / 5.3,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ))),
                    ]),
              ));
        });
  }
}
