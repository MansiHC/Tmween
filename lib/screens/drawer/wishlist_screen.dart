import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/screens/drawer/wishlist_container.dart';

import '../../lang/locale_keys.g.dart';
import '../../utils/global.dart';
import '../../utils/views/custom_text_form_field.dart';
import 'dashboard/sold_by_tmween_container.dart';

class WishlistScreen extends  StatelessWidget {
final soldByTmweenController = Get.put(WishlistController());

@override
Widget build(BuildContext context) {
  return GetBuilder<WishlistController>(
      init: WishlistController(),
      builder: (contet) {
        soldByTmweenController.context = context;

        return Scaffold(

            body:Container(
                color: Colors.white,child: Container(
                      margin: EdgeInsets.only(top:20,bottom: 10,right: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      padding: EdgeInsets.all(1.5),
                      child: GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 0.66,
                          physics: ScrollPhysics(),
                          children: List.generate(
                              soldByTmweenController.soldByTmweens.length,
                                  (index) {
                                return WishlistContainer(
                                  soldByTmween:
                                  soldByTmweenController.soldByTmweens[index],
                                );
                              })))
            ));
      });
}
}
