import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/dashboard/search_container.dart';
import 'package:tmween/screens/drawer/filter_screen.dart';
import 'package:tmween/screens/drawer/profile/add_address_screen.dart';
import 'package:tmween/screens/drawer/profile/your_addresses_screen.dart';
import 'package:tmween/utils/extensions.dart';

import '../../controller/search_controller.dart';
import '../../lang/locale_keys.g.dart';
import '../../model/get_customer_address_list_model.dart';
import '../../utils/global.dart';
import '../../utils/views/circular_progress_bar.dart';
import '../../utils/views/custom_button.dart';
import 'address_container.dart';
import 'dashboard/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final searchController = Get.put(SearchController());
  late var language;
  final String? from;

  SearchScreen({Key? key, required this.from}) : super(key: key);


  Future<bool> _onWillPop(SearchController searchController) async {
    searchController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (contet) {
          searchController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(searchController),
          child:Scaffold(
              body: Form(
            key: searchController.formKey,
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
                        margin:
                            EdgeInsets.only(bottom: 10, left: 15, right: 15),
                        child: TypeAheadFormField<String>(
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: from == AppConstants.bottomBar
                                ? searchController.searchController2
                                : searchController.searchController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (term) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.lightGrayColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.lightGrayColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.lightGrayColor),
                              ),
                              isDense: true,
                              hintText: LocaleKeys.searchProducts.tr,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primaryColor,
                                size: 32,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    searchController.searchController.clear();
                                    searchController.update();
                                  },
                                  icon: Icon(
                                    CupertinoIcons.clear_circled_solid,
                                    color: AppColors.primaryColor,
                                    size: 24,
                                  )),
                            ),
                          ),
                          suggestionsCallback: (String pattern) async {
                            return searchController.items
                                .where((item) => item
                                    .toLowerCase()
                                    .startsWith(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          onSuggestionSelected: (String suggestion) {
                            searchController.visibleList = true;
                            searchController.searchController.text = suggestion;
                            searchController.update();
                          },
                        ))),
                Visibility(
                    visible: !searchController.visibleList,
                    child: _searchHistory(searchController)),
                Visibility(
                    visible: searchController.visibleList,
                    child: _productList(searchController))
              ],
            ),
          )));
        });
  }

  _productList(SearchController searchController) {
    return Flexible(
        child: Container(
      color: Color(0xFFF3F3F3),
      child: ListView(children: <Widget>[
        InkWell(
            onTap: () {
              searchController.getAddressList(language);
              showModalBottomSheet<void>(
                  context: searchController.context,
                  builder: (BuildContext context) {
                    return _bottomSheetView(searchController);
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
                      '1999 Bluff Street MOODY Alabama - 35004',
                      style: TextStyle(color: Color(0xFF838383), fontSize: 12),
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
                Wrap(
                  children: [
                    Text(
                      'Furniture',
                      style: TextStyle(
                          color: Color(0xFF5A5A5A),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(8 ${LocaleKeys.items.tr})',
                      style: TextStyle(color: Color(0xFF838383), fontSize: 14),
                    ),
                  ],
                ),
                Wrap(
                  children: [
                    InkWell(
                        onTap: () {
                          searchController.navigateTo(FilterScreen());
                        },
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                                        color: Color(0xFF838383), fontSize: 13),
                                  ),
                                ]))),
                    10.widthBox,
                    InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: searchController.context,

                              builder: (BuildContext context) {
                                return _bestMatchBottomSheetView();
                              });
                        },
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                SvgPicture.asset(ImageConstanst.bestMatchIcon,
                                    height: 16, width: 16),
                                5.widthBox,
                                Text(
                                  LocaleKeys.bestMatch.tr,
                                  style: TextStyle(
                                      color: Color(0xFF838383), fontSize: 13),
                                )
                              ],
                            )))
                  ],
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: searchController.recentlVieweds.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.66),
            itemBuilder: (ctx, i) {
              return InkWell(
                  onTap: () {
                    searchController.navigateTo(ProductDetailScreen());
                  },
                  child: SearchContainer(
                    recentlyViewed: searchController.recentlVieweds[i],
                  ));
            },
          ),
        ),
        Row(
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
                style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
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
        ),
        15.heightBox
      ]),
    ));
  }

  _searchHistory(SearchController searchController) {
    return Flexible(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.searchHistory.tr,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF585858)),
                        ),
                        InkWell(
                            onTap: () {
                              // searchController.historyList.clear();
                              // searchController.update();
                            },
                            child: Text(
                              LocaleKeys.clear.tr,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF585858)),
                            )),
                      ],
                    ),
                    10.heightBox,
                    Wrap(
                        spacing: 10,
                        children: List.generate(
                            searchController.historyList.length,
                            (index) => InkWell(
                                onTap: () {
                                  searchController.searchController.text =
                                      searchController.historyList[index];
                                  searchController.visibleList = true;
                                  searchController.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[300]!,
                                            blurRadius: 3,
                                            spreadRadius: 3)
                                      ]),
                                  child: Text(
                                    searchController.historyList[index],
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        color: Color(0xFF5B5B5B)),
                                  ),
                                )))),
                    30.heightBox,
                    Text(
                      LocaleKeys.popularSearch.tr,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF585858)),
                    ),
                    10.heightBox,
                    Wrap(
                      spacing: 10,
                      children: <Widget>[
                        for (var item in searchController.popularSearchList)
                          InkWell(
                              onTap: () {
                                searchController.searchController.text = item;
                                searchController.visibleList = true;
                                searchController.update();
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300]!,
                                          blurRadius: 3,
                                          spreadRadius: 3)
                                    ]),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 12.5, color: Color(0xFF5B5B5B)),
                                ),
                              )),
                      ],
                    ),
                  ],
                ))));
  }

  _bottomSheetView(SearchController searchController) {
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (contet) {
          return Container(
              height: 310,
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
                  Visibility(
                    visible: searchController.loading,
                    child: CircularProgressBar(),
                  ),
                  Visibility(
                    visible: !searchController.loading &&
                        searchController.addressList.length == 0,
                    child: InkWell(
                        onTap: () {
                          searchController.pop();
                          searchController.navigateTo(YourAddressesScreen());
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
                      visible: !searchController.loading &&
                          searchController.addressList.length > 0,
                      child: Container(
                      height: 170,
                      child: ListView.builder(
                          itemCount: searchController.addresses.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return (index != searchController.addressList.length)
                                ? InkWell(
                                onTap:(){
                                  Address address = searchController.addressList[index];
                                  searchController.editAddress(address.id,address.fullname,
                                      address.address1,address.address2,address.landmark,address.countryCode,
                                      address.stateCode,address.cityCode,address.zip,address.mobile1,address.addressType,
                                      address.deliveryInstruction,
                                      '1',
                                      language);
                                },
                                child:AddressContainer(
                                    address: searchController.addressList[index]))
                                : InkWell(
                                    onTap: () {
                                      searchController.pop();
                                      searchController
                                          .navigateTo(YourAddressesScreen());
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
                                                LocaleKeys.addAddressText.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)))));
                          })))
                ],
              ));
        });
  }

  _bestMatchBottomSheetView() {
    return GetBuilder<SearchController>(
        init: SearchController(),
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
                            searchController.popp();
                          })
                    ],
                  ),
                  10.heightBox,
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 1,
                    groupValue: searchController.val,
                    activeColor: Color(0xFF1992CE),
                    onChanged: (int? value) {
                      searchController.val = value!;
                      searchController.update();
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
                    groupValue: searchController.val,
                    onChanged: (int? value) {
                      searchController.val = value!;
                      searchController.update();
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
                    groupValue: searchController.val,
                    onChanged: (int? value) {
                      searchController.val = value!;
                      searchController.update();
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
                    groupValue: searchController.val,
                    onChanged: (int? value) {
                      searchController.val = value!;
                      searchController.update();
                    },
                    title: Text(
                      'Avg. Customer Review',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ), RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: 4,
                    activeColor: Color(0xFF1992CE),
                    groupValue: searchController.val,
                    onChanged: (int? value) {
                      searchController.val = value!;
                      searchController.update();
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

/* void searchOperation(String searchText) {
    searchController.searchresult.clear();
    for (int i = 0; i < searchController.list.length; i++) {
      String data = searchController.list[i];
      if (data.toLowerCase().contains(searchText.toLowerCase())) {
        searchController.searchresult.add(data);
      }
    }
    searchController.update();
  }*/
}
