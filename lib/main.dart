import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/productDetail/product_detail_screen.dart';
import 'package:tmween/screens/splash_screen.dart';
import 'package:tmween/theme.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/helper.dart';
import 'package:tmween/utils/my_shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  // iOS requires you run in release mode to test dynamic links ("flutter run --release").
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  ThemeData theme = lightTheme;
  var isLogin = false;
  var isSplash = false;
  var isDrawer = false;
  var language = 'en_US';

  MySharedPreferences.instance
      .getStringValuesSF(SharedPreferencesKeys.language)
      .then((value) async {
    language = value ?? 'en_US';
    print('.......$language');
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isSplash)
        .then((value) async {
      isSplash = value ?? false;
      MySharedPreferences.instance
          .getBoolValuesSF(SharedPreferencesKeys.isLogin)
          .then((value) async {
        isLogin = value ?? false;
        MySharedPreferences.instance
            .getBoolValuesSF(SharedPreferencesKeys.isDrawer)
            .then((value) async {
          isDrawer = value ?? false;
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
              .then((_) {
            runApp(
              /*MyApp2()*/
              MyApp(
                isLogin: isLogin,
                isSplash: isSplash,
                isDrawer: isDrawer,
                language: language,
              ),
            );
          });
        });
      });
    });
  });
}

class MyApp extends StatefulWidget {
  final bool isLogin;
  final bool isSplash;
  final bool isDrawer;
  final String language;

  MyApp(
      {Key? key,
      required this.isLogin,
      required this.isSplash,
      required this.isDrawer,
      required this.language})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool fromDynamicLink = false;
  late int productId;
  late String productSlug;

  @override
  void initState() {
    // TODO: implement initState
    fromDynamicLink=false;
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink().then((dynamicLinkData) {
    if(dynamicLinkData!=null) {
      final queryParams = dynamicLinkData.link.queryParameters;
      if (queryParams.length > 0) {
        fromDynamicLink = true;
        productId = int.parse(queryParams['id']!);
        productSlug = queryParams['slug']!;
        setState(() {});
      }
    }
    });

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final queryParams = dynamicLinkData.link.queryParameters;
      if (queryParams.length > 0) {
        fromDynamicLink = true;
        productId = int.parse(queryParams['id']!);
        productSlug = queryParams['slug']!;
        setState(() {
        });
}
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageCode = widget.language.split('_')[0];
    String deviceLanguageCode = Platform.localeName.split('_')[0];
    print('.....$languageCode......$deviceLanguageCode');
    Locale currentLocale = Locale('en', 'US');

    if (deviceLanguageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (deviceLanguageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (deviceLanguageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }

    if (languageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (languageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (languageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }


    return GetMaterialApp(
      translations: TranslationService(),
      locale: currentLocale,
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.appTitle,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primaryColor,
          brightness: Brightness.light,
          backgroundColor: const Color(0xFFE5E5E5),
          accentColor: Colors.black,
          accentIconTheme: IconThemeData(color: Colors.white),
          dividerColor: Colors.white54,
          fontFamily: AppConstants.fontFamily),
      home: fromDynamicLink
          ? ProductDetailScreen(productId: productId, productslug: productSlug,fromDeepLink: true,)
          : widget.isDrawer
              ? DrawerScreen()
              : widget.isLogin
                  ? DrawerScreen()
                  : SplashScreen(),
    );
  }
}
