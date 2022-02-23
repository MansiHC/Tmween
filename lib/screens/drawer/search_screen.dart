import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tmween/screens/drawer/dashboard/search_container.dart';
import 'package:tmween/screens/drawer/filter_screen.dart';
import 'package:tmween/utils/extensions.dart';

import '../../controller/search_controller.dart';
import '../../lang/locale_keys.g.dart';
import '../../utils/global.dart';

class SearchScreen extends StatelessWidget {
  final searchController = Get.put(SearchController());
  late var language;

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<SearchController>(
        init: SearchController(),
        builder: (contet) {
          searchController.context = context;
          return Scaffold(
              body: Form(
            key: searchController.formKey,
            child: Column(
              children: [
                Container(
                    color: AppColors.appBarColor,
                    padding: EdgeInsets.only(top: 5),
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
                            controller: searchController.searchController,
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
                              suffixIcon:  IconButton(
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
                        ) /*CustomTextFormField(
                            isDense: true,
                            autoFocus: true,
                            controller: searchController.searchController,
                            keyboardType: TextInputType.text,
                            hintText: LocaleKeys.searchProducts.tr,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (term) {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: searchOperation,
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                              size: 32,
                            ),
                            validator: (value) {
                              return null;
                            })*/
                        )),
                Visibility(
                    visible: searchController.visibleList,
                    child: Flexible(
                        child: Container(
                      color: Color(0xFFF3F3F3),
                      child: ListView(children: <Widget>[
                        Container(
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
                                  style: TextStyle(
                                      color: Color(0xFF838383), fontSize: 12),
                                ),
                              ],
                            )),
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
                                      '(8 items)',
                                      style: TextStyle(
                                          color: Color(0xFF838383),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          searchController
                                              .navigateTo(FilterScreen());
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
                                                        color:
                                                            Color(0xFF838383),
                                                        fontSize: 13),
                                                  ),
                                                ]))),
                                    10.widthBox,
                                    Container(
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
                                        ))
                                  ],
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: searchController.recentlVieweds.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 0.66),
                            itemBuilder: (ctx, i) {
                              return SearchContainer(
                                recentlyViewed:
                                    searchController.recentlVieweds[i],
                              );
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
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Center(
                                  child: Text(
                                LocaleKeys.previous.tr,
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14),
                              )),
                            )),
                            10.widthBox,
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Center(
                                  child: Text(
                                LocaleKeys.next.tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                            )),
                            15.widthBox
                          ],
                        ),
                        15.heightBox
                      ]),
                    )))
              ],
            ),
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
