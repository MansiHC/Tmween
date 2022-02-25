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
  final bool fromProfile;
  late String language;
  WishlistScreen({Key? key, this.fromProfile = false}) : super(key: key);

  final wishlistController = Get.put(WishlistController());

@override
Widget build(BuildContext context) {
  language = Get.locale!.languageCode;
  return GetBuilder<WishlistController>(
      init: WishlistController(),
      builder: (contet) {
        wishlistController.context = context;

        return Scaffold(
           body:Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Visibility(
                  visible: fromProfile,
                  child:  Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 90),
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 20),
                        child: topView(wishlistController))),

                  Visibility(
                      visible: fromProfile,
                      child: Container(
                          color: AppColors.appBarColor,
                          child: Container(
                              decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(2)),
                              height: 40,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 15, right: 15),
                              child: CustomTextFormField(
                                  isDense:true,
                                  controller: wishlistController.searchController,
                                  keyboardType: TextInputType.text,
                                  hintText: LocaleKeys.searchProducts.tr,
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (term) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColors.primaryColor,
                                    size: 32,
                                  ),
                                  validator: (value) {
                                    return null;
                                  })))),
                  Expanded(child:Container(
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
                              wishlistController.soldByTmweens.length,
                                  (index) {
                                return WishlistContainer(
                                  soldByTmween:
                                  wishlistController.soldByTmweens[index],
                                );
                              })))
                  ))],
        ),
        ));
      });
}

  Widget topView(WishlistController wishlistController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(
          children: [
            Align(
                alignment: language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: InkWell(
                      onTap: () {
                        wishlistController.exitScreen();
                      },
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Icons.keyboard_arrow_left_sharp,
                            color: Colors.black,
                          )),
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.wishLists.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }

}