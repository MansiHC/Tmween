import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';

import '../../controller/categories_controller.dart';
import '../../utils/global.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'dashboard/select_category_container.dart';

class CategoriesScreen extends StatelessWidget {
  final bool fromDrawer;

  CategoriesScreen({Key? key, this.fromDrawer = false}) : super(key: key);

  final categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (contet) {
          categoriesController.context = context;

          return Scaffold(
              appBar: fromDrawer
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
                    )
                  : PreferredSize(child: Container(), preferredSize: Size.zero),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                        visible: fromDrawer,
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
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: AppColors.primaryColor,
                                      size: 32,
                                    ),
                                    validator: (value) {
                                      return null;
                                    })))),
                    Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrayColor,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.all(1.5),
                        child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 1.5,
                            mainAxisSpacing: 1.5,
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            childAspectRatio: 0.8,
                            physics: ScrollPhysics(),
                            children: List.generate(
                                categoriesController.categories.length,
                                (index) {
                              return SelectCategoryContainer(
                                category:
                                    categoriesController.categories[index],
                                offerVisible: false,
                              );
                            })))
                  ],
                ),
              ));
        });
  }
}
