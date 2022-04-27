import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/get_sub_category_model.dart';
import 'package:tmween/screens/drawer/category/category_product_listing_screen.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/sub_categories_controller.dart';
import '../../../utils/global.dart';
import '../../../utils/views/circular_progress_bar.dart';

class SubCategoriesScreen extends StatefulWidget {
  final List<SubCategoryData> subCategoryData;
  final String categoryName;
  final String categorySlug;

  SubCategoriesScreen(
      {Key? key, required this.subCategoryData, required this.categoryName
      ,
      required this.categorySlug})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubCategoriesScreenState();
  }
}

class SubCategoriesScreenState extends State<SubCategoriesScreen> {
  var language;
  final subCategoriesController = Get.put(SubCategoriesController());

  @override
  void initState() {
    subCategoriesController.subCategoryData = widget.subCategoryData;
    subCategoriesController.categorySlug = widget.categorySlug;

    super.initState();
  }

  Future<bool> _onWillPop(
      SubCategoriesController subCategoriesController) async {
    subCategoriesController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<SubCategoriesController>(
        init: SubCategoriesController(),
        builder: (contet) {
          subCategoriesController.context = context;

          return Scaffold(
              body: WillPopScope(
            onWillPop: () => _onWillPop(subCategoriesController),
            child: Column(
              children: [
                Container(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, maxHeight: 90),
                    color: AppColors.appBarColor,
                    padding: EdgeInsets.only(top: 20),
                    child: topView(subCategoriesController)),
                subCategoriesController.loading
                    ? Expanded(child: Center(child: CircularProgressBar()))
                    : Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: subCategoriesController
                                    .subCategoryData!.length,
                                physics: ScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 1.5,
                                  mainAxisSpacing: 1.5,
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.8,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        print(
                                            '....slug......${subCategoriesController.subCategoryData![index].slugName}');
                                        subCategoriesController.navigateTo(
                                            CategoryProductListingScreen(
                                                categorySlug:
                                                    subCategoriesController
                                                        .categorySlug,
                                                categoryName:
                                                    subCategoriesController
                                                        .subCategoryData![index]
                                                        .subcategoryName,
                                              fromSubCategory: true,
                                              categoryId: subCategoriesController
                                                  .subCategoryData![index].id,
                                            ));
                                      },
                                      child: SubCategoryContainer(
                                        category: subCategoriesController
                                            .subCategoryData![index],
                                        offerVisible: false,
                                        image: subCategoriesController
                                            .subCategoryData![index]
                                            .largeImageUrl!,
                                      ));
                                })))
              ],
            ),
          ));
        });
  }

  Widget topView(SubCategoriesController subCategoriesController) {
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
                        subCategoriesController.exitScreen();
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
                widget.categoryName,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}

class SubCategoryContainer extends StatelessWidget {
  SubCategoryContainer(
      {Key? key,
      required this.category,
      required this.image,
      this.offerVisible = true})
      : super(key: key);
  final SubCategoryData category;
  final String image;
  final bool offerVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
              visible: offerVisible,
              child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 55,
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF9529),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Row(
                        children: [
                          Text(/*'${category.offer}%'*/ '30%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                          2.widthBox,
                          Text(LocaleKeys.off.tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11)),
                        ],
                      )))),
          5.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 2,
                        spreadRadius: 2)
                  ]),
                  child: image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: image,
                          height: MediaQuery.of(context).size.width / 4.1,
                          width: MediaQuery.of(context).size.width / 4.1,
                          placeholder: (context, url) =>
                              Center(child: CupertinoActivityIndicator()),
                          imageBuilder: (context, image) => CircleAvatar(
                            radius: 50,
                            foregroundColor: Colors.grey,
                            backgroundImage: image,
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.width / 4.1,
                          width: MediaQuery.of(context).size.width / 4.1,
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          )))),
          10.heightBox,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                  height: 32,
                  child: Text(category.subcategoryName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.5,
                      )))),
          5.heightBox,
        ]);
  }
}
