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

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String link = "";

  @override
  void initState() {
    initUniLinks().then((value) => setState(() {
          link = value!;
        }));
    super.initState();
  }

  Future<String?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      return initialLink;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(link == null ? "" : link),
          ],
        ),
      ),
    );
  }
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
    Locale currentLocale = Locale('en', 'US');
    if (languageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (languageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (languageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }
    /*if (deviceLanguageCode == 'en') {
      currentLocale = Locale('en', 'US');
    } else if (deviceLanguageCode == 'ar') {
      currentLocale = Locale('ar', 'DZ');
    } else if (deviceLanguageCode == 'es') {
      currentLocale = Locale('es', 'ES');
    }*/

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
/*

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // iOS requires you run in release mode to test dynamic links ("flutter run --release").
  await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'Dynamic Links Example',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => _MainScreen(),
        '/productDetail': (BuildContext context) => _DynamicLinkScreen(),
      },
    ),
  );
}

class _MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String _testString =
      'To test: long press link and then copy and click from a non-browser '
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      'is properly setup. Look at firebase_dynamic_links/README.md for more '
      'details.';

  final String DynamicLink = 'https://tmween.page.link/productDetail?id=3';
  final String Link = 'https://tmween.page.link/productDetail?id=3';

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final queryParams = dynamicLinkData.link.queryParameters;
      print('.....bhjdghjsdg...${dynamicLinkData.link.queryParameters}');
      if (queryParams.length > 0) {
        var userName = queryParams['id'];
        print('.....bhjdghjsdg...${dynamicLinkData.link.queryParameters}....$userName');
      }
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: AppConstants.deepLinkUrlPrefix,
     /* longDynamicLink: Uri.parse(
        'https://tmween.page.link/?id=3&ibi=io.invertase.testing&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Ftest-app%2Fhelloworld&ofl=https://ofl-example.com',
      ),*/
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.tmween.tmween',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Example'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          final PendingDynamicLinkData? data =
                          await dynamicLinks.getInitialLink();
                          final Uri? deepLink = data?.link;

                          if (deepLink != null) {
                            // ignore: unawaited_futures
                            Navigator.pushNamed(context, deepLink.path);
                          }
                        },
                        child: const Text('getInitialLink'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final PendingDynamicLinkData? data =
                          await dynamicLinks
                              .getDynamicLink(Uri.parse(Link));
                          final Uri? deepLink = data?.link;

                          if (deepLink != null) {
                            // ignore: unawaited_futures
                            Navigator.pushNamed(context, deepLink.path);
                          }
                        },
                        child: const Text('getDynamicLink'),
                      ),
                      ElevatedButton(
                        onPressed: !_isCreatingLink
                            ? () => _createDynamicLink(false)
                            : null,
                        child: const Text('Get Long Link'),
                      ),
                      ElevatedButton(
                        onPressed: !_isCreatingLink
                            ? () => _createDynamicLink(true)
                            : null,
                        child: const Text('Get Short Link'),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (_linkMessage != null) {
                        await launch(_linkMessage!);
                      }
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: _linkMessage));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied Link!')),
                      );
                    },
                    child: Text(
                      _linkMessage ?? '',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text(_linkMessage == null ? '' : _testString)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DynamicLinkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World DeepLink'),
        ),
        body: const Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdRjCVZlhrq72RuEklEyyxYlBRCYhI2Sw',
    appId: '1:406099696497:android:40da41183cb3d3ff3574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
    'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:406099696497:ios:e666f0a995aa455a3574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
    'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
    '406099696497-tvtvuiqogct1gs1s6lh114jeps7hpjm5.apps.googleusercontent.com',
    iosClientId:
    '406099696497-nqjkqmm0fm17cdksju0o817aj226ooqb.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.dynamiclinksexample',
  );
}
*/
