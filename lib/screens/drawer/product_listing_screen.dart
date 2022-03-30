import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tmween/model/search_history_model.dart';
import 'package:tmween/screens/drawer/dashboard/search_container.dart';
import 'package:tmween/screens/drawer/filter_screen.dart';
import 'package:tmween/screens/drawer/profile/your_addresses_screen.dart';
import 'package:tmween/utils/extensions.dart';

import '../../controller/product_listing_controller.dart';
import '../../controller/search_controller.dart';
import '../../lang/locale_keys.g.dart';
import '../../model/get_customer_address_list_model.dart';
import '../../utils/global.dart';
import '../../utils/my_shared_preferences.dart';
import '../../utils/views/circular_progress_bar.dart';
import '../../utils/views/custom_button.dart';
import '../../utils/views/custom_text_form_field.dart';
import '../authentication/login/login_screen.dart';
import 'address_container.dart';
import 'dashboard/product_detail_screen.dart';

class ProductListingScreen extends StatefulWidget {

  final String? from;
  final String? searchString;

  ProductListingScreen({Key? key, required this.from,required this.searchString}) : super(key: key);

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
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      productListingController.isLogin = value!;
      productListingController.searchedString = widget.searchString!;
      productListingController.searchController.text = widget.searchString!;
      if(productListingController.isLogin){
        MySharedPreferences.instance
            .getStringValuesSF(SharedPreferencesKeys.token)
            .then((value) async {
          productListingController.token = value!;
          print('dhsh.....${productListingController.token}');
          MySharedPreferences.instance
              .getIntValuesSF(SharedPreferencesKeys.userId)
              .then((value) async {
            productListingController.userId = value!;
            productListingController.getProductList(productListingController.searchedString,Get.locale!.languageCode);
            MySharedPreferences.instance
                .getIntValuesSF(SharedPreferencesKeys.loginLogId)
                .then((value) async {
              productListingController.loginLogId = value!;
            });
          });
        });
      }else{
        productListingController.getProductList(productListingController.searchedString,Get.locale!.languageCode);
      }
      productListingController.update();
    });
    super.initState();
  }

  Future<bool> _onWillPop(ProductListingController productListingController) async {
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
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                            height: 40,
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15),
                            child: InkWell(
                                onTap: () {
                                  productListingController.navigateToSearchScreen(
                                 SharedPreferencesKeys.isDrawer,
                                  );
                                },
                                child: CustomTextFormField(
                                    isDense: true,
                                    enabled: false,
                                    controller:
                                    productListingController.searchController,
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
                                    })))),
                   _productList(productListingController)
                  ],
                ),
              )));
        });
  }

  _productList(ProductListingController productListingController) {
    return productListingController.searchLoading
        ? CircularProgressBar()
        : !productListingController.searchLoading &&
        productListingController.productList.length == 0?
    Expanded(
      child: Center(
          child: Text(
            'No Records',
            style: TextStyle(
                color: Color(0xFF414141),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
    )
    :Flexible(
            child: Container(
            color: Color(0xFFF3F3F3),
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
              InkWell(
                  onTap: () {
            if (productListingController.isLogin) {
              productListingController.getAddressList(language);
            }
                    showModalBottomSheet<void>(
                        context: productListingController.context,
                        builder: (BuildContext context) {
                          return _bottomSheetView(productListingController);
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
                      Expanded(child:

                      RichText(

                        text:TextSpan(
                        text:'${productListingController.searchedString} ',
                    style: TextStyle(
                        color: Color(0xFF5A5A5A),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text:'(${productListingController.productList.length} ${LocaleKeys.items.tr})',
                            style: TextStyle(
                                color: Color(0xFF838383), fontSize: 14),
                          ),
                        ]
                  ),),
                     ),
                      Wrap(
                        children: [
                          InkWell(
                              onTap: () {
                                productListingController.navigateTo(FilterScreen());
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
                                    context: productListingController.context,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: NotificationListener<ScrollNotification>(
                  onNotification:
                      (ScrollNotification scrollInfo) {
                    if (scrollInfo is ScrollEndNotification &&
                        scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                      if (productListingController.next != 0) {
                        productListingController.loadMore(language);
                      }
                    }
                    return false;
                  },
                  child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: productListingController.productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.66),
                  itemBuilder: (ctx, i) {
                    return InkWell(
                        onTap: () {
                          productListingController.navigateTo(ProductDetailScreen());
                        },
                        child: SearchContainer(
                          productData: productListingController.productList[i],
                        ));
                  },
                )),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  15.widthBox,
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Center(
                        child: Text(
                      LocaleKeys.previous.tr,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 14),
                    )),
                  )),
                  10.widthBox,
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Center(
                        child: Text(
                      LocaleKeys.next.tr,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )),
                  )),
                  15.widthBox
                ],
              ),*/
              15.heightBox
            ]),
          ));
  }

  _bottomSheetView(ProductListingController productListingController) {
    return GetBuilder<ProductListingController>(
        init: ProductListingController(),
        builder: (contet) {
          return Container(
              height: productListingController.isLogin?310:200,
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
          ? Column(
          children: [Visibility(
                    visible: productListingController.loading,
                    child: CircularProgressBar(),
                  ),
                  Visibility(
                    visible: !productListingController.loading &&
                        productListingController.addressList.length == 0,
                    child: InkWell(
                        onTap: () {
                          productListingController.pop();
                          productListingController.navigateTo(YourAddressesScreen());
                        },
                        child: Container(
                            width: 150,
                            height: 160,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.lightBlue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Center(
                                child: Text(LocaleKeys.addAddressText.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))))),
                  ),
                  Visibility(
                      visible: !productListingController.loading &&
                          productListingController.addressList.length > 0,
                      child: Container(
                          height: 170,
                          child: ListView.builder(
                              itemCount:
                                  productListingController.addressList.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return (index !=
                                        productListingController.addressList.length)
                                    ? InkWell(
                                        onTap: () {
                                          Address address = productListingController
                                              .addressList[index];
                                          productListingController.editAddress(
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
                                              address.deliveryInstruction,
                                              '1',
                                              language);
                                        },
                                        child: AddressContainer(
                                            address: productListingController
                                                .addressList[index]))
                                    : InkWell(
                                        onTap: () {
                                          productListingController.pop();
                                          productListingController.navigateTo(
                                              YourAddressesScreen());
                                        },
                                        child: Container(
                                            width: 150,
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
                                                    LocaleKeys
                                                        .addAddressText.tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight
                                                            .bold)))));
                              })))])
              :CustomButton(
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
                    value: 4,
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
