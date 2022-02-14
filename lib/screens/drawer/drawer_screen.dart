import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/drawer_provider.dart';
import 'package:tmween/screens/drawer/categories_screen.dart';
import 'package:tmween/screens/drawer/deal_of_the_day_screen.dart';
import 'package:tmween/screens/drawer/sold_by_tmween_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../utils/views/custom_text_form_field.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerScreenState();
  }
}

class _DrawerScreenState extends State<DrawerScreen> {
  late int userId;
  late int loginLogId;
  late String language;

  @override
  void initState() {
    /*MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value! ;
      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = context.locale.toString().split('_')[0];
    return Consumer<DrawerProvider>(builder: (context, drawerProvider, _) {
      drawerProvider.context = context;
      return WillPopScope(
          onWillPop: () => _onWillPop(drawerProvider),
          child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: AppColors.appBarColor,
                centerTitle: false,
                titleSpacing: 0.0,
                title: drawerProvider.pageIndex == 0
                    ? InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text('GeeksforGeeks'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
                        drawerProvider.pageTitle,
                        style: TextStyle(color: Colors.white),
                      ),
                actions: [
                  drawerProvider.pageIndex == 0
                      ? CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          backgroundColor: CupertinoColors.white,
                        )
                      : Container(),
                  20.widthBox
                ],
                elevation: 0.0,
              ),
              drawer: _buildDrawer(drawerProvider),
              bottomNavigationBar: _buildBottomNavBar(drawerProvider),
              body: Column(children: [
                Container(
                    color: AppColors.appBarColor,
                    child: Container(
                        color: Colors.white,
                        margin:
                            EdgeInsets.only(bottom: 10, left: 20, right: 20),
                        child: CustomTextFormField(
                            controller: drawerProvider.searchController,
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
                Expanded(child: drawerProvider.pages[drawerProvider.pageIndex]),
              ])));
    });
  }

  _buildBottomNavBar(DrawerProvider drawerProvider) {
    return Container(
      color: AppColors.appBarColor,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                drawerProvider.changePage(0);
              },
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  drawerProvider.pageIndex == 0
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
                    LocaleKeys.home.tr(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              )),
          InkWell(
              onTap: () {
                drawerProvider.pageTitle = LocaleKeys.categories.tr();
                drawerProvider.changePage(1);
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerProvider.pageIndex == 1
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
                      LocaleKeys.categories.tr(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerProvider.changePage(2);
                drawerProvider.pageTitle = LocaleKeys.search.tr();
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerProvider.pageIndex == 2
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
                      LocaleKeys.search.tr(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerProvider.changePage(3);
                drawerProvider.pageTitle = LocaleKeys.wishLists.tr();
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerProvider.pageIndex == 3
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
                      LocaleKeys.wishLists.tr(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  ])),
          InkWell(
              onTap: () {
                drawerProvider.changePage(4);
                drawerProvider.pageTitle = LocaleKeys.cart.tr();
              },
              child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    drawerProvider.pageIndex == 4
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
                      LocaleKeys.cart.tr(),
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

  _buildDrawer(DrawerProvider drawerProvider) {
    var flagIcon = _getFlagIcon();
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
              LocaleKeys.home.tr(),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.changePage(0);
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
              LocaleKeys.shopByCategorySmall.tr(),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.pageTitle = LocaleKeys.shopByCategorySmall.tr();
              drawerProvider.navigateTo(CategoriesScreen(
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
            title: Text(LocaleKeys.dealOfDaySmall.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.pageTitle = LocaleKeys.dealOfDaySmall.tr();
              drawerProvider.navigateTo(DealsOfTheDayScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.soldByTmweenIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.soldByTmweenSmall.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.pageTitle = LocaleKeys.soldByTmweenSmall.tr();
              drawerProvider.navigateTo(SoldByTmweenScreen());
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
            title: Text(LocaleKeys.sellingOnTmween.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.pageTitle = LocaleKeys.sellingOnTmween.tr();
              drawerProvider.changePage(1);
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
            title: Text(LocaleKeys.deliveryOnTmween.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {
              drawerProvider.closeDrawer();
              drawerProvider.pageTitle = LocaleKeys.deliveryOnTmween.tr();
              drawerProvider.changePage(1);
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.white24,
          ),
          16.heightBox,
          InkWell(
              onTap: () {
                drawerProvider.openLanguageDialog();
              },
              child: Wrap(children: [
                16.widthBox,
                SvgPicture.asset(flagIcon, width: 20, height: 20),
                6.widthBox,
                Text(language, style: TextStyle(color: Colors.white)),
                10.widthBox,
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Colors.white,
                )
              ])),
          ListTile(
            leading: SvgPicture.asset(
              ImageConstanst.customerServiceIcon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            title: Text(LocaleKeys.customerService.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: CupertinoColors.white,
            ),
            title: Text(LocaleKeys.logout.tr(),
                style: TextStyle(color: Colors.white)),
            onTap: () {
              _logout(drawerProvider);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop(DrawerProvider drawerProvider) async {
    return await showDialog(
        context: drawerProvider.context,
        builder: (_) => AlertDialog(
              title: Text(
                LocaleKeys.wantExit.tr(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.no.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.exit();
                  },
                ),
              ],
            ));
  }

  void _logout(DrawerProvider drawerProvider) async {
    await showDialog(
        context: drawerProvider.context,
        builder: (_) => AlertDialog(
              title: Text(
                LocaleKeys.wantLogout.tr(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.no.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr(),
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.doLogout(userId, loginLogId);
                  },
                ),
              ],
            ));
  }
}
