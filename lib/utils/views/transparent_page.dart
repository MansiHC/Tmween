import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/utils/views/circular_progress_bar.dart';

class TransparentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100]!.withOpacity(0.1),
      child: Center(
        child: CircularProgressBar(),
      ),
    );
  }
}
