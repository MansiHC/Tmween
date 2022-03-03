import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/recently_viewed_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/dashboard/recently_viewed_container.dart';

import '../../utils/global.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'dashboard/product_detail_screen.dart';

class RecentlyViewedScreen extends StatelessWidget {
  final recentlyProviderController = Get.put(RecentlyViewedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecentlyViewedController>(
        init: RecentlyViewedController(),
        builder: (contet) {
          recentlyProviderController.context = context;
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: AppColors.appBarColor,
                centerTitle: false,
                titleSpacing: 0.0,
                title: Text(
                  LocaleKeys.recentlyViewedSmall.tr,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
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
                                    recentlyProviderController.searchController,
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
                                }))),
                    Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrayColor,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        padding: EdgeInsets.all(1.5),
                        child: GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio: 0.66,
                            physics: ScrollPhysics(),
                            children: List.generate(
                                recentlyProviderController
                                    .recentlVieweds.length, (index) {
                              return InkWell(
                                  onTap: () {
                                    recentlyProviderController
                                        .navigateTo(ProductDetailScreen());
                                  },
                                  child: RecentlyViewedContainer(
                                    recentlyViewed: recentlyProviderController
                                        .recentlVieweds[index],
                                  ));
                            })))
                  ],
                ),
              ));
        });
  }
}
