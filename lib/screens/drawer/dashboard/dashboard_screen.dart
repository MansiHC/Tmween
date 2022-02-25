import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/dashboard_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/select_category_model.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/dashboard/best_seller_container.dart';
import 'package:tmween/screens/drawer/dashboard/deals_of_the_day_container.dart';
import 'package:tmween/screens/drawer/dashboard/product_detail_screen.dart';
import 'package:tmween/screens/drawer/dashboard/recently_viewed_container.dart';
import 'package:tmween/screens/drawer/dashboard/select_category_container.dart';
import 'package:tmween/screens/drawer/dashboard/sold_by_tmween_container.dart';
import 'package:tmween/screens/drawer/dashboard/top_selection_container.dart';
import 'package:tmween/screens/drawer/deal_of_the_day_screen.dart';
import 'package:tmween/screens/drawer/sold_by_tmween_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../best_seller_screen.dart';
import '../recently_viewed_screen.dart';
import '../top_selection_screen.dart';

class DashboardScreen extends StatelessWidget {
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (contet) {
          dashboardController.context = context;

          return SingleChildScrollView(
              child: Column(
            children: [
              dashboardController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      backgroundColor: AppColors.primaryColor,
                    ))
                  : _topBanner(dashboardController),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: _shopByCategory(dashboardController)),
              20.heightBox,
              _dealsOfTheDay(dashboardController),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
                    fit: BoxFit.fill,
                  )),
              _bestSeller(dashboardController),
              _soldByTmween(dashboardController),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                    fit: BoxFit.fill,
                  )),
              _topSelection(dashboardController),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                    fit: BoxFit.fill,
                  )),
              _recentlyViewed(dashboardController),
              10.heightBox,
              Text(
                LocaleKeys.thatAll.tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF575757), fontSize: 14),
              ),
              10.heightBox
            ],
          ));
        });
  }

  _topBanner(DashboardController dashboardController) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardController.imageSliders,
          carouselController: dashboardController.controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                dashboardController.changPage(index);
              }),
        ),
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  dashboardController.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardController.controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dashboardController.current == entry.key
                            ? AppColors.primaryColor
                            : Colors.white),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  _shopByCategory(DashboardController dashboardController) {


      return Column(
      children: [
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.shopByCategory.tr,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            InkWell(
                onTap: () {
                  dashboardController.navigateTo(CategoriesScreen(
                    fromDrawer: true,
                  ));
                },
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.viewAll.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF575757)),
                    ),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: Color(0xFF575757),
                      size: 14,
                    )
                  ],
                ))
          ],
        ),
        5.heightBox,
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrayColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: EdgeInsets.all(1.5),
            child: GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: dashboardController.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,crossAxisSpacing: 1.5,
                    mainAxisSpacing: 1.5, childAspectRatio: 0.7),
                itemBuilder: (context, index) {
    return SelectCategoryContainer(
    category: dashboardController.categories[index]);
    }))
      /*  Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrayColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            padding: EdgeInsets.all(1.5),
            child: Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(4),
                },
                border: TableBorder.all(color: Color(0xFFF0F0F0)),
                children: dynamicRow()))*/
      ],
    );
  }

  List<TableRow> dynamicRow() {
    List<TableRow> rows = [];
    Iterable<List<SelectCategoryModel>> lst = dashboardController.categories.chunked(3);
    lst.forEach((element) {
      List<Widget> columns = [];
      for (int j = 0 ; j <element.length; j++) {
        columns.add(SelectCategoryContainer(
            category: element[j]));
      }
       rows.add(TableRow(children: columns));
    });
    return rows;
  }

  _dealsOfTheDay(DashboardController dashboardController) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.dealOfTheDayBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            15.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.dealOfDay.tr,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                InkWell(
                    onTap: () {
                      dashboardController.navigateTo(DealsOfTheDayScreen());
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFAFBFF)),
                        ),
                        Icon(
                          CupertinoIcons.chevron_forward,
                          color: Color(0xFFFAFBFF),
                          size: 14,
                        )
                      ],
                    ))
              ],
            ),
            5.heightBox,
            GridView.count(
                padding: EdgeInsets.zero,
                crossAxisSpacing: 15,
                mainAxisSpacing: 12,
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 0.66,
                physics: ScrollPhysics(),
                children:
                    List.generate(dashboardController.deals.length, (index) {
                  return InkWell(
                      onTap: () {
                        dashboardController.navigateTo(ProductDetailScreen());
                      },
                      child: DealsOfTheDayContainer(
                          deal: dashboardController.deals[index]));
                })),
            20.heightBox
          ],
        ));
  }

  _bestSeller(DashboardController dashboardController) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.dealOfTheDayBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            15.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.tmweenBestSeller.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    InkWell(
                        onTap: () {
                          dashboardController.navigateTo(BestSellerScreen());
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.viewAll.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFAFBFF)),
                            ),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: Color(0xFFFAFBFF),
                              size: 14,
                            )
                          ],
                        ))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.bestSellers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BestSellerContainer(
                          bestSeller: dashboardController.bestSellers[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _soldByTmween(DashboardController dashboardController) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.soldByTmweenBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            15.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.soldByTmween.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    InkWell(
                        onTap: () {
                          dashboardController.navigateTo(SoldByTmweenScreen());
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.viewAll.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFAFBFF)),
                            ),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: Color(0xFFFAFBFF),
                              size: 14,
                            )
                          ],
                        ))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.soldByTmweens.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SoldByTmweenContainer(
                          soldByTmween:
                              dashboardController.soldByTmweens[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _topSelection(DashboardController dashboardController) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.topSelectionBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            15.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.topSelection.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          dashboardController.navigateTo(TopSelectionScreen());
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.viewAll.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6E7C77)),
                            ),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: Color(0xFF6E7C77),
                              size: 14,
                            )
                          ],
                        ))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.topSelections.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TopSelectionContainer(
                          topSelection:
                              dashboardController.topSelections[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _recentlyViewed(DashboardController dashboardController) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.recentlyViewedBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            15.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.recentlyViewed.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    InkWell(
                        onTap: () {
                          dashboardController
                              .navigateTo(RecentlyViewedScreen());
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.viewAll.tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6E7C77)),
                            ),
                            Icon(
                              CupertinoIcons.chevron_forward,
                              color: Color(0xFF6E7C77),
                              size: 14,
                            )
                          ],
                        ))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.recentlVieweds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return RecentlyViewedContainer(
                          recentlyViewed:
                              dashboardController.recentlVieweds[index]);
                    })),
            20.heightBox
          ],
        ));
  }
}
