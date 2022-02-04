import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmween/provider/login_provider.dart';
import 'package:tmween/provider/otp_provider.dart';
import 'package:tmween/provider/signup_provider.dart';
import 'package:tmween/screens/splash_screen.dart';
import 'package:tmween/theme.dart';
import 'package:tmween/utils/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isDarkTheme = prefs.getBool(SharedPreferencesKeys.isDarkTheme);
  ThemeData theme;
  if (isDarkTheme != null) {
    theme = isDarkTheme ? darkTheme : lightTheme;
  } else {
    theme = lightTheme;
  }

  runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
        ],
        path: 'asset/lang',
        child:
        ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(theme),
      child: MyApp(),
      builder: (context, wigdet) => MyApp(),
    ),)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        //  ListenableProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Tmween',
        theme: themeNotifier.getTheme(),
        home: SplashScreen(),
      ),
    );
  }
}
