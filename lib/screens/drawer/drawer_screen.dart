import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/drawer_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/language_model.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/deal_of_the_day_screen.dart';
import 'package:tmween/screens/drawer/sold_by_tmween_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../utils/my_shared_preferences.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'address_container.dart';
import 'profile/my_account_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerScreenState();
  }
}

class _DrawerScreenState extends State<DrawerScreen> {
  final drawerController = Get.put(DrawerControllers());
  late var language;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<DrawerControllers>(
        init: DrawerControllers(),
        builder: (contet) {
          drawerController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(drawerController),
              child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: AppColors.appBarColor,
                    centerTitle: false,
                    titleSpacing: 0.0,
                    title: drawerController.pageIndex == 0
                        ? InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _bottomSheetView(drawerController);
                                  });
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'East delivery in 1 day*',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                      Expanded(
                                          child: Text(
                                        '1999 Bluff Street MOODY Alabama - 35004',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )),
                                    ],
                                  ),
                                ]))
                        : Text(
                            drawerController.pageTitle,
                            style: TextStyle(color: Colors.white),
                          ),
                    actions: [
                      drawerController.pageIndex == 0
                          ? InkWell(
                              onTap: () {
                                drawerController.navigateTo(MyAccountScreen());
                              },
                              child: Container(
                                width: 45,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(
                                      'http://i.imgur.com/QSev0hg.jpg'),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      20.widthBox
                    ],
                    elevation: 0.0,
                  ),
                  drawer: _buildDrawer(drawerController),
                  bottomNavigationBar: _buildBottomNavBar(drawerController),
                  body: Column(children: [
                    Container(
                        color: AppColors.appBarColor,
                        child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            child: CustomTextFormField(
                                controller: drawerController.searchController,
                                keyboardType: TextInputType.text,
                                hintText: LocaleKeys.searchProducts.tr,
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
                    Expanded(
                        child:
                            drawerController.pages[drawerController.pageIndex]),
                  ])));
        });
  }

  _bottomSheetView(DrawerControllers drawerController) {
    return Container(
        height: 305,
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
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            20.heightBox,
            Container(
                height: 150,
                child: ListView.builder(
                    itemCount: drawerController.addresses.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return (index != drawerController.addresses.length)
                          ? AddressContainer(
                              address: drawerController.addresses[index])
                          : Container(
                              width: 150,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: AppColors.lightBlue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
                              child: Center(
                                  child: Text(LocaleKeys.addAddressText.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))));
                    }))
          ],
        ));
  }

  _buildBottomNavBar(DrawerControllers drawerController) {
    return Container(
      color: AppColors.appBarColor,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                drawerController.changePage(0);
              },
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  drawerController.pageIndex == 0
                      ? Image.asset(
                          ImageConstanst.dashboardIcon,
                          height: 24,
                          width: 24,
                        )
                      : Image.asset(
                          ImageConstanst.dashboardIcon,
                          height: 24,
                          width: 24,
                        ),
                  5.heightBox,
                  Text(
                    LocaleKeys.home.tr,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              )),
          InkWell(
              onTap: () {
                drawerController.pageTitle = LocaleKeys.categories.tr;
                drawerController.changePage(1);
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerController.pageIndex == 1
                        ? const Icon(
                            CupertinoIcons.circle_grid_3x3_fill,
                            color: AppColors.primaryColor,
                            size: 24,
                          )
                        : const Icon(
                            CupertinoIcons.circle_grid_3x3,
                            color: Colors.white,
                            size: 24,
                          ),
                    5.heightBox,
                    Text(
                      LocaleKeys.categories.tr,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerController.changePage(2);
                drawerController.pageTitle = LocaleKeys.search.tr;
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerController.pageIndex == 2
                        ? const Icon(
                            CupertinoIcons.search,
                            color: AppColors.primaryColor,
                            size: 24,
                          )
                        : const Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                            size: 24,
                          ),
                    5.heightBox,
                    Text(
                      LocaleKeys.search.tr,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerController.changePage(3);
                drawerController.pageTitle = LocaleKeys.wishLists.tr;
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerController.pageIndex == 3
                        ? const Icon(
                            CupertinoIcons.square_favorites_fill,
                            color: AppColors.primaryColor,
                            size: 24,
                          )
                        : const Icon(
                            CupertinoIcons.square_favorites,
                            color: Colors.white,
                            size: 24,
                          ),
                    5.heightBox,
                    Text(
                      LocaleKeys.wishLists.tr,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerController.changePage(4);
                drawerController.pageTitle = LocaleKeys.cart.tr;
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerController.pageIndex == 4
                        ? const Icon(
                            Icons.shopping_cart,
                            color: AppColors.primaryColor,
                            size: 24,
                          )
                        : const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                    5.heightBox,
                    Text(
                      LocaleKeys.cart.tr,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
        ],
      ),
    );
  }

  String _getFlagIcon() {
    if (language == 'ar') {
      return ImageConstanst.sudanFlagIcon;
    } else if (language == 'es') {
      return ImageConstanst.spainFlagIcon;
    } else if (language == 'en') {
      return ImageConstanst.usFlagIcon;
    }
    return ImageConstanst.usFlagIcon;
  }

  _buildDrawer(DrawerControllers drawerController) {
    var flagIcon = _getFlagIcon();
    if (language == 'ar') {
      drawerController.languageValue = drawerController.languages[1];
    } else if (language == 'es') {
      drawerController.languageValue = drawerController.languages[2];
    }
    return Drawer(
      backgroundColor: AppColors.appBarColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          20.heightBox,
          ListTile(
            leading: Image.asset(
              ImageConstanst.dashboardIcon,
              height: 24,
              width: 24,
            ),
            title: Text(
              LocaleKeys.home.tr,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.changePage(0);
            },
          ),
          20.heightBox,
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.shopByCategoryIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(
              LocaleKeys.shopByCategorySmall.tr,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.pageTitle = LocaleKeys.shopByCategorySmall.tr;
              drawerController.navigateTo(CategoriesScreen(
                fromDrawer: true,
              ));
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.dealsOfTheDayIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.dealOfDaySmall.tr,
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.pageTitle = LocaleKeys.dealOfDaySmall.tr;
              drawerController.navigateTo(DealsOfTheDayScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.soldByTmweenIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.soldByTmweenSmall.tr,
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.pageTitle = LocaleKeys.soldByTmweenSmall.tr;
              drawerController.navigateTo(SoldByTmweenScreen());
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.white24,
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.sellingOnTmweenIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.sellingOnTmween.tr,
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.pageTitle = LocaleKeys.sellingOnTmween.tr;
              drawerController.changePage(1);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.white24,
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.deliveryOnTmweenIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.deliveryOnTmween.tr,
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerController.closeDrawer();
              drawerController.pageTitle = LocaleKeys.deliveryOnTmween.tr;
              drawerController.changePage(1);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.white24,
          ),
          16.heightBox,
          Wrap(children: [
            16.widthBox,
            SvgPicture.asset(flagIcon, width: 20, height: 20),
            6.widthBox,
            DropdownButton<LanguageModel>(
              isDense: true,
              underline: Container(color: Colors.transparent),
              value: drawerController.languageValue,
              dropdownColor: AppColors.primaryColor,
              style: TextStyle(color: Colors.white),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              items: drawerController.languages.map((LanguageModel items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items.name),
                );
              }).toList(),
              onChanged: (LanguageModel? value) async {
                drawerController.languageValue = value!;
                //  await context.setLocale(value.locale);
                MySharedPreferences.instance.addStringToSF(
                    SharedPreferencesKeys.language, value.locale.toString());
                Get.updateLocale(value.locale);
                // drawerController.closeDrawer();
              },
            ),
          ]),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.customerServiceIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.customerService.tr,
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop(DrawerControllers drawerController) async {
    return await showDialog(
        context: drawerController.context,
        builder: (_) => AlertDialog(
              title: Text(
                LocaleKeys.wantExit.tr,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.no.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerController.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerController.exit();
                  },
                ),
              ],
            ));
  }
}
