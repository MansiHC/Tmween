import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/deactivate_account_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';

import '../../../utils/views/custom_button.dart';
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
                        prefixIcon: SvgPicture.asset(
                          ImageConstanst.lockIcon,
                          color: AppColors.primaryColor,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (term) {
                          deactivateAccountController.deActivate();
                        },
                        hintText: LocaleKeys.password,
                        validator: (value) {
                          return null;
                        })),
                20.heightBox,
                /* Padding(
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
                    )),*/
                Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                        width: 230,
                        horizontalPadding: 10,
                        backgroundColor: Color(0xFF0188C8),
                        text: LocaleKeys.confirmDeactivate,
                        fontSize: 16,
                        onPressed: () {
                          deactivateAccountController.deActivate();
                        })),
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
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    )),
                10.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.whenDeactivateText1.tr,
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.whenDeactivateText2.tr,
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.whenDeactivateText3.tr,
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.whenDeactivateText4.tr,
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.whenDeactivateText5.tr,
                ),
                15.heightBox,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      LocaleKeys.howReactivate.tr,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    )),
                10.heightBox,
                _descView(
                  deactivateAccountController,
                  LocaleKeys.howReactivateText1.tr,
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  'Simply contact us to re-activate your account. Your account data will be fully restored - default settings will be applied and you will be subscribed to receive promotional emails from Tmween.',
                ),
                5.heightBox,
                _descView(
                  deactivateAccountController,
                  'Tmween retains your account data for you to conveniently start off from where you left, if you decide to reactivate your account.',
                ),
                15.heightBox,
                Container(
                  height: 50,
                  color: AppColors.lighterGrayColor,
                )
              ],
            ))));
  }

  Widget _descView(
      DeactivateAccountController deactivateAccountController, String text) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black54),
          ),
          10.widthBox,
          Expanded(
              child: Text(
            text,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ))
        ]));
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
