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
