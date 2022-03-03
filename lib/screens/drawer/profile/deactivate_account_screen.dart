import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/deactivate_account_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../utils/views/custom_text_form_field.dart';

class DeactivateAccountScreen extends StatelessWidget {
  late String language;
  final deactivateAccountController = Get.put(DeactivateAccountController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<DeactivateAccountController>(
        init: DeactivateAccountController(),
        builder: (contet) {
          deactivateAccountController.context = context;
          return Scaffold(
              body: Container(
                  color: AppColors.lighterGrayColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(deactivateAccountController)),
                      _bottomView(deactivateAccountController),
                    ],
                  )));
        });
  }

  Widget _bottomView(DeactivateAccountController deactivateAccountController) {
    return Expanded(
        child: Container(
            color: AppColors.darkGrayBackground,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.email.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'salim.akka@tmween.com',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
                15.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.mobileNumber.tr,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '+249 9822114455',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
                20.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CustomTextFormField(
                        controller:
                            deactivateAccountController.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        prefixIcon: SvgPicture.asset(ImageConstanst.lockIcon,color: AppColors.primaryColor,),

                        hintText: LocaleKeys.password,
                        validator: (value) {
                          return null;
                        })),
                20.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.confirmDeactivate.tr,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.darkblue,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                15.heightBox,
                Divider(
                  height: 5,
                  thickness: 10,
                  color: AppColors.lighterGrayColor,
                ),
                15.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivate.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
                10.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivateText1.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivateText2.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivateText3.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivateText4.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.whenDeactivateText5.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                15.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.howReactivate.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    )),
                10.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.howReactivateText1.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.howReactivateText2.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                5.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.howReactivateText3.tr,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )),
                15.heightBox,
                Container(
                  height: 50,
                  color: AppColors.lighterGrayColor,
                )
              ],
            ))));
  }

  Widget topView(DeactivateAccountController deactivateAccountController) {
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
                        deactivateAccountController.exitScreen();
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
                LocaleKeys.deactivateAccount.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
