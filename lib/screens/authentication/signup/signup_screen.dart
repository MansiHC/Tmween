import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/signup_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/authentication/signup/individual_signup_screen.dart';
import 'package:tmween/screens/authentication/signup/store_owner_signup_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class SignUpScreen extends StatefulWidget {
  final String from;

  SignUpScreen({Key? key, this.from = LocaleKeys.storeOwner}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final signUpController = Get.put(SignUpController());
  late TabController _tabController;
  var language;

  @override
  void initState() {
    _tabController = new TabController(
        vsync: this,
        length: signUpController.tabList.length,
        initialIndex: widget.from == LocaleKeys.individual ? 0 : 1);
    super.initState();
  }

  Future<bool> _onWillPop(SignUpController signUpController) async {
    signUpController.exitScreen();
    return true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return SafeArea(
        top: false,
        child: GetBuilder<SignUpController>(
            init: SignUpController(),
            builder: (contet) {
              signUpController.context = context;
              return WillPopScope(
                  onWillPop: () => _onWillPop(signUpController),
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                          body: NestedScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return [
                            SliverAppBar(
                                toolbarHeight: language == 'ar'
                                    ? (MediaQuery.of(context).size.height / 4)
                                    : (MediaQuery.of(context).size.height /
                                        4.4),
                                automaticallyImplyLeading: false,
                                titleSpacing: 0,
                                title: topView(signUpController),
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
                                            controller: _tabController,
                                            indicator: BoxDecoration(
                                                color: AppColors.primaryColor),
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            labelStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            labelColor: Colors.white,
                                            unselectedLabelColor: Colors.black,
                                            tabs: signUpController.tabList)))),
                          ];
                        },
                        body: TabBarView(
                          controller: _tabController,
                          children: [
                        Column(
                        children: [
                        Padding(
                        padding: EdgeInsets.only(
                            top: 0,
                            right: MediaQuery.of(
                                signUpController
                                    .context)
                                .size
                                .width /
                                2),
                              child: SvgPicture.asset(ImageConstanst.downArrowIcon,height: 12,width: 12,
                                color: AppColors.primaryColor,)),
                        Expanded(
                          child:IndividualSignUpScreen())]),
                      Column(
                          children: [
                      Padding(
                      padding: EdgeInsets.only(
                      top: 0,
                          left: MediaQuery.of(
                              signUpController
                                  .context)
                              .size
                              .width /
                              2),
                      child: SvgPicture.asset(ImageConstanst.downArrowIcon,height: 12,width: 12,
                        color: AppColors.primaryColor,)),
                Expanded(
                  child:StoreOwnerSignUpScreen())])
                          ],
                        ),
                      ))));
            }));
  }

  Widget topView(SignUpController signUpController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 9.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                signUpController.exitScreen();
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
                        ),
                        Positioned(
                            top: -24,
                            left: 0,
                            right: 0,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 6.5,
                                  width:
                                      MediaQuery.of(context).size.height / 6.5,
                                  child: SvgPicture.asset(ImageConstanst.logo),
                                ))),
                      ],
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(text: ' ', children: <InlineSpan>[
                    TextSpan(
                      text: '${LocaleKeys.signUp} '.tr,
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
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                            children: <InlineSpan>[
                              TextSpan(
                                text: LocaleKeys.registerCapital.tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ])))),
          ],
        ));
  }
}
