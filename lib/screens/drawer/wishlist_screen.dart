import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/model/get_wishlist_details_model.dart';
import 'package:tmween/screens/drawer/productDetail/product_detail_screen.dart';
import 'package:tmween/screens/drawer/wishlist_container.dart';

import '../../lang/locale_keys.g.dart';
import '../../utils/global.dart';
import '../../utils/my_shared_preferences.dart';
import '../../utils/views/circular_progress_bar.dart';
import '../../utils/views/custom_text_form_field.dart';

class WishlistScreen extends StatefulWidget {
  final bool fromProfile;
  late String language;

  WishlistScreen({Key? key, this.fromProfile = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WishlistScreenState();
  }
}

class WishlistScreenState extends State<WishlistScreen> {
  late String language;

  final wishlistController = Get.put(WishlistController());

  Future<bool> _onWillPop(WishlistController wishlistController) async {
    wishlistController.exitScreen();
    return true;
  }

  int userId = 0;
  String token = '';
  int loginLogId = 0;

  @override
  void initState() {
    wishlistController.searchController.clear();
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      token = value!;
      print('dhsh.....$token');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        userId = value!;
        wishlistController.getWishListData(Get.locale!.languageCode);
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          loginLogId = value!;
        });
      });
    });
    super.initState();
  }

  void filterSearchResults(String query) {
    List<WishlistData> dummySearchList = [];
    dummySearchList.addAll(wishlistController.wishListData);
    List<WishlistData> dummyListData = [];
    if (query.isNotEmpty) {
      dummySearchList.forEach((item) {
        if (item.productName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      wishlistController.wishListItems = dummyListData;
      wishlistController.update();
      return;
    } else {
      wishlistController.wishListItems = wishlistController.wishListData;
      wishlistController.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;

    return GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (contet) {
          wishlistController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(wishlistController),
              child: Scaffold(
                  body: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                        visible: widget.fromProfile,
                        child: Container(
                            constraints: BoxConstraints(
                                minWidth: double.infinity, maxHeight: 90),
                            color: AppColors.appBarColor,
                            padding: EdgeInsets.only(top: 20),
                            child: topView(wishlistController))),
                    Container(
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15),
                            child: CustomTextFormField(
                                isDense: true,
                                controller: wishlistController.searchController,
                                keyboardType: TextInputType.text,
                                hintText: LocaleKeys.searchProducts.tr,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value) {
                                  filterSearchResults(value);
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
                                  suffixIcon: wishlistController.searchController.text.length>0?
                                  IconButton(
                                      onPressed: () {
                                        wishlistController.searchController
                                            .clear();
                                        wishlistController.update();
                                      },
                                      icon: Icon(
                                        CupertinoIcons
                                            .clear_circled_solid,
                                        color: AppColors.primaryColor,
                                        size: 24,
                                      )):SizedBox(),
                                ),
                                validator: (value) {
                                  return null;
                                }))),
                    if (wishlistController.loading)
                      Expanded(
                        child: CircularProgressBar(),
                      ),
                    Visibility(
                      visible: !wishlistController.loading &&
                          wishlistController.wishListItems.length == 0,
                      child: Expanded(
                        child: Center(
                            child: Text(
                          LocaleKeys.noRecords.tr,
                          style: TextStyle(
                              color: Color(0xFF414141),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    Visibility(
                        visible: !wishlistController.loading &&
                            wishlistController.wishListItems.length > 0,
                        child: Expanded(
                            child: RefreshIndicator(
                                onRefresh: () =>
                                    wishlistController.onRefresh(language),
                                child: Container(
                                    color: Colors.white,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 15,
                                            bottom: 10,
                                            right: 10,
                                            left: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                        padding: EdgeInsets.all(1.5),
                                        child: NotificationListener<
                                                ScrollNotification>(
                                            onNotification: (ScrollNotification
                                                scrollInfo) {
                                              if (scrollInfo
                                                      is ScrollEndNotification &&
                                                  scrollInfo.metrics.pixels ==
                                                      scrollInfo.metrics
                                                          .maxScrollExtent) {
                                                if (wishlistController.next !=
                                                    0) {
                                                  wishlistController
                                                      .loadMore(language);
                                                }
                                              }

                                              return false;
                                            },
                                            child: GridView.builder(
                                                shrinkWrap: true,
                                                itemCount: wishlistController
                                                    .wishListItems.length,
                                                physics: ScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 5,
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 0.66,
                                                ),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                      onTap: () {
                                                        wishlistController.navigateTo(ProductDetailScreen(
                                                            productId:
                                                                wishlistController
                                                                    .wishListItems[
                                                                        0]
                                                                    .id,
                                                            productslug:
                                                                wishlistController
                                                                    .wishListItems[
                                                                        index]
                                                                    .productSlug));
                                                      },
                                                      child: WishlistContainer(
                                                        wishlistData:
                                                            wishlistController
                                                                    .wishListItems[
                                                                index],
                                                      ));
                                                })))))))
                  ],
                ),
              )));
        });
  }

  Widget topView(WishlistController wishlistController) {
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
                        wishlistController.exitScreen();
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
                LocaleKeys.wishLists.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
