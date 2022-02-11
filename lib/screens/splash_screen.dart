import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../utils/my_shared_preferences.dart';
import 'authentication/login/login_screen.dart';
import 'lang_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  var language;

  @override
  Widget build(BuildContext context) {
    language = context.locale.toString().split('_')[0];
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
          /*Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                LocaleKeys.clickMe,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ).tr()),*/
          Padding(
              padding: EdgeInsets.only(top: 30, right: 15, left: 15),
              child: Align(
                  alignment:
                      language == 'ar' ? Alignment.topLeft : Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LanguageView(),
                              fullscreenDialog: true),
                        ).then((value) {
                          if (value) {
                            setState(() {});
                          }
                        });
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            language != null ? language : 'en',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          5.widthBox,
                          Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                        ],
                      )))),
          Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    width: 205,
                    text: LocaleKeys.getStarted,
                    onPressed: () {
                      MySharedPreferences.instance
                          .addBoolToSF(SharedPreferencesKeys.isSplash, true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  )))
        ],
      ),
    ));
  }
}
