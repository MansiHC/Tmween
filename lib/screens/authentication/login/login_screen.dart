import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/login/store_owner_login_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/login_controller.dart';
import 'individual_login_screen.dart';

class LoginScreen extends StatefulWidget {
  final String from;

  LoginScreen({Key? key, required this.from}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  var language;
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    _tabController =
        new TabController(vsync: this, length: loginController.tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (contet) {
          loginController.context = context;
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
                                          MediaQuery.of(context).size.height /
                                              2.4),
                                  child: topView(loginController)),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    labelColor: AppColors.primaryColor,
                                    unselectedLabelColor: Colors.black,
                                    tabs: loginController.tabList),
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

  Widget topView(LoginController loginController) {
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
                            loginController.exitScreen(widget.from);
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
                      text: '${LocaleKeys.login.tr} ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: LocaleKeys.yourAccount.tr,
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
                              text: "${LocaleKeys.loginOurWebsite.tr} ",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white70),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: LocaleKeys.registerCapital.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        loginController
                                            .navigateToSignupScreen();
                                      })
                              ]))),
                )
              ],
            )));
  }
}
