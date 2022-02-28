import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/my_account_controller.dart';
import 'package:tmween/controller/your_order_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

class YourOrderScreen extends StatelessWidget {
  late String language;
  final yourOrderController = Get.put(YourOrderController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<YourOrderController>(
        init: YourOrderController(),
        builder: (contet) {
          yourOrderController.context = context;
          return Scaffold(
              body: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(yourOrderController)),
                      _bottomView(yourOrderController)
                    ],
                  )));
        });
  }

  Widget _bottomView(YourOrderController yourOrderController) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical:
                   language=='ar'? MediaQuery.of(yourOrderController.context).size.height /
                        3.8:MediaQuery.of(yourOrderController.context).size.height /
                       3.6),

            child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFD7D7D7))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    5.heightBox,
                    Text(
                      LocaleKeys.waitingToDeliver.tr,
                      style: TextStyle(fontSize: 16, color: Color(0xFF737373)),
                    ),
                    5.heightBox,
                    Text(
                      LocaleKeys.shopProductsFrom.tr,
                      style: TextStyle(fontSize: 14, color: Color(0xFFBEBEBE)),
                    ),
                    10.heightBox,
                    CustomButton(
                        text: LocaleKeys.startShopping, onPressed: () {
                          yourOrderController.navigateToDashboardScreen();
                    }),
                    5.heightBox
                  ],
                ))));
  }

  Widget topView(YourOrderController yourOrderController) {
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
                        yourOrderController.exitScreen();
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
                LocaleKeys.yourOrders.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
