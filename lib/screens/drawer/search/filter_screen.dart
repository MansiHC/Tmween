import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/views/circular_progress_bar.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/custom_rectangle_slider_thumb_shape.dart';

import '../../../controller/filter_controller.dart';
import '../../../lang/locale_keys.g.dart';
import '../../../utils/global.dart';

class FilterScreen extends StatefulWidget {
  final String? from;
  final String? searchedString;

  FilterScreen({Key? key,required this.from,required this.searchedString}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FilterScreenState();
  }
}

class FilterScreenState extends State<FilterScreen> {
  late String language;

  final filterController = Get.put(FilterController());

  @override
  void initState() {
    filterController.from = widget.from!;
    filterController.searchString = widget.searchedString!;
    if(!filterController.called) {
      filterController.getFilterData(Get.locale!.languageCode);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<FilterController>(
        init: FilterController(),
        builder: (contet) {
          filterController.context = context;

          return Scaffold(
              body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, maxHeight: 90),
                    color: AppColors.appBarColor,
                    padding: EdgeInsets.only(top: 20),
                    child: topView(filterController)),
                filterController.loading
                    ? Expanded(child: Center(child:CircularProgressBar()))
                    : Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                        children: [
                          _showOnly(filterController),
                          if(filterController.categoryList.length>0)
                          _categories(filterController),
                          if(filterController.brandList.length>0)
                            _brands(filterController),
                          if(filterController.sellerList.length>0)

                            _seller(filterController),
                          _searchByPrice(filterController),
                          20.heightBox,
                        ],
                      )))
              ],
            ),
          ));
        });
  }

  _showOnly(FilterController filterController) {
    return ExpansionTile(
      trailing: filterController.isShowOnlyExpanded
          ? SvgPicture.asset(
        ImageConstanst.minusIcon,
        height: 16,
        width: 16,
      )
          : SvgPicture.asset(
        ImageConstanst.plusIcon,
        height: 16,
        width: 16,
      ),
      onExpansionChanged: (isExapanded) {
        filterController.updateShowOnlyExpanded();
      },
      initiallyExpanded: true,
      key: PageStorageKey<String>(LocaleKeys.showOnly.tr),
      title: Text(LocaleKeys.showOnly.tr,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A5A5A))),
      children: filterController.showOnlyList
          .map<Widget>(
            (map) => InkWell(
            onTap: () {
              map["isChecked"] = !map["isChecked"];
              filterController.update();
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                    map['title'].toString().contains('&')
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Theme(
                              data: Theme.of(filterController.context)
                                  .copyWith(
                                unselectedWidgetColor: Colors.grey,
                              ),
                              child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(4)),
                                  checkColor: Colors.black,
                                  value: map["isChecked"],
                                  activeColor: Colors.white,
                                  side: MaterialStateBorderSide.resolveWith(
                                        (states) => BorderSide(
                                        width: 1.5, color: Colors.black),
                                  ),
                                  onChanged: (value) {
                                    map["isChecked"] = value;
                                    filterController.update();
                                  }))),
                      10.widthBox,
                      Text(
                        map['title'].toString().contains('&')
                            ? '${map['title'].toString().split('&')[0]} '
                            : '',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            map['title'].toString().contains('&')
                                ? map['title'].toString().split('&')[1]
                                : '${map['title']}',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ]))),
      )
          .toList(),
    );
  }

  _categories(FilterController filterController) {
    return ExpansionTile(
      trailing: filterController.isCategoryExpanded
          ? SvgPicture.asset(
              ImageConstanst.minusIcon,
              height: 16,
              width: 16,
            )
          : SvgPicture.asset(
              ImageConstanst.plusIcon,
              height: 16,
              width: 16,
            ),
      onExpansionChanged: (isExapanded) {
        filterController.updateCategoryExpanded();
      },
      initiallyExpanded: true,
      key: PageStorageKey<String>(LocaleKeys.categoriesCap.tr),
      title: Text(LocaleKeys.categoriesCap.tr,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A5A5A))),
      children: filterController.categoryList
          .map<Widget>(
            (map) => _checkBoxTile(filterController, map,false),
          )
          .toList(),
    );
  }

  _brands(FilterController filterController) {
    return ExpansionTile(
      trailing: filterController.isBrandExpanded
          ? SvgPicture.asset(
              ImageConstanst.minusIcon,
              height: 16,
              width: 16,
            )
          : SvgPicture.asset(
              ImageConstanst.plusIcon,
              height: 16,
              width: 16,
            ),
      onExpansionChanged: (isExapanded) {
        filterController.updateBrandExpanded();
      },
      initiallyExpanded: true,
      key: PageStorageKey<String>(LocaleKeys.brandCap.tr),
      title: Text(LocaleKeys.brandCap.tr,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A5A5A))),
      children: filterController.brandList
          .map<Widget>(
            (map) => _checkBoxTile(filterController, map,false),
          )
          .toList(),
    );
  }

  _seller(FilterController filterController) {
    return ExpansionTile(
      trailing: filterController.isSellerExpanded
          ? SvgPicture.asset(
              ImageConstanst.minusIcon,
              height: 16,
              width: 16,
            )
          : SvgPicture.asset(
              ImageConstanst.plusIcon,
              height: 16,
              width: 16,
            ),
      onExpansionChanged: (isExapanded) {
        filterController.updateSellerExpanded();
      },
      initiallyExpanded: true,
      key: PageStorageKey<String>(LocaleKeys.sellerCap.tr),
      title: Text(LocaleKeys.sellerCap.tr,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A5A5A))),
      children: filterController.sellerList
          .map<Widget>(
            (map) => _checkBoxTile(filterController, map,true),
          )
          .toList(),
    );
  }

  _searchByPrice(FilterController filterController) {
    return ExpansionTile(
        trailing: filterController.isPriceExpanded
            ? SvgPicture.asset(
                ImageConstanst.minusIcon,
                height: 16,
                width: 16,
              )
            : SvgPicture.asset(
                ImageConstanst.plusIcon,
                height: 16,
                width: 16,
              ),
        onExpansionChanged: (isExapanded) {
          filterController.updatePriceExpanded();
        },
        initiallyExpanded: true,
        key: PageStorageKey<String>(LocaleKeys.searchByPriceCap.tr),
        title: Text(LocaleKeys.searchByPriceCap.tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5A5A5A))),
        children: [
          SliderTheme(
              data: SliderTheme.of(filterController.context).copyWith(
                thumbColor: Colors.black,
                trackShape: RectangularSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape: CustomRectangleSliderThumbShape(
                    thumbRadius: 20.0, max: 10, min: 0, thumbHeight: 50),
              ),
              child: RangeSlider(
                values: filterController.currentRangeValues,
                max:  double.parse(filterController.filteredData.maxPrice!.toString()),

                labels: RangeLabels(
                  filterController.currentRangeValues.start.round().toString(),
                  filterController.currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  filterController.currentRangeValues = values;
                  filterController.update();
                },
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.fromSar.tr} ${filterController.currentRangeValues.start.round()}',
                    style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 14),
                  ),
                  Text(
                    '${LocaleKeys.toSar.tr} ${filterController.currentRangeValues.end.round()}',
                    style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 14),
                  ),
                ],
              )),
          5.heightBox,
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                      width: 80,
                      horizontalPadding: 10,
                      text: LocaleKeys.apply.tr,
                      fontSize: 14,
                      onPressed: () {
                        filterController.setFilter(language);

                      })))
        ]);
  }

  _checkBoxTile(FilterController filterController, Map map,bool fromSeller) {
    return InkWell(
        onTap: () {
          map["isChecked"] = !map["isChecked"];
          filterController.update();
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Theme(
                          data: Theme.of(filterController.context).copyWith(
                            unselectedWidgetColor: Colors.grey,
                          ),
                          child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              checkColor: Colors.black,
                              value: map["isChecked"],
                              activeColor: Colors.white,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) =>
                                    BorderSide(width: 1.2, color: Colors.black),
                              ),
                              onChanged: (value) {
                                map["isChecked"] = value;
                                filterController.update();
                              }))),
                  10.widthBox,
                  Text(
                    fromSeller?map['title']:'${map['title']} (${map['count']})',
                    style: TextStyle(
                      color: Color(0xFF4B4B4B),
                      fontSize: 14,
                    ),
                  )
                ])));
  }

  Widget topView(FilterController filterController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.filterResults.tr,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            CustomButton(
                width: 100,
                horizontalPadding: 10,
                text: LocaleKeys.apply.tr,
                fontSize: 16,
                onPressed: () {
                  filterController.setFilter(language);

                })
          ],
        ));
  }
}
