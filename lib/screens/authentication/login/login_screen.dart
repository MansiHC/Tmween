import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

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

  @override
  void initState() {
    tabList = <Tab>[];
    tabList.add(new Tab(
      text: 'Individual',
    ));
    tabList.add(new Tab(
      text: 'Store Owner',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      loginProvider.context = context;
      return DefaultTabController(
          length: 2,
          child: Scaffold(
              body: Column(
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: double.infinity,
                      maxHeight: MediaQuery.of(context).size.height / 2.4),
                  child: topView(loginProvider)),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border(
                      bottom: BorderSide(
                          color: AppColors.primaryColor, width: 0.8)),
                ),
                child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.black,
                    tabs: tabList),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [IndividualLoginScreen(), IndividualLoginScreen()],
                ),
              )
            ],
          )));
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
                    alignment: Alignment.topLeft,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white, // Button color
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
                      text: 'Login ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Your Account',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    )
                  ])),
                ),
                10.heightBox,
                Align(
                    alignment: Alignment.topCenter,
                    child: Text.rich(TextSpan(
                        text: 'Login to our website or ',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'REGISTER',
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
              ],
            )));
  }
}
