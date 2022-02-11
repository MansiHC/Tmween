import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/drawer_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerScreenState();
  }
}

class _DrawerScreenState extends State<DrawerScreen> {
  late int userId;
  late int loginLogId;

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
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'East delivery in 1 day*',
                      style: TextStyle(color: Colors.white, fontSize: 12),
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
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                      ],
                    ),
                  ]),
              actions: [
                CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  backgroundColor: CupertinoColors.white,
                ),
                20.widthBox
              ],
              elevation: 0.0,
            ),
            drawer: _buildDrawer(drawerProvider),
            bottomNavigationBar: _buildBottomNavBar(drawerProvider),
            body: drawerProvider.pages[drawerProvider.pageIndex],
          ));
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

  _buildDrawer(DrawerProvider drawerProvider) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          /*  DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
         ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout(drawerProvider);
            },
          ),*/
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
