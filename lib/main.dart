import 'dart:convert';
import 'dart:io' show HttpHeaders, Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/drawer_screen.dart';
import 'package:tmween/screens/drawer/productDetail/product_detail_screen.dart';
import 'package:tmween/screens/splash_screen.dart';
import 'package:tmween/theme.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/my_shared_preferences.dart';

import 'lang/translation_service.dart';
import 'model/get_sub_category_model.dart';

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
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  ThemeData theme = lightTheme;
  var isLogin = false;
  var isSplash = false;
  var isDrawer = false;
  var language = '';

  MySharedPreferences.instance
      .getStringValuesSF(SharedPreferencesKeys.language)
      .then((value) async {
    language = value ?? '';
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
              MyApp(
                isLogin: isLogin,
                isSplash: isSplash,
                isDrawer: isDrawer,
                language: language,
              ),
            );
            /* runApp(MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => ConnectionService()),
              ],
              child: MyApp2(),
            ));*/
          });
        });
      });
    });
  });
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
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
    fromDynamicLink = false;
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance
        .getInitialLink()
        .then((dynamicLinkData) {
      if (dynamicLinkData != null) {
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
        setState(() {});
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = "";
    if (widget.language.isNotEmpty)
      languageCode = widget.language.split('_')[0];
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
    if (languageCode.isNotEmpty) if (languageCode == 'en') {
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
          ? ProductDetailScreen(
              productId: productId,
              productslug: productSlug,
              fromDeepLink: true,
            )
          : widget.isDrawer
              ? DrawerScreen()
              : widget.isLogin
                  ? DrawerScreen()
                  : SplashScreen(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var startTime = "";
  var endTime = "";

  void _network() async {
    var client = http.Client();

    RoleService _roleService = RoleService();
    String authToken = "****";

    String uid = "555555";
    try {
      await _roleService.getAllRoles(authToken, client);
      //await _roleService.getAllRoles(authToken, client);

    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "Start Time: " + startTime,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "End Time: " + endTime,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _network,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RoleService with ChangeNotifier {
  late GetSubCategoryModel _roles;
  String link2 = "https://api2.somewhere.com/userrel";

  /// Return roles
  GetSubCategoryModel returnRoles() {
    return _roles;
  }

  /// Get all Roles
  Future<void> getAllRoles(String authToken, Client client) async {
    try {
      var data = await client.post(
          Uri.parse("http://admin.tmween.com/api/v1/get-subcategory-data"),
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer 4L1YpgPnsb3M3tqt6Jhfa9H6xDw0RIUPYaQk41K8hAKWilYg41hP3P60Er7RRw8v8dCpLhiMqYa9Q2hA"
          },
          body: json.encode({
            "entity_type_id": "4",
            "device_type": "1",
            "lang_code": "en",
            "category_id": "1"
          }));

      var jsonData = json.decode(data.body.toString());
      _roles = GetSubCategoryModel.fromJson(jsonData);
      print(_roles.toString());
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

class ConnectionService with ChangeNotifier {
  http.Client _client = http.Client();

  http.Client returnConnection() {
    return _client;
  }
}
