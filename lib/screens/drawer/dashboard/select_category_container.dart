import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/select_category_model.dart';
import '../../../utils/global.dart';

class SelectCategoryContainer extends StatelessWidget {
   SelectCategoryContainer({Key? key, required this.category,this.offerVisible=true})
      : super(key: key);
  final SelectCategoryModel category;
  final bool offerVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           Visibility(visible:offerVisible,child:  Align(
                alignment: Alignment.topRight,
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.offerGreen,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      children: [
                        Text('${category.offer}%',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Text(LocaleKeys.off.tr(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    )))),
            5.heightBox,
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(category.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 13))),
            5.heightBox,
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.network(
                      category.image,
                      fit: BoxFit.cover,
                    ))),
            5.heightBox
          ]),
    );
  }
}
