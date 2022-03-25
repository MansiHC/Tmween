///with api
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
import 'package:tmween/utils/views/circular_progress_bar.dart';

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

          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: ClassicHeader(),
          controller: dashboardController.refreshController,
          onRefresh: (){
                dashboardController.onRefresh(dashboardController);
          },

          child:dashboardController.loading
              ?Center(child:CircularProgressBar())
              :SingleChildScrollView(
              child: Column(
                children: [
                   _topBanner(dashboardController),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: _shopByCategory(dashboardController)),
                  20.heightBox,
                  _dealsOfTheDay(dashboardController),
                  _centerBanner(dashboardController),
                  _bestSeller(dashboardController),
                  _soldByTmween(dashboardController),
                  _centerUpBanner(dashboardController),
                  _topSelection(dashboardController),
                  _centerDownBanner(dashboardController),
                  _recentlyViewed(dashboardController),
                  10.heightBox,
                  Text(
                    LocaleKeys.thatAll.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF575757), fontSize: 14),
                  ),
                  10.heightBox
                ],
              )));
        });
  }

  _topBanner(DashboardController dashboardController) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardController.
              topBanners!.map((item) => Container(
            child: CachedNetworkImage(
              imageUrl: item.largeImageUrl!,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child:CupertinoActivityIndicator()
                  )
              ,
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported,color: Colors.grey,),
            )
            ,
          ))
              .toList(),
          carouselController: dashboardController.topBannerController,
          options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                dashboardController.changPage(index);
              }),
        ),
        if( dashboardController.topBanners!.length>1)
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              dashboardController.topBanners!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardController.topBannerController.animateToPage(entry.key),
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
  _centerBanner(DashboardController dashboardController) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardController.
              centerBanners!.map((item) => Container(
            child: CachedNetworkImage(
              imageUrl: item.largeImageUrl!,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child:CupertinoActivityIndicator()
                  )
              ,
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported,color: Colors.grey,),
            )
            ,
          ))
              .toList(),
          carouselController: dashboardController.centerBannerController,
          options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                dashboardController.changPage(index);
              }),
        ),
        if( dashboardController.centerBanners!.length>1)
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              dashboardController.centerBanners!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardController.centerBannerController.animateToPage(entry.key),
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
  _centerUpBanner(DashboardController dashboardController) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardController.
              centerUpBanners!.map((item) => Container(
            child: CachedNetworkImage(
              imageUrl: item.largeImageUrl!,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child:CupertinoActivityIndicator()
                  )
              ,
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported,color: Colors.grey,),
            )
            ,
          ))
              .toList(),
          carouselController: dashboardController.centerUpBannerController,
          options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                dashboardController.changPage(index);
              }),
        ),
        if( dashboardController.centerUpBanners!.length>1)
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              dashboardController.centerUpBanners!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardController.centerUpBannerController.animateToPage(entry.key),
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
  _centerDownBanner(DashboardController dashboardController) {
    return Stack(
      children: [
        CarouselSlider(
          items: dashboardController.
              centerDownBanners!.map((item) => Container(
            child: CachedNetworkImage(
              imageUrl: item.largeImageUrl!,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
              placeholder: (context, url) =>
                  Center(child:CupertinoActivityIndicator()
                  )
              ,
              errorWidget: (context, url, error) => Icon(Icons.image_not_supported,color: Colors.grey,),
            )
            ,
          ))
              .toList(),
          carouselController: dashboardController.centerDownBannerController,
          options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1.6,
              onPageChanged: (index, reason) {
                dashboardController.changPage(index);
              }),
        ),
        if( dashboardController.centerDownBanners!.length>1)
        Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              dashboardController.centerDownBanners!.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () =>
                      dashboardController.centerDownBannerController.animateToPage(entry.key),
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
            Visibility(
                visible: dashboardController.shopByCategory!.length>9,
                child:
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
                )))
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
                itemCount: dashboardController.shopByCategory!.length>9?9:dashboardController.shopByCategory!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1.5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  return SelectCategoryContainer(
                      category: dashboardController.shopByCategory![index]);
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

  /*List<TableRow> dynamicRow() {
    List<TableRow> rows = [];
    Iterable<List<SelectCategoryModel>> lst =
    dashboardController.categories.chunked(3);
    lst.forEach((element) {
      List<Widget> columns = [];
      for (int j = 0; j < element.length; j++) {
        columns.add(SelectCategoryContainer(category: element[j]));
      }
      rows.add(TableRow(children: columns));
    });
    return rows;
  }*/

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
                Visibility(
                    visible: dashboardController.dailyDealsData!.length>4,
                    child:
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
                    )))
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
                List.generate(dashboardController.dailyDealsData!.length>4?4:dashboardController.dailyDealsData!.length, (index) {
                  return InkWell(
                      onTap: () {
                        dashboardController.navigateTo(ProductDetailScreen(productId: dashboardController.dailyDealsData![0].productId,));
                      },
                      child: DealsOfTheDayContainer(
                          deal: dashboardController.dailyDealsData![index]));
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
                   Visibility(
                       visible: dashboardController.bestSellerData!.length>AppConstants.cardsPerPage,
                       child:  InkWell(
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
                        )))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount:dashboardController.bestSellerData!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen(productId: dashboardController.bestSellerData![0].id,));
                          },
                          child: BestSellerContainer(
                              bestSeller:
                              dashboardController.bestSellerData![index]));
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
                   Visibility(
                       visible: dashboardController.soldByTmweenProductData!.length>AppConstants.cardsPerPage,
                       child: InkWell(
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
                        )))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.soldByTmweenProductData!.length>AppConstants.cardsPerPage?AppConstants.cardsPerPage:dashboardController.soldByTmweenProductData!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen(productId: dashboardController.soldByTmweenProductData![0].id,));
                          },
                          child: SoldByTmweenContainer(
                              soldByTmween:
                              dashboardController.soldByTmweenProductData![index]));
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
                    Visibility(
                        visible: dashboardController.topSelectionData!.length>AppConstants.cardsPerPage,
                        child: InkWell(
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
                        )))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.topSelectionData!.length>AppConstants.cardsPerPage?AppConstants.cardsPerPage:dashboardController.topSelectionData!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen(productId: dashboardController.topSelectionData![0].id,));
                          },
                          child: TopSelectionContainer(
                              topSelection:
                              dashboardController.topSelectionData![index]));
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
                 Visibility(
                     visible: dashboardController.recentlyViewProduct!.length>AppConstants.cardsPerPage,
                     child:    InkWell(
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
                        )))
                  ],
                )),
            5.heightBox,
            Container(
                height: 244,
                child: ListView.builder(
                    itemCount: dashboardController.recentlyViewProduct!.length>AppConstants.cardsPerPage?AppConstants.cardsPerPage:dashboardController.recentlyViewProduct!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen(productId: dashboardController.recentlyViewProduct![0].productId,));
                          },
                          child: RecentlyViewedContainer(
                              recentlyViewed:
                              dashboardController.recentlyViewProduct![index]));
                    })),
            20.heightBox
          ],
        ));
  }
}






