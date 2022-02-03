import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  CustomButton({required this.text, required this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? double.infinity,
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
          ),
        ));
  }
}
