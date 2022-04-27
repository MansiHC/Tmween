import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';

import '../../../controller/categories_controller.dart';
import '../../../utils/global.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/custom_text_form_field.dart';
import '../dashboard/select_category_container.dart';

class CategoriesScreen extends StatefulWidget {
  final bool fromDrawer;


  CategoriesScreen({Key? key, this.fromDrawer = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   return CategoriesScreenState();
  }

}
class CategoriesScreenState extends State<CategoriesScreen> {
  var language;
  final categoriesController = Get.put(CategoriesController());


  @override
  void initState() {
    categoriesController.getCategories(Get.locale!.languageCode);

    super.initState();
  }

  Future<bool> _onWillPop(CategoriesController categoriesController) async {
    categoriesController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (contet) {
          categoriesController.context = context;

          return Scaffold(
              appBar: widget.fromDrawer
                  ? AppBar(
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: Colors.white),
                      backgroundColor: AppColors.appBarColor,
                      centerTitle: false,
                      titleSpacing: 0.0,
                      title: Text(
                        LocaleKeys.shopByCategorySmall.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                      /*  leading: BackButton(onPressed: () {
                        categoriesController.exitScreen();
                      }),*/
                    )
                  : PreferredSize(child: Container(), preferredSize: Size.zero),
              body: WillPopScope(
                onWillPop: () => _onWillPop(categoriesController),
                child: Column(
                  children: [
                    Visibility(
                        visible: widget.fromDrawer,
                        child: Container(
                            color: AppColors.appBarColor,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2)),
                                height: 40,
                                margin: EdgeInsets.only(
                                    bottom: 10, left: 15, right: 15),
                                child: CustomTextFormField(
                                    isDense: true,
                                    controller:
                                        categoriesController.searchController,
                                    keyboardType: TextInputType.text,
                                    hintText: LocaleKeys.searchProducts.tr,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (term) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrayColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrayColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightGrayColor),
                                      ),
                                      isDense: true,
                                      hintText: LocaleKeys.searchProducts.tr,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppColors.primaryColor,
                                        size: 32,
                                      ),
                                    ),
                                    validator: (value) {
                                      return null;
                                    })))),
                    categoriesController.loading
                        ? Expanded(child: Center(child: CircularProgressBar()))
                        : Expanded(
                            child: RefreshIndicator(
                                onRefresh: () =>
                                    categoriesController.onRefresh(language),
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrayColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    padding: EdgeInsets.all(1.5),
                                    child: NotificationListener<
                                            ScrollNotification>(
                                        onNotification:
                                            (ScrollNotification scrollInfo) {
                                          if (scrollInfo
                                                  is ScrollEndNotification &&
                                              scrollInfo.metrics.pixels ==
                                                  scrollInfo.metrics
                                                      .maxScrollExtent) {
                                            if (categoriesController.next !=
                                                0) {
                                              categoriesController
                                                  .loadMore(language);
                                            }
                                          }
                                          return false;
                                        },
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: categoriesController
                                                .shopByCategory!.length,
                                            physics: ScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 1.5,
                                              mainAxisSpacing: 1.5,
                                              crossAxisCount: 3,
                                              childAspectRatio: 0.73,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return SelectCategoryContainer(
                                                category: categoriesController
                                                    .shopByCategory![index],
                                                offerVisible: false,
                                                image: categoriesController
                                                    .shopByCategory![index]
                                                    .largeImageUrl!,
                                              );
                                            })))))
                  ],
                ),
              ));
        });
  }
}
