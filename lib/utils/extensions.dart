import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

extension StringExtension on String {
  String firstLetterUpperCase() => length > 1
      ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}"
      : this;

  String get eliminateFirst => length > 1 ? "${substring(1, length)}" : "";

  String get eliminateLast => length > 1 ? "${substring(0, length - 1)}" : "";

  bool get isEmpty => trimLeft().isEmpty;

  bool validateEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool validatePassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(this);

  setNetworkImage()=>CachedNetworkImage(
    imageUrl: toString(),
    placeholder: (context, url) =>
        Center(child:CupertinoActivityIndicator()
        )
    ,
    errorWidget: (context, url, error) => Icon(Icons.image_not_supported,color: Colors.grey,),
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
