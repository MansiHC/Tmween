import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/splash_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../model/language_model.dart';

class SplashScreen extends StatelessWidget {
  var language;
  final splashController = Get.put(SplashController());

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

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    if (language == 'ar') {
      splashController.languageValue = splashController.languages[1];
    } else if (language == 'es') {
      splashController.languageValue = splashController.languages[2];
    }
    var flagIcon = _getFlagIcon();
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (contet) {
          splashController.context = context;
          return Scaffold(
              body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstanst.splashBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.height / 4,
                    child: SvgPicture.asset(ImageConstanst.logo),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 60, right: 15, left: 15),
                    child: Align(
                        alignment: language == 'ar'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SvgPicture.asset(flagIcon, width: 20, height: 20),
                            5.widthBox,
                            DropdownButton<LanguageModel>(
                              isDense: true,
                              underline: Container(color: Colors.transparent),
                              value: splashController.languageValue,
                              dropdownColor: AppColors.primaryColor,
                              style: TextStyle(color: Colors.white),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              items: splashController.languages
                                  .map((LanguageModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.name.tr),
                                );
                              }).toList(),
                              onChanged: (LanguageModel? value) async {
                                splashController.languageValue = value!;
                                /* MySharedPreferences.instance.addStringToSF(
                                    SharedPreferencesKeys.language,
                                    value.locale.toString());
                                Get.updateLocale(value.locale);*/
                              },
                            ),
                          ],
                        ))),
                Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          width: 210,
                          text: LocaleKeys.getStarted,
                          onPressed: () {
                            splashController.navigateToLogin();
                          },
                        )))
              ],
            ),
          ));
        });
  }
}


/*

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (contet) {
          signUpController.context = context;
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
                                          ? (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3)
                                          : (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3.5)),
                                  child: topView(signUpController)),
                              ColoredBox(
                                color: Color.fromRGBO(195, 208, 225, 1),
                                child: TabBar(
                                  physics: ScrollPhysics(),
                                    controller: _tabController,
                                    indicator: BoxDecoration(
                                        color: AppColors.primaryColor),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    tabs: signUpController.tabList),
                              ),
                              Expanded(
                                child: TabBarView(
                                  physics: ScrollPhysics(),
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

  Widget topView(SignUpController signUpController) {
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
                                  )
                                ])))),
              ],
            )));
  }
}


 */