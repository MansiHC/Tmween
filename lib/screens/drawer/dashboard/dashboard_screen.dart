import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/dashboard_provider.dart';
import 'package:tmween/screens/drawer/dashboard/best_seller_container.dart';
import 'package:tmween/screens/drawer/dashboard/deals_of_the_day_container.dart';
import 'package:tmween/screens/drawer/dashboard/recently_viewed_container.dart';
import 'package:tmween/screens/drawer/dashboard/select_category_container.dart';
import 'package:tmween/screens/drawer/dashboard/sold_by_tmween_container.dart';
import 'package:tmween/screens/drawer/dashboard/top_selection_container.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, _) {
      dashboardProvider.context = context;

      return Column(children: [
        Container(
            color: AppColors.appBarColor,
            child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: CustomTextFormField(
                    controller: dashboardProvider.searchController,
                    keyboardType: TextInputType.text,
                    hintText: LocaleKeys.searchProducts.tr(),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (term) {
                      FocusScope.of(context).unfocus();
                    },
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                    validator: (value) {
                      return null;
                    }))),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            dashboardProvider.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                  ))
                : _topBanner(dashboardProvider),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: _shopByCategory(dashboardProvider)),
            20.heightBox,
            _dealsOfTheDay(dashboardProvider),
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
                  fit: BoxFit.fill,
                )),
            _bestSeller(dashboardProvider),
            _soldByTmween(dashboardProvider),
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                  fit: BoxFit.fill,
                )),
            _topSelection(dashboardProvider),
            SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                  fit: BoxFit.fill,
                )),
            _recentlyViewed(dashboardProvider),
            10.heightBox,
            Text(
              LocaleKeys.thatAll.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            10.heightBox
          ],
        )))
      ]);
    });
  }

  _topBanner(DashboardProvider dashboardProvider) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardProvider.imageSliders,
          carouselController: dashboardProvider.controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                setState(() {
                  dashboardProvider.current = index;
                });
              }),
        ),
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dashboardProvider.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardProvider.controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dashboardProvider.current == entry.key
                            ? AppColors.primaryColor
                            : Colors.white),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  _shopByCategory(DashboardProvider dashboardProvider) {
    return Column(
      children: [
        15.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.shopByCategory.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  LocaleKeys.viewAll.tr(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: Colors.black87,
                  size: 14,
                )
              ],
            )
          ],
        ),
        5.heightBox,
        Container(
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
                children:
                    List.generate(dashboardProvider.categories.length, (index) {
                  return SelectCategoryContainer(
                      category: dashboardProvider.categories[index]);
                })))
      ],
    );
  }

  _dealsOfTheDay(DashboardProvider dashboardProvider) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.dealOfTheDayBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.dealOfDay.tr(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.viewAll.tr(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.white70,
                      size: 14,
                    )
                  ],
                )
              ],
            ),
            5.heightBox,
            GridView.count(
                padding: EdgeInsets.zero,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 0.66,
                physics: ScrollPhysics(),
                children:
                    List.generate(dashboardProvider.deals.length, (index) {
                  return DealsOfTheDayContainer(
                      deal: dashboardProvider.deals[index]);
                })),
            20.heightBox
          ],
        ));
  }

  _bestSeller(DashboardProvider dashboardProvider) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.dealOfTheDayBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            10.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.tmweenBestSeller.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.white70,
                          size: 14,
                        )
                      ],
                    )
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardProvider.bestSellers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BestSellerContainer(
                          bestSeller: dashboardProvider.bestSellers[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _soldByTmween(DashboardProvider dashboardProvider) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.soldByTmweenBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            10.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.soldByTmween.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.white70,
                          size: 14,
                        )
                      ],
                    )
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardProvider.soldByTmweens.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SoldByTmweenContainer(
                          soldByTmween: dashboardProvider.soldByTmweens[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _topSelection(DashboardProvider dashboardProvider) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.topSelectionBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            10.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.topSelection.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.black87,
                          size: 14,
                        )
                      ],
                    )
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardProvider.topSelections.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TopSelectionContainer(
                          topSelection: dashboardProvider.topSelections[index]);
                    })),
            20.heightBox
          ],
        ));
  }

  _recentlyViewed(DashboardProvider dashboardProvider) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstanst.recentlyViewedBg),
                fit: BoxFit.fill)),
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            10.heightBox,
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.recentlyViewed.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.viewAll.tr(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.black87,
                          size: 14,
                        )
                      ],
                    )
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardProvider.recentlVieweds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return RecentlyViewedContainer(
                          recentlyViewed:
                              dashboardProvider.recentlVieweds[index]);
                    })),
            20.heightBox
          ],
        ));
  }
}
