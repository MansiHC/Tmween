import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/my_account_controller.dart';
import 'package:tmween/controller/my_wallet_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/notification_screen.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';
import 'package:tmween/screens/drawer/profile/your_addresses_screen.dart';
import 'package:tmween/screens/drawer/profile/your_order_screen.dart';
import 'package:tmween/screens/drawer/wishlist_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_list_tile.dart';

import 'my_wallet_screen.dart';

class MyAccountScreen extends StatelessWidget {
  late String language;
  final myAccountController = Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<MyAccountController>(
        init: MyAccountController(),
        builder: (contet) {
          myAccountController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(myAccountController)),
                      _bottomView(myAccountController),
                    ],
                  )));
        });
  }

  Widget _bottomView(MyAccountController myAccountController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Container(
            color: AppColors.lighterGrayColor,
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Stack(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          5.widthBox,
                          Container(
                            width: 80,
                            child: CircleAvatar(
                              radius: 30,
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
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Salim Akka',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              5.heightBox,
                              Text(
                                '+221 1234567890',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                'salim.akka@tmween.com',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          )),
                        ],
                      )),
                  language == 'ar'
                      ? Positioned(
                          left: 0,
                          top: 0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              myAccountController
                                  .navigateTo(UpdateProfileScreen());
                            },
                          ))
                      : Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              myAccountController
                                  .navigateTo(UpdateProfileScreen());
                            },
                          ))
                ]),
                10.heightBox,
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300]!,
                            spreadRadius: 2,
                            blurRadius: 5)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primaryColor,
                      ),
                      Expanded(
                          child: Text(
                        '1999 Bluff Street MOODY Alabama - 35004',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      )),
                      InkWell(onTap:(){
                        myAccountController.navigateTo(YourAddressesScreen());
                      },child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            border: Border.all(color: AppColors.primaryColor)),
                        padding: EdgeInsets.all(3),
                        child: Text(
                          LocaleKeys.change.tr,
                          style: TextStyle(
                              color: AppColors.primaryColor, fontSize: 12),
                        ),
                      ))
                    ],
                  ),
                ),
                15.heightBox,
              ],
            )),
        10.heightBox,
        CustomListTile(
            title: LocaleKeys.yourOrders,
            onTap: () {
              myAccountController
                  .navigateTo(YourOrderScreen());
            },
            leadingIcon: ImageConstanst.yourOrdersIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.yourWallet,
            onTap: () {
              myAccountController.navigateTo(MyWalletScreen());
            },
            leadingIcon: ImageConstanst.yourWalletIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.yourAddresses,
            onTap: () {
              myAccountController.navigateTo(YourAddressesScreen());
            },
            leadingIcon: ImageConstanst.yourAddressesIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.wishLists,
            onTap: () {
              myAccountController.navigateTo(WishlistScreen(fromProfile: true,));
            },
            leadingIcon: ImageConstanst.wishlistIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.accountSettings,
            onTap: () {
              myAccountController.navigateTo(UpdateProfileScreen());
            },
            leadingIcon: ImageConstanst.accountSettingIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.notifications,
            onTap: () {
              myAccountController.navigateTo(NotificationScreen());
            },
            leadingIcon: ImageConstanst.notificationsIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
        CustomListTile(
            title: LocaleKeys.logout,
            onTap: () {
              _logout(myAccountController);
            },
            leadingIcon: ImageConstanst.logoutIcon),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey[300]!,
          ),
        ),
      ],
    )));
  }

  Widget topView(MyAccountController myAccountController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        myAccountController.exitScreen();
                      },
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.myAccount.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }

  void _logout(MyAccountController myAccountController) async {
    await showDialog(
        context: myAccountController.context,
        builder: (_) => AlertDialog(
              title: Text(
                LocaleKeys.wantLogout.tr,
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
                    myAccountController.pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    LocaleKeys.yes.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  onPressed: () {
                    myAccountController.doLogout();
                  },
                ),
              ],
            ));
  }
}
