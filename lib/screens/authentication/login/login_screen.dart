import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/screens/authentication/login/store_owner_login_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/my_shared_preferences.dart';

import 'individual_login_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late List<Tab> tabList;
  late TabController _tabController;
  var isSplash;
  var language;

  @override
  void initState() {
    tabList = <Tab>[];
    tabList.add(new Tab(
      text: LocaleKeys.individual.tr(),
    ));
    tabList.add(new Tab(
      text: LocaleKeys.storeOwner.tr(),
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isSplash)
        .then((value) async {
      isSplash = value ?? false;
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    language = context.locale.toString().split('_')[0];
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      loginProvider.context = context;
      return DefaultTabController(
          length: 2,
          child: Scaffold(
              body: SingleChildScrollView(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2.4),
                              child: topView(loginProvider)),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 0.8)),
                            ),
                            child: TabBar(
                                controller: _tabController,
                                indicatorColor: AppColors.primaryColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                labelColor: AppColors.primaryColor,
                                unselectedLabelColor: Colors.black,
                                tabs: tabList),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                IndividualLoginScreen(),
                                StoreOwnerLoginScreen()
                              ],
                            ),
                          )
                        ],
                      )))));
    });
  }

  Widget topView(LoginProvider loginProvider) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstanst.loginBackground),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                20.heightBox,
                Align(
                    alignment: language == 'ar'
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            loginProvider.exitScreen();
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
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6.5,
                      width: MediaQuery.of(context).size.height / 6.5,
                      child: SvgPicture.asset(ImageConstanst.logo),
                    )),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text.rich(TextSpan(text: ' ', children: <InlineSpan>[
                    TextSpan(
                      text: '${LocaleKeys.login} '.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: LocaleKeys.yourAccount.tr(),
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    )
                  ])),
                ),
                10.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "${LocaleKeys.loginOurWebsite.tr()} ",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: LocaleKeys.registerCapital.tr(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        loginProvider.navigateToSignupScreen();
                                      })
                              ]))),
                )
              ],
            )));
  }
}
