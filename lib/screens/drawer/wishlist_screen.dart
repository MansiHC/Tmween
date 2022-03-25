import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/wishlist_controller.dart';
import 'package:tmween/screens/drawer/wishlist_container.dart';

import '../../lang/locale_keys.g.dart';
import '../../utils/global.dart';
import '../../utils/views/circular_progress_bar.dart';
import 'dashboard/product_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  final bool fromProfile;
  late String language;

  WishlistScreen({Key? key, this.fromProfile = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WishlistScreenState();
  }

}
class WishlistScreenState extends State<WishlistScreen> {
  late String language;


  final wishlistController = Get.put(WishlistController());

  Future<bool> _onWillPop(WishlistController wishlistController) async {
    wishlistController.exitScreen();
    return true;
  }

  @override
  void initState() {
   wishlistController.getWishListData('en');
   wishlistController.update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;

    return GetBuilder<WishlistController>(
        init: WishlistController(),
        builder: (contet) {
          wishlistController.context = context;
          return WillPopScope(
              onWillPop: () => _onWillPop(wishlistController),
          child:Scaffold(
              body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: widget.fromProfile,
                    child: Container(
                        constraints: BoxConstraints(
                            minWidth: double.infinity, maxHeight: 90),
                        color: AppColors.appBarColor,
                        padding: EdgeInsets.only(top: 20),
                        child: topView(wishlistController))),
if(wishlistController.loading)
                Expanded(child:CircularProgressBar(),
                ),
                Visibility(
                  visible: !wishlistController.loading &&
                      wishlistController.wishListData.length == 0,
                  child: Expanded(
                    child: Center(
                        child: Text(
                          'No Records',
                          style: TextStyle(
                              color: Color(0xFF414141),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                Visibility(
                  visible: !wishlistController.loading &&
                      wishlistController.wishListData.length > 0,
                  child:
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 15, bottom: 10, right: 10, left: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            padding: EdgeInsets.all(1.5),
                            child: GridView.count(
                                padding: EdgeInsets.zero,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 0.66,
                                physics: ScrollPhysics(),
                                children: List.generate(
                                    wishlistController.wishListData.length,
                                    (index) {
                                      print('..........fdhj.........${wishlistController.wishListData.length}');
                                  return InkWell(
                                      onTap: () {
                                        wishlistController
                                            .navigateTo(ProductDetailScreen(productId: wishlistController.wishListData[0].id,));
                                      },
                                      child: WishlistContainer(
                                        wishlistData: wishlistController
                                            .wishListData[index],
                                      ));
                                }))))))
              ],
            ),
          )));
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
