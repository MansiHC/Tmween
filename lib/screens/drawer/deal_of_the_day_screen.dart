import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/categories_provider.dart';
import 'package:tmween/provider/deals_of_the_day_provider.dart';
import 'package:tmween/screens/drawer/dashboard/deals_of_the_day_container.dart';

import '../../provider/dashboard_provider.dart';
import '../../utils/global.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'dashboard/select_category_container.dart';

class DealsOfTheDayScreen extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _DealsOfTheDayScreenState();
  }
}

class _DealsOfTheDayScreenState extends State<DealsOfTheDayScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DealsOfTheDayProvider>(
        builder: (context, dealsOfTheDayProvider, _) {
          dealsOfTheDayProvider.context = context;

          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: AppColors.appBarColor,
                centerTitle: false,
                titleSpacing: 0.0,
                title: Text(
                  LocaleKeys.dealOfDaySmall.tr(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(child: Column(children: [
                  Container(
                        color: AppColors.appBarColor,
                        child: Container(
                            color: Colors.white,
                            margin:
                            EdgeInsets.only(bottom: 10, left: 20, right: 20),
                            child: CustomTextFormField(
                                controller: dealsOfTheDayProvider.searchController,
                                keyboardType: TextInputType.text,
                                hintText: LocaleKeys.searchProducts.tr(),
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  FocusScope.of(context).unfocus();
                                },
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.primaryColor,
                                ),
                                validator: (value) {
                                  return null;
                                }))),
                Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrayColor,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: EdgeInsets.all(1.5),
                    child:  GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 0.66,
                        physics: ScrollPhysics(),
                        children: List.generate(dealsOfTheDayProvider.deals.length,
                                (index) {
                              return DealsOfTheDayContainer(
                                deal: dealsOfTheDayProvider.deals[index],

                              );
                            })))
              ],),));
        });
  }
}
