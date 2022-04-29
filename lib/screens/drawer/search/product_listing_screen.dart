import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/profile/address/your_addresses_screen.dart';
import 'package:tmween/screens/drawer/search/filter_screen.dart';
import 'package:tmween/screens/drawer/search/search_container.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/product_listing_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../model/get_customer_address_list_model.dart';
import '../../../utils/global.dart';
import '../../../utils/my_shared_preferences.dart';
import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/custom_button.dart';
import '../../../utils/views/custom_text_form_field.dart';
import '../../authentication/login/login_screen.dart';
import '../address_container.dart';

class ProductListingScreen extends StatefulWidget {
  final String? from;
  final String? searchString;
  final bool fromFilter;
  final int? fromPrice;
  final int? toPrice;
  final int? fullFillByTmween;
  final List<String>? catIdList;
  final List<String>? brandIdList;
  final List<String>? sellerIdList;

  ProductListingScreen(
      {Key? key, required this.from, required this.searchString, this.fromFilter = false,
        this.fromPrice,
        this.toPrice,
        this.fullFillByTmween,
        this.catIdList,
        this.brandIdList,
        this.sellerIdList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductListingScreenState();
  }
}

class ProductListingScreenState extends State<ProductListingScreen> {
  final productListingController = Get.put(ProductListingController());
  late var language;

