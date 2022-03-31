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
  var language ;

  Future<bool> _onWillPop(BestSellerController bestSellerController) async {
    bestSellerController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language= Get.locale!.languageCode;
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
                body: Column(
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
                        : Expanded(
                            child: RefreshIndicator(
                                onRefresh: () =>
                                    bestSellerController.onRefresh(language)
                                ,
                                child:Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                padding: EdgeInsets.all(1.5),
                                child: NotificationListener<ScrollNotification>(
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (scrollInfo is ScrollEndNotification &&
                                          scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                                        if (bestSellerController.next != 0) {
                                          bestSellerController.loadMore(language);
                                        }
                                      }
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
                                          return InkWell(
                                              onTap: () {
                                                bestSellerController.navigateTo(
                                                    ProductDetailScreen(productId: bestSellerController
                                                        .bestSellerData![index].id,
                                                    productslug:bestSellerController
                                                        .bestSellerData![index].productSlug ,));
                                              },
                                              child: BestSellerContainer(
                                                bestSeller: bestSellerController
                                                    .bestSellerData![index],
                                                from: SharedPreferencesKeys
                                                    .isDashboard,
                                              ));
                                        })))))
                  ],
                ),
              ));
        });
  }
}
