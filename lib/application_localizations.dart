import 'package:flutter/material.dart';

class ApplicationLocalizations {
  //Locale locale;
  /*static Map<dynamic, dynamic> _localisedValues;

  ApplicationLocalizations(Locale locale) {
    this.locale = locale;
  }
*/
  static ApplicationLocalizations? of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(
        context, ApplicationLocalizations);
  }

/*static Future<ApplicationLocalizations> load(Locale locale) async {
    ApplicationLocalizations appTranslations = ApplicationLocalizations(locale);
    String jsonContent = await rootBundle
        .loadString("asset/language/${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }
*/
//get currentLanguage => locale.languageCode;

/*String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }*/
}

/*
class AppTranslationsDelegate
    extends LocalizationsDelegate<ApplicationLocalizations> {
  final Locale newLocale;

  const AppTranslationsDelegate({required this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return Helper.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<ApplicationLocalizations> load(Locale locale) {
    return ApplicationLocalizations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<ApplicationLocalizations> old) {
    return true;
  }
}
*/
