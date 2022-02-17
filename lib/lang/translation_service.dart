import 'dart:ui';

import 'package:get/get.dart';
import 'package:tmween/lang/ar_DZ.dart';
import 'package:tmween/lang/en_US.dart';
import 'package:tmween/lang/es_ES.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Get.locale;

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en_US': en_US, 'es_ES': es_ES, 'ar_DZ': ar_DZ};
}
