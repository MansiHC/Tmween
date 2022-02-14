import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/best_seller_provider.dart';
import 'package:tmween/provider/categories_provider.dart';
import 'package:tmween/provider/dashboard_provider.dart';
import 'package:tmween/provider/deals_of_the_day_provider.dart';
import 'package:tmween/provider/drawer_provider.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/provider/otp_provider.dart';
import 'package:tmween/provider/recently_viewed_provider.dart';
import 'package:tmween/provider/signup_provider.dart';
import 'package:tmween/provider/sold_by_tmween_provider.dart';
import 'package:tmween/provider/top_selection_provider.dart';
import 'package:tmween/screens/authentication/login/login_screen.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/splash_screen.dart';
import 'package:tmween/theme.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/my_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

/*
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(SharedPreferencesKeys.isDarkTheme);
*/
  ThemeData theme = lightTheme;
  var isLogin = false;
  var isSplash = false;
/*
  if (isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }
*/
  MySharedPreferences.instance
      .getBoolValuesSF(SharedPreferencesKeys.isSplash)
      .then((value) async {
    isSplash = value ?? false;
    MySharedPreferences.instance
        .getBoolValuesSF(SharedPreferencesKeys.isLogin)
        .then((value) async {
      isLogin = value ?? false;
    });
  });

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'DZ'),
      Locale('es', 'ES'),
    ],
    path: 'asset/lang',
    child: ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(
        isLogin: isLogin,
        isSplash: isSplash,
      ),
      builder: (context, wigdet) => MyApp(
        isLogin: isLogin,
        isSplash: isSplash,
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final bool isSplash;

  MyApp({Key? key, required this.isLogin, required this.isSplash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => DrawerProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => DealsOfTheDayProvider()),
        ChangeNotifierProvider(create: (context) => SoldByTmweenProvider()),
        ChangeNotifierProvider(create: (context) => BestSellerProvider()),
        ChangeNotifierProvider(create: (context) => TopSelectionProvider()),
        ChangeNotifierProvider(create: (context) => RecentlyViewedProvider()),
        //  ListenableProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: LocaleKeys.appTitle.tr(),
        theme: themeNotifier.getTheme(),
        home: !isSplash
            ? SplashScreen()
            : isLogin
                ? DrawerScreen()
                : LoginScreen(),
      ),
    );
  }
}
