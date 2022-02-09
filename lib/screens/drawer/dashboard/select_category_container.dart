import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/utils/extensions.dart';

import '../../../model/select_category_model.dart';
import '../../../utils/global.dart';

class SelectCategoryContainer extends StatelessWidget {
  const SelectCategoryContainer({Key? key, required this.category})
      : super(key: key);
  final SelectCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color:AppColors.offerGreen,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      children: [
                        Text('${category.offer}%',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                        Text('OFF',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10)),
                      ],
                    ))),
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
