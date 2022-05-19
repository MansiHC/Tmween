import 'dart:ui';

class LanguageModel {
  const LanguageModel(
      {required this.name, required this.image, required this.locale});

  final String name;
  final String image;
  final Locale locale;

  static fromJson(responseJson) {
    return null;
  }
}
