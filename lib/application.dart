import 'dart:ui';

import 'package:tmween/utils/helper.dart';

class Application {
  // static final Application _application = Application._internal();

  /*factory Application() {
    return _application;
  }
*/
  //Application._internal();

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      Helper.supportedLanguages.map<Locale>((language) => Locale(language, ""));

//function to be invoked when changing the language
// LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
