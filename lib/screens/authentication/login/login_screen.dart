import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/login/store_owner/store_owner_login_password_screen.dart';
import 'package:tmween/screens/authentication/login/store_owner/store_owner_login_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../controller/login_controller.dart';
import 'individual/individual_login_password_screen.dart';
import 'individual/individual_login_screen.dart';

class LoginScreen extends StatefulWidget {
  final String from;
  final String? frm;
  final String? frmReset;
  final bool? isPassword;
  final bool? isStorePassword;

  LoginScreen(
      {Key? key,
      required this.from,
      this.frm,
      this.frmReset,
      this.isPassword = false,
      this.isStorePassword = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  /*late AnimationController controller;
  late Animation<Offset> offset;
*/
  var language;
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    print('object.....${widget.from}.......${widget.frm}');
    if (widget.from == SharedPreferencesKeys.isDrawer) {

      if (widget.isPassword!) {
        loginController.currentTabIndex = 0;
      } else {
        loginController.currentTabIndex = 1;
      }

    }

    if(widget.frm == AppConstants.individual || widget.frmReset == AppConstants.individual){
      loginController.currentTabIndex = 0;
    } else {
      loginController.currentTabIndex = 1;
    }
    loginController.isPasswordScreen = widget.isPassword!;
    loginController.isStorePasswordScreen = widget.isStorePassword!;
    loginController.tabController = TabController(
        vsync: this,
        length: loginController.tabList.length,
        initialIndex: loginController.currentTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    loginController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('jhjsdh.....');
    language = Get.locale!.languageCode;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (contet) {
          loginController.context = context;

          return DefaultTabController(
              length: 2,
              child: WillPopScope(
              onWillPop: () => _onWillPop(loginController),
          child:Scaffold(
                  body: NestedScrollView(
              headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  toolbarHeight: MediaQuery.of(context).size.height /
                      3.4,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: topView(loginController),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.asset(
                            ImageConstanst.loginBackground,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: ColoredBox(
                          color: Color.fromRGBO(195, 208, 225, 1),
                          child: TabBar(
                              onTap: (index) {
                                loginController.currentTabIndex = index;
                              },
                              controller: loginController.tabController,
                              indicator: BoxDecoration(
                                  color: AppColors.primaryColor),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: loginController.tabList)))),

             ];
              },
                    body: TabBarView(
                      controller: loginController.tabController,
                      children: [
                        loginController.isPasswordScreen
                            ? IndividualLoginPasswordScreen(
                            from: widget.from)
                            : IndividualLoginScreen(),
                        loginController.isStorePasswordScreen
                            ? StoreOwnerLoginPasswordScreen(
                            from: widget.from)
                            : StoreOwnerLoginScreen()
                      ],
                    ),
                  ))));
        });
  }
  Future<bool> _onWillPop(LoginController loginController) async {
    loginController.exitScreen(widget.from, widget.frm);
    return true;
  }

  Widget topView(LoginController loginController) {
    return
       Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: Column(
mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Align(
                    alignment: language == 'ar'
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            loginController.exitScreen(widget.from, widget.frm);
                          },
                          child:  Icon(
                                Icons.keyboard_arrow_left_sharp,
                                color: Colors.black,
                                size: 24,
                              ),
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
                ),
                10.heightBox,
              ],
            ));
  }
}
