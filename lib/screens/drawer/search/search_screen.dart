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
                child: Container(
                    width: double.maxFinite,
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
                    if (searchController.isLogin)
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
                      children: List.generate(
                          searchController.popularList.length,
                          (index) => InkWell(
                              onTap: () {
                                searchController.searchedString =
                                    searchController
                                        .popularList[index].keyword!;
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
                                  searchController.popularList[index].keyword!,
                                  style: TextStyle(
                                      fontSize: 12.5, color: Color(0xFF5B5B5B)),
                                ),
                              ))),
                    ),
                  ],
                )))));
  }
}
