import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/signup_provider.dart';
import 'package:tmween/screens/authentication/signup/individual_signup_screen.dart';
import 'package:tmween/screens/authentication/signup/store_owner_signup_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late List<Tab> tabList;
  late TabController _tabController;
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
    return Consumer<SignUpProvider>(builder: (context, signUpProvider, _) {
      signUpProvider.context = context;
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
                                  maxHeight: language == 'ar'
                                      ? (MediaQuery.of(context).size.height / 3)
                                      : (MediaQuery.of(context).size.height /
                                          3.5)),
                              child: topView(signUpProvider)),
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
                                IndividualSignUpScreen(),
                                StoreOwnerSignUpScreen()
                              ],
                            ),
                          )
                        ],
                      )))));
    });
  }

  Widget topView(SignUpProvider signUpProvider) {
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
                                    signUpProvider.exitScreen();
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
                                          MediaQuery.of(context).size.height /
                                              6.5,
                                      width:
                                          MediaQuery.of(context).size.height /
                                              6.5,
                                      child:
                                          SvgPicture.asset(ImageConstanst.logo),
                                    ))),
                          ],
                        ))),
                Align(
                  alignment: Alignment.topCenter,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(text: ' ', children: <InlineSpan>[
                        TextSpan(
                          text: '${LocaleKeys.signUp} '.tr(),
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
                                  )
                                ])))),
              ],
            )));
  }
}
