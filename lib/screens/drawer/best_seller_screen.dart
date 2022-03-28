import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/best_seller_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';

import '../../utils/global.dart';
import '../../utils/views/circular_progress_bar.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'dashboard/best_seller_container.dart';
import 'dashboard/product_detail_screen.dart';

class BestSellerScreen extends StatelessWidget {
  final bestSellerController = Get.put(BestSellerController());

  Future<bool> _onWillPop(BestSellerController bestSellerController) async {
    bestSellerController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BestSellerController>(
        init: BestSellerController(),
        builder: (contet) {
          bestSellerController.context = context;

          return WillPopScope(
              onWillPop: () => _onWillPop(bestSellerController),
              child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: AppColors.appBarColor,
                    centerTitle: false,
                    titleSpacing: 0.0,
                    title: Text(
                      LocaleKeys.tmweenBestSellerSmall.tr,
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
                                        bestSellerController.searchController,
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
                                    }))),
                        bestSellerController.loading
                            ? Center(child: CircularProgressBar())
                            : Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                padding: EdgeInsets.all(1.5),
                                child: NotificationListener<ScrollNotification>(
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (scrollInfo.metrics.pixels ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                        print('dhjkhkjh..........');
                                        bestSellerController.loadMore();
                                        return true;
                                      }
                                      print('dhjkhkjh..........');
                                      return false;
                                    },
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: bestSellerController
                                            .bestSellerData!.length,
                                        physics: ScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 5,
                                          childAspectRatio: 0.66,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: bestSellerController
                                                  .bestSellerData!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                    onTap: () {
                                                      bestSellerController
                                                          .navigateTo(
                                                              ProductDetailScreen());
                                                    },
                                                    child: BestSellerContainer(
                                                      bestSeller:
                                                          bestSellerController
                                                                  .bestSellerData![
                                                              index],
                                                      from:
                                                          SharedPreferencesKeys
                                                              .isDashboard,
                                                    ));
                                              });
                                        }) /*GridView.count(
                            padding: EdgeInsets.zero,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            childAspectRatio: 0.66,
                            physics: ScrollPhysics(),
                            children: List.generate(
                                bestSellerController.bestSellerData!.length,
                                (index) {
                              return InkWell(
                                  onTap: () {
                                    bestSellerController
                                        .navigateTo(ProductDetailScreen());
                                  },
                                  child: BestSellerContainer(
                                    bestSeller:
                                        bestSellerController.bestSellerData![index],
                                    from: SharedPreferencesKeys.isDashboard,
                                  ));
                            }))*/
                                    ))
                      ],
                    ),
                  )));
        });
  }
}