///without api
/*
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
                  child: Image.asset(
                    'asset/image/home_page_banner_images/home_banner_1.jpg',
                    fit: BoxFit.fill,
                  )),
              _bestSeller(dashboardController),
              _soldByTmween(dashboardController),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'asset/image/home_page_banner_images/home_banner_2.jpg',
                    fit: BoxFit.fill,
                  )),
              _topSelection(dashboardController),
              SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'asset/image/home_page_banner_images/home_banner_3.jpg',
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
              enableInfiniteScroll: false,
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
                    crossAxisCount: 3,
                    crossAxisSpacing: 1.5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  return SelectCategoryContainer(
                      category: dashboardController.categories[index]);
                }))
        */
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
                children: dynamicRow()))*//*

      ],
    );
  }

  List<TableRow> dynamicRow() {
    List<TableRow> rows = [];
    Iterable<List<SelectCategoryModel>> lst =
        dashboardController.categories.chunked(3);
    lst.forEach((element) {
      List<Widget> columns = [];
      for (int j = 0; j < element.length; j++) {
        columns.add(SelectCategoryContainer(category: element[j]));
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
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen());
                          },
                          child: BestSellerContainer(
                              bestSeller:
                                  dashboardController.bestSellers[index]));
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
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen());
                          },
                          child: SoldByTmweenContainer(
                              soldByTmween:
                                  dashboardController.soldByTmweens[index]));
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
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen());
                          },
                          child: TopSelectionContainer(
                              topSelection:
                                  dashboardController.topSelections[index]));
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
                      return InkWell(
                          onTap: () {
                            dashboardController
                                .navigateTo(ProductDetailScreen());
                          },
                          child: RecentlyViewedContainer(
                              recentlyViewed:
                                  dashboardController.recentlVieweds[index]));
                    })),
            20.heightBox
          ],
        ));
  }
}
*/
