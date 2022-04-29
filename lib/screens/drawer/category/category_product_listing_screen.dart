import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/category/category_filter_screen.dart';
import 'package:tmween/screens/drawer/category/category_product_listing_container.dart';
import 'package:tmween/screens/drawer/profile/address/your_addresses_screen.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/category_product_listing_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../model/get_customer_address_list_model.dart';
import '../../../utils/global.dart';
import '../../../utils/my_shared_preferences.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/custom_button.dart';
import '../../authentication/login/login_screen.dart';
import '../address_container.dart';

class CategoryProductListingScreen extends StatefulWidget {
  final String? categorySlug;
  final String? categoryName;
  final int? categoryId;
  final bool fromFilter;
  final bool fromSubCategory;
  final int? fromPrice;
  final int? toPrice;
  final int? fullFillByTmween;
  final List<String>? catIdList;
  final List<String>? brandIdList;
  final List<String>? sellerIdList;

  CategoryProductListingScreen(
      {Key? key,
      required this.categorySlug,
      required this.categoryName,
      required this.categoryId,
      this.fromSubCategory = false,
      this.fromFilter = false,
      this.fromPrice,
      this.toPrice,
      this.fullFillByTmween,
      this.catIdList,
      this.brandIdList,
      this.sellerIdList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryProductListingScreenState();
  }
}

class CategoryProductListingScreenState
    extends State<CategoryProductListingScreen> {
  final categoryProductListingController =
      Get.put(CategoryProductListingController());
  late var language;

  @override
  void initState() {
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      categoryProductListingController.isLogin = value!;
      categoryProductListingController.categorySlug = widget.categorySlug!;
      categoryProductListingController.categoryName = widget.categoryName!;
      categoryProductListingController.categoryId = widget.categoryId!;

      if (categoryProductListingController.isLogin) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.token)
            .then((value) async {
          categoryProductListingController.token = value!;
          print('dhsh.....${categoryProductListingController.token}');
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.userId)
              .then((value) async {
            categoryProductListingController.userId = value!;
            if (widget.fromFilter) {
              categoryProductListingController.fromPrice = widget.fromPrice;
              categoryProductListingController.toPrice = widget.toPrice;
              categoryProductListingController.fullFillByTmween = widget.fullFillByTmween;
              categoryProductListingController.catIdList = widget.catIdList;
              categoryProductListingController.brandIdList = widget.brandIdList;
              categoryProductListingController.sellerIdList =
                  widget.sellerIdList;
              categoryProductListingController.getFilterResult(language);
            } else {
              categoryProductListingController.getProductList(
                  categoryProductListingController.categorySlug,
                  Get.locale!.languageCode);
            }
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              categoryProductListingController.loginLogId = value!;
            });
          });
        });
      } else {
        if (widget.fromFilter) {
          categoryProductListingController.fromPrice = widget.fromPrice;
          categoryProductListingController.toPrice = widget.toPrice;
          categoryProductListingController.catIdList = widget.catIdList;
          categoryProductListingController.brandIdList = widget.brandIdList;
          categoryProductListingController.sellerIdList = widget.sellerIdList;
          categoryProductListingController.getFilterResult(language);
        } else {
          categoryProductListingController.getProductList(
              categoryProductListingController.categorySlug,
              Get.locale!.languageCode);
        }
      }
      categoryProductListingController.update();
    });
    super.initState();
  }

  Future<bool> _onWillPop(
      CategoryProductListingController categoryProductListingController) async {
    categoryProductListingController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<CategoryProductListingController>(
        init: CategoryProductListingController(),
        builder: (contet) {
          categoryProductListingController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(categoryProductListingController),
              child: Scaffold(
                  body: Form(
                key: categoryProductListingController.formKey,
                child: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 90),
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 20),
                        child: topView(categoryProductListingController)),
                    _productList(categoryProductListingController)
                  ],
                ),
              )));
        });
  }

  _productList(
      CategoryProductListingController categoryProductListingController) {
    return  !categoryProductListingController.searchLoading &&
        categoryProductListingController
            .productList.length ==
            0
        ? Expanded(child: Column(children: [
      InkWell(
          onTap: () {
            MySharedPreferences.instance
                .getBoolValuesSF(SharedPreferencesKeys
                .addressFromCurrentLocation)
                .then((value) async {
              if (value != null)
                categoryProductListingController
                    .addressFromCurrentLocation = value;

              if (categoryProductListingController.isLogin) {
                categoryProductListingController
                    .getAddressList(language)
                    .then((value) => showModalBottomSheet<void>(
                    context: categoryProductListingController
                        .context,
                    builder: (BuildContext context) {
                      return _bottomSheetView(
                          categoryProductListingController);
                    }));
              } else {
                showModalBottomSheet<void>(
                    context:
                    categoryProductListingController.context,
                    builder: (BuildContext context) {
                      return _bottomSheetView(
                          categoryProductListingController);
                    });
              }
            });
          },
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageConstanst.locationPinIcon,
                    color: Color(0xFF838383),
                    height: 16,
                    width: 16,
                  ),
                  3.widthBox,
                  Text(
                    categoryProductListingController.isLogin
                        ? categoryProductListingController
                        .address.isNotEmpty
                        ? categoryProductListingController
                        .address
                        : 'Select Delivery Address'
                        : 'Select Delivery Address',
                    style: TextStyle(
                        color: Color(0xFF838383), fontSize: 12),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 16,
                  ),
                  5.widthBox
                ],
              ))),
      10.heightBox,
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              '${categoryProductListingController.categoryName} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xFF5A5A5A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
                      Text(
                        '(${categoryProductListingController.productList.length} ${LocaleKeys.items.tr})',
                        style: TextStyle(
                            color: Color(0xFF838383), fontSize: 14),
                      ),
                    ],
                  )),
              5.widthBox,
              Wrap(
                children: [
                  InkWell(
                      onTap: () {
                        categoryProductListingController
                            .navigateTo(CategoryFilterScreen(
                          catSlug:
                          categoryProductListingController
                              .categorySlug,
                          catName:
                          categoryProductListingController
                              .categoryName,
                          catId: categoryProductListingController
                              .categoryId,
                        ));
                      },
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                              crossAxisAlignment:
                              WrapCrossAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageConstanst.filterIcon,
                                  height: 16,
                                  width: 16,
                                ),
                                5.widthBox,
                                Text(
                                  LocaleKeys.filter.tr,
                                  style: TextStyle(
                                      color: Color(0xFF838383),
                                      fontSize: 13),
                                ),
                              ]))),
                  10.widthBox,
                  InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                            context:
                            categoryProductListingController
                                .context,
                            builder: (BuildContext context) {
                              return _bestMatchBottomSheetView();
                            });
                      },
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            crossAxisAlignment:
                            WrapCrossAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  ImageConstanst.bestMatchIcon,
                                  height: 16,
                                  width: 16),
                              5.widthBox,
                              Text(
                                LocaleKeys.bestMatch.tr,
                                style: TextStyle(
                                    color: Color(0xFF838383),
                                    fontSize: 13),
                              )
                            ],
                          )))
                ],
              )
            ],
          )),
          Expanded(
      child: Center(
          child: Text(
            'No Records',
            style: TextStyle(
                color: Color(0xFF414141),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
    )]))
        :Flexible(
            child: Container(
                color: Color(0xFFF3F3F3),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      if (categoryProductListingController.next != 0) {
                        if (widget.fromFilter) {
                          categoryProductListingController
                              .loadMoreFilter(language);
                        } else {
                          categoryProductListingController.loadMore(language);
                        }
                      }
                    }
                    return false;
                  },
                  child: Column( children: <Widget>[
                    InkWell(
                        onTap: () {
                          MySharedPreferences.instance
                              .getBoolValuesSF(SharedPreferencesKeys
                                  .addressFromCurrentLocation)
                              .then((value) async {
                            if (value != null)
                              categoryProductListingController
                                  .addressFromCurrentLocation = value;

                            if (categoryProductListingController.isLogin) {
                              categoryProductListingController
                                  .getAddressList(language)
                                  .then((value) => showModalBottomSheet<void>(
                                      context: categoryProductListingController
                                          .context,
                                      builder: (BuildContext context) {
                                        return _bottomSheetView(
                                            categoryProductListingController);
                                      }));
                            } else {
                              showModalBottomSheet<void>(
                                  context:
                                      categoryProductListingController.context,
                                  builder: (BuildContext context) {
                                    return _bottomSheetView(
                                        categoryProductListingController);
                                  });
                            }
                          });
                        },
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageConstanst.locationPinIcon,
                                  color: Color(0xFF838383),
                                  height: 16,
                                  width: 16,
                                ),
                                3.widthBox,
                                Text(
                                  categoryProductListingController.isLogin
                                      ? categoryProductListingController
                                              .address.isNotEmpty
                                          ? categoryProductListingController
                                              .address
                                          : 'Select Delivery Address'
                                      : 'Select Delivery Address',
                                  style: TextStyle(
                                      color: Color(0xFF838383), fontSize: 12),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 16,
                                ),
                                5.widthBox
                              ],
                            ))),
                    10.heightBox,
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        '${categoryProductListingController.categoryName} ',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))),
                                Text(
                                  '(${categoryProductListingController.productList.length} ${LocaleKeys.items.tr})',
                                  style: TextStyle(
                                      color: Color(0xFF838383), fontSize: 14),
                                ),
                              ],
                            )),
                            5.widthBox,
                            Wrap(
                              children: [
                                InkWell(
                                    onTap: () {
                                      categoryProductListingController
                                          .navigateTo(CategoryFilterScreen(
                                        catSlug:
                                            categoryProductListingController
                                                .categorySlug,
                                        catName:
                                            categoryProductListingController
                                                .categoryName,
                                        catId: categoryProductListingController
                                            .categoryId,
                                      ));
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(5),
                                        child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                ImageConstanst.filterIcon,
                                                height: 16,
                                                width: 16,
                                              ),
                                              5.widthBox,
                                              Text(
                                                LocaleKeys.filter.tr,
                                                style: TextStyle(
                                                    color: Color(0xFF838383),
                                                    fontSize: 13),
                                              ),
                                            ]))),
                                10.widthBox,
                                InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                          context:
                                              categoryProductListingController
                                                  .context,
                                          builder: (BuildContext context) {
                                            return _bestMatchBottomSheetView();
                                          });
                                    },
                                    child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(5),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                ImageConstanst.bestMatchIcon,
                                                height: 16,
                                                width: 16),
                                            5.widthBox,
                                            Text(
                                              LocaleKeys.bestMatch.tr,
                                              style: TextStyle(
                                                  color: Color(0xFF838383),
                                                  fontSize: 13),
                                            )
                                          ],
                                        )))
                              ],
                            )
                          ],
                        )),
              Expanded(child: SingleChildScrollView(
                  child:  Padding(
                            padding: EdgeInsets.symmetric(
                                 horizontal: 15),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: categoryProductListingController
                                  .productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2,
                                      childAspectRatio: 0.66),
                              itemBuilder: (ctx, i) {
                                return InkWell(
                                    onTap: () {
                                      print(
                                          'njjjj........${categoryProductListingController.productList[i].productSlug}');

                                      categoryProductListingController
                                          .navigateToProductDetailScreen(
                                              categoryProductListingController
                                                  .productList[i].id!,
                                              categoryProductListingController
                                                  .productList[i].productSlug!);
                                    },
                                    child: CategoryProductListingContainer(
                                      productData:
                                          categoryProductListingController
                                              .productList[i],
                                    ));
                              },
                            )))),
                    15.heightBox
                  ]),
                )));
  }

  _bottomSheetView(
      CategoryProductListingController categoryProductListingController) {
    return GetBuilder<CategoryProductListingController>(
        init: CategoryProductListingController(),
        builder: (contet) {
          return Container(
              height: categoryProductListingController.isLogin ? 350 : 200,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Text(
                    LocaleKeys.chooseLocation.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  10.heightBox,
                  Text(
                    LocaleKeys.chooseLocationText.tr,
                    style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                  ),
                  20.heightBox,
                  categoryProductListingController.isLogin
                      ? Column(children: [
                          Visibility(
                            visible: categoryProductListingController.loading,
                            child: CircularProgressBar(),
                          ),
                          Visibility(
                            visible:
                                !categoryProductListingController.loading &&
                                    categoryProductListingController
                                            .addressList.length ==
                                        0,
                            child: InkWell(
                                onTap: () {
                                  categoryProductListingController.pop();
                                  categoryProductListingController
                                      .navigateTo(YourAddressesScreen());
                                },
                                child: Container(
                                    width: 150,
                                    height: 160,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColors.lightBlue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                    child: Center(
                                        child: Text(
                                            LocaleKeys.addAddressText.tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.bold))))),
                          ),
                          Visibility(
                              visible:
                                  !categoryProductListingController.loading &&
                                      categoryProductListingController
                                              .addressList.length >
                                          0,
                              child: Container(
                                  height: 170,
                                  child: ListView.builder(
                                      itemCount:
                                          categoryProductListingController
                                                  .addressList.length +
                                              1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return (index !=
                                                categoryProductListingController
                                                    .addressList.length)
                                            ? InkWell(
                                                onTap: () {
                                                  Address address =
                                                      categoryProductListingController
                                                          .addressList[index];
                                                  MySharedPreferences.instance
                                                      .addStringToSF(
                                                          SharedPreferencesKeys
                                                              .address,
                                                          "${address.cityName} - ${address.zip}");
                                                  MySharedPreferences.instance
                                                      .addStringToSF(
                                                          SharedPreferencesKeys
                                                              .addressId,
                                                          address.id
                                                              .toString());
                                                  MySharedPreferences.instance
                                                      .addBoolToSF(
                                                          SharedPreferencesKeys
                                                              .addressFromCurrentLocation,
                                                          false);

                                                  categoryProductListingController
                                                      .editAddress(
                                                          address.id,
                                                          address.fullname,
                                                          address.address1,
                                                          address.address2,
                                                          address.landmark,
                                                          address.countryCode,
                                                          address.stateCode,
                                                          address.cityCode,
                                                          address.zip,
                                                          address.mobile1,
                                                          address.addressType,
                                                          address
                                                              .deliveryInstruction,
                                                          '1',
                                                          language);
                                                },
                                                child: AddressContainer(
                                                  address:
                                                      categoryProductListingController
                                                          .addressList[index],
                                                  addressFromCurrentLocation:
                                                      categoryProductListingController
                                                          .addressFromCurrentLocation,
                                                ))
                                            : InkWell(
                                                onTap: () {
                                                  categoryProductListingController
                                                      .pop();
                                                  categoryProductListingController
                                                      .navigateTo(
                                                          YourAddressesScreen());
                                                },
                                                child: Container(
                                                    width: 150,
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .lightBlue),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                                    child: Center(
                                                        child: Text(LocaleKeys.addAddressText.tr,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: AppColors.primaryColor,
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.bold)))));
                                      }))),
                          10.heightBox,
                          InkWell(
                              onTap: () {
                                getAddress();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.gps_fixed,
                                    color: AppColors.primaryColor,
                                  ),
                                  5.widthBox,
                                  Text(
                                    'Use my current location',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16),
                                  ),
                                ],
                              ))
                        ])
                      : CustomButton(
                          text: 'Sign in to see your Addresses',
                          fontSize: 16,
                          onPressed: () {
                            Get.deleteAll();
                            categoryProductListingController.navigateTo(
                                LoginScreen(
                                    from: SharedPreferencesKeys.isDrawer));
                          }),
                ],
              ));
        });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String location = 'Null, Press Button';
  String addressData = 'search';

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    addressData =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    MySharedPreferences.instance.addStringToSF(SharedPreferencesKeys.address,
        "${place.locality} - ${place.postalCode}");
    MySharedPreferences.instance
        .addBoolToSF(SharedPreferencesKeys.addressFromCurrentLocation, true);

    //Get.delete<categoryProductListingController>();
    Navigator.of(context).pop(true);
    /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProductListingScreen(
              from: categoryProductListingController.from,
              searchString: categoryProductListingController.searchedString,
            )));
    categoryProductListingController.update();*/
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      categoryProductListingController.address = value!;
      categoryProductListingController.update();
    });
  }

  getAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  _bestMatchBottomSheetView() {
    return GetBuilder<CategoryProductListingController>(
        init: CategoryProductListingController(),
        builder: (contet) {
          return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.bestMatch.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomButton(
                          width: 80,
                          horizontalPadding: 5,
                          text: LocaleKeys.apply.tr,
                          fontSize: 14,
                          onPressed: () {
                            categoryProductListingController.popp();
                            if(categoryProductListingController.val==1){
                              categoryProductListingController.getBestMatchResult("product_name", "asc", language);
                            }else if(categoryProductListingController.val==2){
                              categoryProductListingController.getBestMatchResult("final_price", "asc", language);
                            }else if(categoryProductListingController.val==3){
                              categoryProductListingController.getBestMatchResult("final_price", "desc", language);
                            }else if(categoryProductListingController.val==4){
                              categoryProductListingController.getBestMatchResult("reviews_avg", "desc", language);
                            }else if(categoryProductListingController.val==5){
                              categoryProductListingController.getBestMatchResult("created_at", "desc", language);
                            }
                          })
                    ],
                  ),
                  10.heightBox,
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 1,
                    groupValue: categoryProductListingController.val,
                    activeColor: Color(0xFF1992CE),
                    onChanged: (int? value) {
                      categoryProductListingController.val = value!;
                      categoryProductListingController.update();
                    },
                    title: Text(
                      'Product Name',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 2,
                    activeColor: Color(0xFF1992CE),
                    groupValue: categoryProductListingController.val,
                    onChanged: (int? value) {
                      categoryProductListingController.val = value!;
                      categoryProductListingController.update();
                    },
                    title: Text(
                      LocaleKeys.lowToHigh.tr,
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 3,
                    activeColor: Color(0xFF1992CE),
                    groupValue: categoryProductListingController.val,
                    onChanged: (int? value) {
                      categoryProductListingController.val = value!;
                      categoryProductListingController.update();
                    },
                    title: Text(
                      LocaleKeys.highToLow.tr,
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 4,
                    activeColor: Color(0xFF1992CE),
                    groupValue: categoryProductListingController.val,
                    onChanged: (int? value) {
                      categoryProductListingController.val = value!;
                      categoryProductListingController.update();
                    },
                    title: Text(
                      'Avg. Customer Review',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 5,
                    activeColor: Color(0xFF1992CE),
                    groupValue: categoryProductListingController.val,
                    onChanged: (int? value) {
                      categoryProductListingController.val = value!;
                      categoryProductListingController.update();
                    },
                    title: Text(
                      'Newest Arrival',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                ],
              ));
        });
  }

  Widget topView(
      CategoryProductListingController categoryProductListingController) {
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
                        categoryProductListingController.exitScreen();
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
                widget.categoryName!,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
