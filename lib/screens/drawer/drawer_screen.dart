import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                      ? const Icon(
                          Icons.home_filled,
                          color: AppColors.primaryColor,
                          size: 24,
                        )
                      : const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                  5.heightBox,
                  Text(
                    'Home',
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
                      'Categories',
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
                      'Search',
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
                      'Wish Lists',
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
                      'Cart',
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
        children: const <Widget>[
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
            leading: Icon(Icons.settings),
            title: Text('Settings'),
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
                'Do you want to exit?',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'no',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'yes',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    drawerProvider.exit();
                  },
                ),
              ],
            ));
  }
}
