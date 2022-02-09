import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/provider/dashboard_provider.dart';
import 'package:tmween/provider/drawer_provider.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/provider/otp_provider.dart';
import 'package:tmween/provider/signup_provider.dart';
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
      .getBoolValuesSF(AppConstants.isSplash)
      .then((value) async {
    isSplash = value ?? false;
    MySharedPreferences.instance
        .getBoolValuesSF(AppConstants.isLogin)
        .then((value) async {
      isLogin = value ?? false;
    });
  });

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('ar', 'DZ'),
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
        //  ListenableProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Tmween',
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
