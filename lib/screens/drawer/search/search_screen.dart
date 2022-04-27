import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../controller/search_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../utils/global.dart';
import '../../../utils/my_shared_preferences.dart';
import '../../../utils/views/circular_progress_bar.dart';

class SearchScreen extends StatefulWidget {
  final String? from;
  final String? searchText;

  SearchScreen({Key? key, required this.from, this.searchText = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  final searchController = Get.put(SearchController());
  late var language;

  Future<bool> _onWillPop(SearchController searchController) async {
    searchController.exitScreen();
    return true;
  }

  @override
  void initState() {
    searchController.searchController.text = widget.searchText!;
    searchController.searchList = [];
    searchController.getPopularList(Get.locale!.languageCode);
    // getFilterData(Get.locale!.languageCode);
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      searchController.isLogin = value!;
      searchController.update();
    });
    MySharedPreferences.instance
        .getStringValuesSF(SharedPreferencesKeys.token)
        .then((value) async {
      searchController.token = value!;
      print('dhsh.....${searchController.token}');
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.userId)
          .then((value) async {
        searchController.userId = value!;
        MySharedPreferences.instance
            .getIntValuesSF(SharedPreferencesKeys.loginLogId)
            .then((value) async {
          searchController.loginLogId = value!;
        });
      });
    });
    super.initState();
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
              child: Scaffold(
                  body: Form(
                key: searchController.formKey,
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
                                    searchController.exitScreen();
                                  },
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      )),
                                ),
                              )),
                          // )),
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2)),
                                  height: 40,
                                  margin: EdgeInsets.only(
                                      bottom: 10, left: 15, right: 15),
                                  child: TypeAheadFormField<String>(
                                    getImmediateSuggestions: true,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: widget.from ==
                                              AppConstants.bottomBar
                                          ? searchController.searchController2
                                          : searchController.searchController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.search,
                                      onChanged: (text) {
                                        searchController.update();
                                      },
                                      onSubmitted: (term) {
                                        FocusScope.of(context).unfocus();
                                        searchController.searchedString = term;
                                        searchController.searchProduct(
                                            widget.from, language);
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
                                        suffixIcon: widget.from ==
                                                AppConstants.bottomBar
                                            ? searchController.searchController2
                                                        .text.length >
                                                    0
                                                ? IconButton(
                                                    onPressed: () {
                                                      searchController
                                                          .searchController2
                                                          .clear();
                                                      searchController.update();
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons
                                                          .clear_circled_solid,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: 24,
                                                    ))
                                                : SizedBox()
                                            : searchController.searchController
                                                        .text.length >
                                                    0
                                                ? IconButton(
                                                    onPressed: () {
                                                      searchController
                                                          .searchController
                                                          .clear();
                                                      searchController.update();
                                                    },
                                                    icon: Icon(
                                                      CupertinoIcons
                                                          .clear_circled_solid,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: 24,
                                                    ))
                                                : SizedBox(),
                                      ),
                                    ),
                                    suggestionsCallback:
                                        (String pattern) async {
                                      return await searchController
                                          .getProductList(pattern, language)
                                          .then((value) => value
                                              .where((item) => item
                                                  .toLowerCase()
                                                  .contains(
                                                      pattern.toLowerCase()))
                                              .toList());
                                    },
                                    itemBuilder: (context, String suggestion) {
                                      return ListTile(
                                        title: Text(suggestion),
                                      );
                                    },
                                    onSuggestionSelected: (String suggestion) {
                                      searchController.searchedString =
                                          suggestion;

                                      searchController.searchProduct(
                                          widget.from, language);
                                    },
                                  )))
                        ])),
                    searchController.historyLoading
                        ? Flexible(child: Center(child: CircularProgressBar()))
                        : _searchHistory(searchController),
                  ],
                ),
              )));
        });
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
                    if (searchController.isLogin)
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
                                searchController.clearHistoryList(language);
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
                    if (searchController.isLogin)
                      if (searchController.historyList.length > 0)
                        Wrap(
                            spacing: 10,
                            children: List.generate(
                                searchController.historyList.length,
                                (index) => InkWell(
                                    onTap: () {
                                      searchController.searchedString =
                                          searchController
                                              .historyList[index].keyword!;
                                      searchController.searchProduct(
                                          widget.from, language);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 6),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[300]!,
                                                blurRadius: 3,
                                                spreadRadius: 3)
                                          ]),
                                      child: Text(
                                        searchController
                                            .historyList[index].keyword!,
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFF5B5B5B)),
                                      ),
                                    )))),
                    if (searchController.isLogin)
                      if (searchController.historyList.length > 0) 30.heightBox,
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
                        for (var item in searchController.popularList)
                          InkWell(
                              onTap: () {
                                searchController.searchedString = item.keyword!;
                                searchController.searchProduct(
                                    widget.from, language);
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
                                  item.keyword!,
                                  style: TextStyle(
                                      fontSize: 12.5, color: Color(0xFF5B5B5B)),
                                ),
                              )),
                      ],
                    ),
                  ],
                ))));
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:tmween/model/search_history_model.dart';
// import 'package:tmween/screens/drawer/dashboard/search_container.dart';
// import 'package:tmween/screens/drawer/filter_screen.dart';
// import 'package:tmween/screens/drawer/profile/your_addresses_screen.dart';
// import 'package:tmween/utils/extensions.dart';
//
// import '../../controller/search_controller.dart';
// import '../../lang/locale_keys.g.dart';
// import '../../model/get_customer_address_list_model.dart';
// import '../../utils/global.dart';
// import '../../utils/views/circular_progress_bar.dart';
// import '../../utils/views/custom_button.dart';
// import '../authentication/login/login_screen.dart';
// import 'address_container.dart';
// import 'dashboard/product_detail_screen.dart';
//
// class SearchScreen extends StatelessWidget {
//   final searchController = Get.put(SearchController());
//   late var language;
//   final String? widget.from;
//
//   SearchScreen({Key? key, required this.widget.from}) : super(key: key);
//
//   Future<bool> _onWillPop(SearchController searchController) async {
//     searchController.exitScreen();
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     language = Get.locale!.languageCode;
//     return GetBuilder<SearchController>(
//         init: SearchController(),
//         builder: (contet) {
//           searchController.context = context;
//           return WillPopScope(
//               onWillPop: () => _onWillPop(searchController),
//               child: Scaffold(
//                   body: Form(
//                 key: searchController.formKey,
//                 child: Column(
//                   children: [
//                     Container(
//                         color: AppColors.appBarColor,
//                         padding: EdgeInsets.only(top: 35),
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(2)),
//                             height: 40,
//                             margin: EdgeInsets.only(
//                                 bottom: 10, left: 15, right: 15),
//                             child: TypeAheadFormField<SearchHistoryData>(
//                               getImmediateSuggestions: true,
//                               textFieldConfiguration: TextFieldConfiguration(
//                                 controller: widget.from == AppConstants.bottomBar
//                                     ? searchController.searchController2
//                                     : searchController.searchController,
//                                 keyboardType: TextInputType.text,
//                                 textInputAction: TextInputAction.search,
//                                 onSubmitted: (term) {
//                                   FocusScope.of(context).unfocus();
//                                   searchController.searchedString = term;
//                                   searchController.searchProduct(widget.from,
//                                      language);
//                                 },
//                                 decoration: InputDecoration(
//                                   contentPadding: EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 10),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: AppColors.lightGrayColor),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: AppColors.lightGrayColor),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: AppColors.lightGrayColor),
//                                   ),
//                                   isDense: true,
//                                   hintText: LocaleKeys.searchProducts.tr,
//                                   prefixIcon: Icon(
//                                     Icons.search,
//                                     color: AppColors.primaryColor,
//                                     size: 32,
//                                   ),
//                                   suffixIcon: IconButton(
//                                       onPressed: () {
//                                         searchController.searchController
//                                             .clear();
//                                         searchController.update();
//                                       },
//                                       icon: Icon(
//                                         CupertinoIcons.clear_circled_solid,
//                                         color: AppColors.primaryColor,
//                                         size: 24,
//                                       )),
//                                 ),
//                               ),
//                               suggestionsCallback: (String pattern) async {
//                                 return searchController.historyList
//                                     .where((item) => item.keyword!
//                                         .toLowerCase()
//                                         .startsWith(pattern.toLowerCase()))
//                                     .toList();
//                               },
//                               itemBuilder: (context, SearchHistoryData suggestion) {
//                                 return ListTile(
//                                   title: Text(suggestion.keyword!),
//                                 );
//                               },
//                               onSuggestionSelected: (SearchHistoryData suggestion) {
//                                 searchController.searchedString = suggestion.keyword!;
//                                 searchController.searchProduct(
//                                     widget.from,language);
//                               },
//                             ))),
//                     searchController.historyLoading?
//                         CircularProgressBar():
//                         _searchHistory(searchController),
//                   /*  Visibility(
//                         visible: searchController.visibleList,
//                         child: _productList(searchController))*/
//                   ],
//                 ),
//               )));
//         });
//   }
//
//   _productList(SearchController searchController) {
//     return searchController.searchLoading
//         ? CircularProgressBar()
//         : !searchController.searchLoading &&
//         searchController.productList.length == 0?
//     Expanded(
//       child: Center(
//           child: Text(
//             'No Records',
//             style: TextStyle(
//                 color: Color(0xFF414141),
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold),
//           )),
//     )
//     :Flexible(
//             child: Container(
//             color: Color(0xFFF3F3F3),
//             child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: <Widget>[
//               InkWell(
//                   onTap: () {
//             if (searchController.isLogin) {
//               searchController.getAddressList(language);
//             }
//                     showModalBottomSheet<void>(
//                         context: searchController.context,
//                         builder: (BuildContext context) {
//                           return _bottomSheetView(searchController);
//                         });
//                   },
//                   child: Container(
//                       color: Colors.white,
//                       padding: EdgeInsets.symmetric(vertical: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             ImageConstanst.locationPinIcon,
//                             color: Color(0xFF838383),
//                             height: 16,
//                             width: 16,
//                           ),
//                           3.widthBox,
//                           Text(
//                             searchController.isLogin
//                                 ? searchController
//                                 .address.isNotEmpty
//                                 ? searchController.address
//                                 : 'Select Delivery Address'
//                                 : 'Select Delivery Address',
//                             style: TextStyle(
//                                 color: Color(0xFF838383), fontSize: 12),
//                           ),
//                           Icon(
//                             Icons.arrow_drop_down_sharp,
//                             size: 16,
//                           ),
//                           5.widthBox
//                         ],
//                       ))),
//               10.heightBox,
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Wrap(
//                         children: [
//                           Text(
//                             '${searchController.searchedString} ',
//                             style: TextStyle(
//                                 color: Color(0xFF5A5A5A),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             '(${searchController.productList.length} ${LocaleKeys.items.tr})',
//                             style: TextStyle(
//                                 color: Color(0xFF838383), fontSize: 14),
//                           ),
//                         ],
//                       ),
//                       Wrap(
//                         children: [
//                           InkWell(
//                               onTap: () {
//                                 searchController.navigateTo(FilterScreen());
//                               },
//                               child: Container(
//                                   color: Colors.white,
//                                   padding: EdgeInsets.all(5),
//                                   child: Wrap(
//                                       crossAxisAlignment:
//                                           WrapCrossAlignment.center,
//                                       children: [
//                                         SvgPicture.asset(
//                                           ImageConstanst.filterIcon,
//                                           height: 16,
//                                           width: 16,
//                                         ),
//                                         5.widthBox,
//                                         Text(
//                                           LocaleKeys.filter.tr,
//                                           style: TextStyle(
//                                               color: Color(0xFF838383),
//                                               fontSize: 13),
//                                         ),
//                                       ]))),
//                           10.widthBox,
//                           InkWell(
//                               onTap: () {
//                                 showModalBottomSheet<void>(
//                                     context: searchController.context,
//                                     builder: (BuildContext context) {
//                                       return _bestMatchBottomSheetView();
//                                     });
//                               },
//                               child: Container(
//                                   color: Colors.white,
//                                   padding: EdgeInsets.all(5),
//                                   child: Wrap(
//                                     crossAxisAlignment:
//                                         WrapCrossAlignment.center,
//                                     children: [
//                                       SvgPicture.asset(
//                                           ImageConstanst.bestMatchIcon,
//                                           height: 16,
//                                           width: 16),
//                                       5.widthBox,
//                                       Text(
//                                         LocaleKeys.bestMatch.tr,
//                                         style: TextStyle(
//                                             color: Color(0xFF838383),
//                                             fontSize: 13),
//                                       )
//                                     ],
//                                   )))
//                         ],
//                       )
//                     ],
//                   )),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 child: NotificationListener<ScrollNotification>(
//                   onNotification:
//                       (ScrollNotification scrollInfo) {
//                     if (scrollInfo is ScrollEndNotification &&
//                         scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
//                       if (searchController.next != 0) {
//                         searchController.loadMore(language);
//                       }
//                     }
//                     return false;
//                   },
//                   child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: ScrollPhysics(),
//                   itemCount: searchController.productList.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 2,
//                       crossAxisSpacing: 2,
//                       childAspectRatio: 0.66),
//                   itemBuilder: (ctx, i) {
//                     return InkWell(
//                         onTap: () {
//                           searchController.navigateTo(ProductDetailScreen());
//                         },
//                         child: SearchContainer(
//                           productData: searchController.productList[i],
//                         ));
//                   },
//                 )),
//               ),
//               /*Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   15.widthBox,
//                   Expanded(
//                       child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: AppColors.primaryColor),
//                         borderRadius: BorderRadius.all(Radius.circular(2))),
//                     child: Center(
//                         child: Text(
//                       LocaleKeys.previous.tr,
//                       style: TextStyle(
//                           color: AppColors.primaryColor, fontSize: 14),
//                     )),
//                   )),
//                   10.widthBox,
//                   Expanded(
//                       child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.all(Radius.circular(2))),
//                     child: Center(
//                         child: Text(
//                       LocaleKeys.next.tr,
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     )),
//                   )),
//                   15.widthBox
//                 ],
//               ),*/
//               15.heightBox
//             ]),
//           ));
//   }
//
//   _searchHistory(SearchController searchController) {
//     return Flexible(
//         child: SingleChildScrollView(
//             child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     5.heightBox,
//                     if(searchController.isLogin)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           LocaleKeys.searchHistory.tr,
//                           style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF585858)),
//                         ),
//                         InkWell(
//                             onTap: () {
//                                searchController.clearHistoryList(language);
//                             },
//                             child: Text(
//                               LocaleKeys.clear.tr,
//                               style: TextStyle(
//                                   fontSize: 12.5,
//                                   decoration: TextDecoration.underline,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF585858)),
//                             )),
//                       ],
//                     ),
//                     10.heightBox,
//                     if(searchController.isLogin)
//                       if(searchController.historyList.length>0)
//                     Wrap(
//                         spacing: 10,
//                         children: List.generate(
//                             searchController.historyList.length,
//                             (index) => InkWell(
//                                 onTap: () {
//                                   searchController.searchedString =   searchController.historyList[index].keyword!;
//                                   searchController.searchProduct(
//                                       widget.from,
//                                       language);
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(5),
//                                   margin: EdgeInsets.symmetric(
//                                       horizontal: 2, vertical: 6),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(6),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.grey[300]!,
//                                             blurRadius: 3,
//                                             spreadRadius: 3)
//                                       ]),
//                                   child: Text(
//                                     searchController.historyList[index].keyword!,
//                                     style: TextStyle(
//                                         fontSize: 12.5,
//                                         color: Color(0xFF5B5B5B)),
//                                   ),
//                                 ))))
//
//                     ,
//                     if(searchController.isLogin)
//                       if(searchController.historyList.length>0)
//                     30.heightBox,
//                     Text(
//                       LocaleKeys.popularSearch.tr,
//                       style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF585858)),
//                     ),
//                     10.heightBox,
//                     Wrap(
//                       spacing: 10,
//                       children: <Widget>[
//                         for (var item in searchController.popularList)
//                           InkWell(
//                               onTap: () {
//                                 searchController.searchedString =  item.keyword!;
//                                 searchController.searchProduct(widget.from, language);
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(5),
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: 2, vertical: 6),
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(6),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.grey[300]!,
//                                           blurRadius: 3,
//                                           spreadRadius: 3)
//                                     ]),
//                                 child: Text(
//                                   item.keyword!,
//                                   style: TextStyle(
//                                       fontSize: 12.5, color: Color(0xFF5B5B5B)),
//                                 ),
//                               )),
//                       ],
//                     ),
//                   ],
//                 ))));
//   }
//
//   _bottomSheetView(SearchController searchController) {
//     return GetBuilder<SearchController>(
//         init: SearchController(),
//         builder: (contet) {
//           return Container(
//               height: searchController.isLogin?310:200,
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   10.heightBox,
//                   Text(
//                     LocaleKeys.chooseLocation.tr,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   10.heightBox,
//                   Text(
//                     LocaleKeys.chooseLocationText.tr,
//                     style: TextStyle(color: Color(0xFF666666), fontSize: 16),
//                   ),
//                   20.heightBox,
//           searchController.isLogin
//           ? Column(
//           children: [Visibility(
//                     visible: searchController.loading,
//                     child: CircularProgressBar(),
//                   ),
//                   Visibility(
//                     visible: !searchController.loading &&
//                         searchController.addressList.length == 0,
//                     child: InkWell(
//                         onTap: () {
//                           searchController.pop();
//                           searchController.navigateTo(YourAddressesScreen());
//                         },
//                         child: Container(
//                             width: 150,
//                             height: 160,
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(color: AppColors.lightBlue),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(2))),
//                             child: Center(
//                                 child: Text(LocaleKeys.addAddressText.tr,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: AppColors.primaryColor,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold))))),
//                   ),
//                   Visibility(
//                       visible: !searchController.loading &&
//                           searchController.addressList.length > 0,
//                       child: Container(
//                           height: 170,
//                           child: ListView.builder(
//                               itemCount:
//                                   searchController.addressList.length + 1,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return (index !=
//                                         searchController.addressList.length)
//                                     ? InkWell(
//                                         onTap: () {
//                                           Address address = searchController
//                                               .addressList[index];
//                                           searchController.editAddress(
//                                               address.id,
//                                               address.fullname,
//                                               address.address1,
//                                               address.address2,
//                                               address.landmark,
//                                               address.countryCode,
//                                               address.stateCode,
//                                               address.cityCode,
//                                               address.zip,
//                                               address.mobile1,
//                                               address.addressType,
//                                               address.deliveryInstruction,
//                                               '1',
//                                               language);
//                                         },
//                                         child: AddressContainer(
//                                             address: searchController
//                                                 .addressList[index]))
//                                     : InkWell(
//                                         onTap: () {
//                                           searchController.pop();
//                                           searchController.navigateTo(
//                                               YourAddressesScreen());
//                                         },
//                                         child: Container(
//                                             width: 150,
//                                             padding: EdgeInsets.all(10),
//                                             margin: EdgeInsets.all(5),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(
//                                                     color: AppColors.lightBlue),
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(2))),
//                                             child: Center(
//                                                 child: Text(
//                                                     LocaleKeys
//                                                         .addAddressText.tr,
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                         color: AppColors
//                                                             .primaryColor,
//                                                         fontSize: 15,
//                                                         fontWeight: FontWeight
//                                                             .bold)))));
//                               })))])
//               :CustomButton(
//               text: 'Sign in to see your Addresses',
//               fontSize: 16,
//               onPressed: () {
//                 Get.deleteAll();
//                 searchController.navigateTo(LoginScreen(
//                     widget.from: SharedPreferencesKeys.isDrawer));
//               }),
//                 ],
//               ));
//         });
//   }
//
//   _bestMatchBottomSheetView() {
//     return GetBuilder<SearchController>(
//         init: SearchController(),
//         builder: (contet) {
//           return Container(
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   10.heightBox,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         LocaleKeys.bestMatch.tr,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       CustomButton(
//                           width: 80,
//                           horizontalPadding: 5,
//                           text: LocaleKeys.apply.tr,
//                           fontSize: 14,
//                           onPressed: () {
//                             searchController.popp();
//                           })
//                     ],
//                   ),
//                   10.heightBox,
//                   RadioListTile(
//                     contentPadding: EdgeInsets.zero,
//                     dense: true,
//                     value: 1,
//                     groupValue: searchController.val,
//                     activeColor: Color(0xFF1992CE),
//                     onChanged: (int? value) {
//                       searchController.val = value!;
//                       searchController.update();
//                     },
//                     title: Text(
//                       'Product Name',
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                   ),
//                   RadioListTile(
//                     contentPadding: EdgeInsets.zero,
//                     dense: true,
//                     value: 2,
//                     activeColor: Color(0xFF1992CE),
//                     groupValue: searchController.val,
//                     onChanged: (int? value) {
//                       searchController.val = value!;
//                       searchController.update();
//                     },
//                     title: Text(
//                       LocaleKeys.lowToHigh.tr,
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                   ),
//                   RadioListTile(
//                     contentPadding: EdgeInsets.zero,
//                     dense: true,
//                     value: 3,
//                     activeColor: Color(0xFF1992CE),
//                     groupValue: searchController.val,
//                     onChanged: (int? value) {
//                       searchController.val = value!;
//                       searchController.update();
//                     },
//                     title: Text(
//                       LocaleKeys.highToLow.tr,
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                   ),
//                   RadioListTile(
//                     contentPadding: EdgeInsets.zero,
//                     dense: true,
//                     value: 4,
//                     activeColor: Color(0xFF1992CE),
//                     groupValue: searchController.val,
//                     onChanged: (int? value) {
//                       searchController.val = value!;
//                       searchController.update();
//                     },
//                     title: Text(
//                       'Avg. Customer Review',
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                   ),
//                   RadioListTile(
//                     contentPadding: EdgeInsets.zero,
//                     dense: true,
//                     value: 4,
//                     activeColor: Color(0xFF1992CE),
//                     groupValue: searchController.val,
//                     onChanged: (int? value) {
//                       searchController.val = value!;
//                       searchController.update();
//                     },
//                     title: Text(
//                       'Newest Arrival',
//                       style: TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ));
//         });
//   }
//
// }
