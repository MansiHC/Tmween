import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../lang/locale_keys.g.dart';
import 'global.dart';

extension NumExtension on num {
  Widget get widthBox => SizedBox(
        width: toDouble(),
      );

  Widget get heightBox => SizedBox(
        height: toDouble(),
      );
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension StringExtension on String {
  String firstLetterUpperCase() => length > 1
      ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}"
      : this;

  String get eliminateFirst => length > 1 ? "${substring(1, length)}" : "";

  String get eliminateLast => length > 1 ? "${substring(0, length - 1)}" : "";

  String get formattedDate =>
      DateFormat('dd MMMM yyyy').format(DateTime.parse(toString()));

String get formattedDateTime =>
      DateFormat('dd MMMM, hh:mm a').format(DateTime.parse(toString()));

  bool get isEmpty => trimLeft().isEmpty;

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool validatePassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$')
          .hasMatch(this);

  bool validateMobile() => RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);

  bool validateEmailMobileNumber() => RegExp(r'^[a-zA-Z0-9@]+$').hasMatch(this);

  setNetworkImage() => toString().isNotEmpty
      ? CachedNetworkImage(
          imageUrl: toString(),
          placeholder: (context, url) =>
              Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) => Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        )
      : Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        );

  setNetworkImageProvider() => toString().isNotEmpty
      ? CachedNetworkImageProvider(
          toString(),
          errorListener: () => Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        )
      : Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        );
}

extension IterableExtensions<E> on Iterable<E> {
  Iterable<List<E>> chunked(int chunkSize) sync* {
    if (length <= 0) {
      yield [];
      return;
    }
    int skip = 0;
    while (skip < length) {
      final chunk = this.skip(skip).take(chunkSize);
      yield chunk.toList(growable: false);
      skip += chunkSize;
      if (chunk.length < chunkSize) return;
    }
  }
}

extension WidgetExtension on Widget {
  Widget buildTimer(time, [textSize]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.otpExpire.tr,
          style: TextStyle(fontSize: textSize ?? 16, color: Colors.black),
        ),
        /*TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (_, value, child) => Text(
            "00:${value!.toInt()}",
            style: TextStyle(color: AppColors.primaryColor,fontSize: 16),
          ),
        ),*/
        5.widthBox,
        TweenAnimationBuilder<Duration>(
            duration: Duration(seconds: time),
            tween: Tween(begin: Duration(seconds: time), end: Duration.zero),
            onEnd: () {
              print('Timer ended');
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final minutes = value.inMinutes;
              final seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: (textSize ?? 16) + 4.0)));
            }),
      ],
    );
  }
}

// This is the source of mapped Flutter colors
const Map<String, Color> SOURCE = {
  "transparent": Colors.transparent,
  "black": Colors.black,
  "white": Colors.white,
  "multi color": Colors.white,
  "green": Colors.green,
  "greenAccent": Colors.greenAccent,
  "lightGreen": Colors.lightGreen,
  "lightGreenAccent": Colors.lightGreenAccent,
  "blue": Colors.blue,
  "blueAccent": Colors.blueAccent,
  "blueGrey": Colors.blueGrey,
  "lightBlue": Colors.lightBlue,
  "lightBlueAccent": Colors.lightBlueAccent,
  "red": Colors.red,
  "redAccent": Colors.redAccent,
  "orange": Colors.orange,
  "orangeAccent": Colors.orangeAccent,
  "deepOrange": Colors.deepOrange,
  "deepOrangeAccent": Colors.deepOrangeAccent,
  "brown": Colors.brown,
  "amber": Colors.amber,
  "amberAccent": Colors.amberAccent,
  "yellow": Colors.yellow,
  "yellowAccent": Colors.yellowAccent,
  "cyan": Colors.cyan,
  "cyanAccent": Colors.cyanAccent,
  "purple": Colors.purple,
  "purpleAccent": Colors.purpleAccent,
  "deepPurple": Colors.deepPurple,
  "deepPurpleAccent": Colors.deepPurpleAccent,
  "grey": Colors.grey,
  "indigo": Colors.indigo,
  "indigoAccent": Colors.indigoAccent,
  "lime": Colors.lime,
  "limeAccent": Colors.limeAccent,
  "pink": Colors.pink,
  "pinkAccent": Colors.pinkAccent,
  "teal": Colors.teal,
  "tealAccent": Colors.tealAccent
};

// This extesion provide the hability of String extending to makes easier the use of the API
extension StringToColor on String {
  // substring start to find the real hexa value
  static final start = 1;

  // substring end to find the real hexa value
  static final end = 7;

  // hexa base
  static final radix = 16;

  // complement to the 32-bits number
  static final complement = 0xFF000000;

  // The function that bind the color from hexa into a Flutter Color
  colorFromHex() {
    return Color(
        int.parse(this.substring(start, end), radix: radix) + complement);
  }

  // The function that bind the color name into a Flutter Color
  color() {
    try {
      if (SOURCE.containsKey(this)) {
        return SOURCE[this];
      }
      return this.colorFromHex();
    } catch (e) {
      return Colors.transparent;
    }
  }
}

// This extesion provide the hability of Color extending to makes easier the use of the API to compute contrast
extension ContrastToColor on Color {
  // half brightness to compute luminance
  static final brightness = 0.5;

  // The function that calculate human brightness perception to expose better contrast against the color
  contrast() {
    try {
      return this.computeLuminance() > brightness
          ? Colors.black87
          : Colors.white;
    } catch (e) {
      return Colors.white;
    }
  }
}