  @override
  void initState() {
    productListingController.from = widget.from!;
    productListingController.searchedString = widget.searchString!;
    productListingController.fromFilter = widget.fromFilter;

    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      productListingController.isLogin = value!;

      productListingController.searchController.text = widget.searchString!;
      if (productListingController.isLogin) {
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.token)
            .then((value) async {
          productListingController.token = value!;
          print('dhsh.....${productListingController.token}');
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.userId)
              .then((value) async {
            productListingController.userId = value!;
            if (productListingController.fromFilter) {
              productListingController.fromPrice = widget.fromPrice;
              productListingController.toPrice = widget.toPrice;
              productListingController.fullFillByTmween = widget.fullFillByTmween;
              productListingController.catIdList = widget.catIdList;
              productListingController.brandIdList = widget.brandIdList;
              productListingController.sellerIdList =
                  widget.sellerIdList;
              productListingController.getFilterResult(language);
            } else {
              productListingController.getProductList(
                  productListingController.searchedString,
                  Get.locale!.languageCode);
            }
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              productListingController.loginLogId = value!;
            });
          });
        });
      } else {
        if (productListingController.fromFilter) {
          productListingController.fromPrice = widget.fromPrice;
          productListingController.toPrice = widget.toPrice;
          productListingController.catIdList = widget.catIdList;
          productListingController.brandIdList = widget.brandIdList;
          productListingController.sellerIdList = widget.sellerIdList;
          productListingController.getFilterResult(language);
        } else {
          productListingController.getProductList(
              productListingController.searchedString,
              Get.locale!.languageCode);
        }
      }
      productListingController.update();
    });
    super.initState();
  }

  Future<bool> _onWillPop(
      ProductListingController productListingController) async {
    productListingController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<ProductListingController>(
        init: ProductListingController(),
        builder: (contet) {
          productListingController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(productListingController),
              child: Scaffold(
                  body: Form(
                key: productListingController.formKey,
                child: Column(
                  children: [
                    Container(
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 35),
                        child: Row(children: [
                          10.widthBox,
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: language == 'ar'
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: /*ClipOval(
                                        child: Material(
                                          color: Colors.white, // Button color
                                          child:*/
                                  InkWell(
                                onTap: () {
                                  productListingController.exitScreen();
                                },
                                child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                              ),
                            ), /* ))*/
                          ),
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2)),
                                  height: 40,
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 15, right: 15),
                                  child: InkWell(
                                      onTap: () {
                                        productListingController
                                            .navigateToSearchScreen(
                                          SharedPreferencesKeys.isDrawer,
                                        );
                                      },
                                      child: CustomTextFormField(
                                          isDense: true,
                                          enabled: false,
                                          controller: productListingController
                                              .searchController,
                                          keyboardType: TextInputType.text,
                                          hintText:
                                              LocaleKeys.searchProducts.tr,
                                          textInputAction:
                                              TextInputAction.search,
                                          onSubmitted: (term) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppColors.lightGrayColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppColors.lightGrayColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      AppColors.lightGrayColor),
                                            ),
                                            isDense: true,
                                            hintText:
                                                LocaleKeys.searchProducts.tr,
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: AppColors.primaryColor,
                                              size: 32,
                                            ),
                                          ),
                                          validator: (value) {
                                            return null;
                                          }))))
                        ])),
                    _productList(productListingController)
                  ],
                ),
              )));
        });
  }

  _productList(ProductListingController productListingController) {
    bool isData=false;
    if(productListingController.fromFilter)
      isData = !productListingController.searchLoading &&
          productListingController
              .productFilterList.length ==
              0;
    else
      isData = !productListingController.searchLoading &&
        productListingController
            .productList.length ==
            0;

    return  isData
        ? Expanded(child: Column(children: [
      InkWell(
          onTap: () {
            MySharedPreferences.instance
                .getBoolValuesSF(SharedPreferencesKeys
                .addressFromCurrentLocation)
                .then((value) async {
              if (value != null)
                productListingController
                    .addressFromCurrentLocation = value;

              if (productListingController.isLogin) {
                productListingController
                    .getAddressList(language)
                    .then((value) => showModalBottomSheet<void>(
                    context: productListingController
                        .context,
                    builder: (BuildContext context) {
                      return _bottomSheetView(
                          productListingController);
                    }));
              } else {
                showModalBottomSheet<void>(
                    context:
                    productListingController.context,
                    builder: (BuildContext context) {
                      return _bottomSheetView(
                          productListingController);
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
                    productListingController.isLogin
                        ? productListingController
                        .address.isNotEmpty
                        ? productListingController
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
                              '${productListingController.searchedString} ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xFF5A5A5A),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold))),
                      Text(
                      productListingController.fromFilter?  '(${productListingController.productFilterList.length} ${LocaleKeys.items.tr})':'(${productListingController.productList.length} ${LocaleKeys.items.tr})',
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
                        productListingController.navigateTo(
                            FilterScreen(
                                from:productListingController.from,
                                searchedString:productListingController.searchedString,
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
                            productListingController
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
        : Flexible(
                child: Container(
                color: Color(0xFFF3F3F3),
                child:NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo is ScrollEndNotification &&
                scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
                if (productListingController.next != 0) {
                if (productListingController.fromFilter) {
                  productListingController
                      .loadMoreFilter(language);
                } else {
                  productListingController.loadMore(language);
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
                            productListingController
                                .addressFromCurrentLocation = value;

                          if (productListingController.isLogin) {
                            productListingController
                                .getAddressList(language)
                                .then((value) => showModalBottomSheet<void>(
                                    context: productListingController.context,
                                    builder: (BuildContext context) {
                                      return _bottomSheetView(
                                          productListingController);
                                    }));
                          } else {
                            showModalBottomSheet<void>(
                                context: productListingController.context,
                                builder: (BuildContext context) {
                                  return _bottomSheetView(
                                      productListingController);
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
                                productListingController.isLogin
                                    ? productListingController
                                            .address.isNotEmpty
                                        ? productListingController.address
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
                          Expanded(child: Row(children: [
                            Expanded(child: Text('${productListingController.searchedString} ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xFF5A5A5A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                            Text(

                              productListingController.fromFilter?
                              '(${productListingController.productFilterList.length} ${LocaleKeys.items.tr})':
                              '(${productListingController.productList.length} ${LocaleKeys.items.tr})',
                              style: TextStyle(
                                  color: Color(0xFF838383),
                                  fontSize: 14),
                            ),
                          ],)),
                          5.widthBox,
                          Wrap(
                            children: [
                              InkWell(
                                  onTap: () {
                                    productListingController.navigateTo(
                                        FilterScreen(
                                          from:productListingController.from,
                                            searchedString:productListingController.searchedString,
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
                                            productListingController.context,
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child:  GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount:
                           productListingController.fromFilter?
                           productListingController.productFilterList.length:
                           productListingController.productList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  childAspectRatio: 0.66),
                          itemBuilder: (ctx, i) {
                            return InkWell(
                                onTap: () {
                                 if( productListingController.fromFilter)
                                  print(
                                      'njjjj........${productListingController.productFilterList[i].productSlug}');
                                 else print(
                                      'njjjj........${productListingController.productList[i].productSlug}');

                                  productListingController
                                      .navigateToProductDetailScreen(
                                          productListingController
                                              .productList[i].id!,
                                          productListingController
                                              .productList[i].productSlug!);
                                },
                                child: SearchContainer(
                                  productData:
                                  !productListingController.fromFilter?
                                      productListingController.productList[i]:
                                    null,
                                  fromFilter:
                                    productListingController.fromFilter,
                                  productFilterData:
                                    productListingController.fromFilter?
                                    productListingController.productFilterList[i]:null
                                ));
                          },
                        )))),

                  15.heightBox
                ]),
              )));
  }

  _bottomSheetView(ProductListingController productListingController) {
    return GetBuilder<ProductListingController>(
        init: ProductListingController(),
        builder: (contet) {
          return Container(
              height: productListingController.isLogin ? 350 : 200,
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
                  productListingController.isLogin
                      ? Column(children: [
                          Visibility(
                            visible: productListingController.loading,
                            child: CircularProgressBar(),
                          ),
                          Visibility(
                            visible: !productListingController.loading &&
                                productListingController.addressList.length ==
                                    0,
                            child: InkWell(
                                onTap: () {
                                  productListingController.pop();
                                  productListingController
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
                              visible: !productListingController.loading &&
                                  productListingController.addressList.length >
                                      0,
                              child: Container(
                                  height: 170,
                                  child: ListView.builder(
                                      itemCount: productListingController
                                              .addressList.length +
                                          1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return (index !=
                                                productListingController
                                                    .addressList.length)
                                            ? InkWell(
                                                onTap: () {
                                                  Address address =
                                                      productListingController
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
                                                      address.id.toString());
                                                  MySharedPreferences.instance
                                                      .addBoolToSF(
                                                          SharedPreferencesKeys
                                                              .addressFromCurrentLocation,
                                                          false);

                                                  productListingController
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
                                                      productListingController
                                                          .addressList[index],
                                                  addressFromCurrentLocation:
                                                      productListingController
                                                          .addressFromCurrentLocation,
                                                ))
                                            : InkWell(
                                                onTap: () {
                                                  productListingController
                                                      .pop();
                                                  productListingController
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
                                                        borderRadius:
                                                            BorderRadius.all(
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
                            productListingController.navigateTo(LoginScreen(
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

    //Get.delete<ProductListingController>();
    Navigator.of(context).pop(true);
    /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProductListingScreen(
              from: productListingController.from,
              searchString: productListingController.searchedString,
            )));
    productListingController.update();*/
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.address)
        .then((value) async {
      productListingController.address = value!;
      productListingController.update();
    });
  }

  getAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  _bestMatchBottomSheetView() {
    return GetBuilder<ProductListingController>(
        init: ProductListingController(),
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
                            productListingController.popp();
                            if(productListingController.val==1){
                              productListingController.getBestMatchResult("product_name", "asc", language);
                            }else if(productListingController.val==2){
                              productListingController.getBestMatchResult("final_price", "asc", language);
                            }else if(productListingController.val==3){
                              productListingController.getBestMatchResult("final_price", "desc", language);
                            }else if(productListingController.val==4){
                              productListingController.getBestMatchResult("reviews_avg", "desc", language);
                            }else if(productListingController.val==5){
                              productListingController.getBestMatchResult("created_at", "desc", language);
                            }
                          })
                    ],
                  ),
                  10.heightBox,
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 1,
                    groupValue: productListingController.val,
                    activeColor: Color(0xFF1992CE),
                    onChanged: (int? value) {
                      productListingController.val = value!;
                      productListingController.update();
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
                    groupValue: productListingController.val,
                    onChanged: (int? value) {
                      productListingController.val = value!;
                      productListingController.update();
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
                    groupValue: productListingController.val,
                    onChanged: (int? value) {
                      productListingController.val = value!;
                      productListingController.update();
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
                    groupValue: productListingController.val,
                    onChanged: (int? value) {
                      productListingController.val = value!;
                      productListingController.update();
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
                    groupValue: productListingController.val,
                    onChanged: (int? value) {
                      productListingController.val = value!;
                      productListingController.update();
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
}
