import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/add_address_controller.dart';
import '../../../controller/fund_wallet_controller.dart';
import '../../../controller/my_wallet_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


class FundWalletScreen extends StatelessWidget {
  late String language;

  final fundWalletController = Get.put(FundWalletController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<FundWalletController>(
        init: FundWalletController(),
        builder: (contet) {
          fundWalletController.context = context;
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
                          child: topView(fundWalletController)),
                      _bottomView(fundWalletController),
                    ],
                  )));
        });
  }

  Widget _bottomView(FundWalletController fundWalletController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(
              color: Colors.white,

                padding: EdgeInsets.all(
                  15,
                ),
                child:Column(children: [
                  CustomTextFormField(
                      controller: fundWalletController.amountController,
                      keyboardType: TextInputType.number,
                      hintText: 'Amount',
                      validator: (value) {}),
                  10.heightBox,
                  InkWell(
                      onTap: () {
                        fundWalletController.isCreditChecked=!fundWalletController.isCreditChecked;
                        fundWalletController.update();
                      },
                      child: Container(
                        color: Color(0xFFFBFBFB),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Text(
                                  'Credit/Debit Card, Net Banking',
                                  style: TextStyle(
                                    color: Color(0xFF727272),
                                    fontSize: 14,
                                  ),
                                ),
                                10.widthBox,
                                SizedBox(
                                    height: 24.0,
                                    width: 24.0,
                                    child: Theme(
                                        data: Theme.of(fundWalletController.context).copyWith(
                                          unselectedWidgetColor: Color(0xFF59AC4E),
                                        ),
                                        child: Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4)),
                                            checkColor: Color(0xFF59AC4E),
                                            value: fundWalletController.isCreditChecked,
                                            activeColor: Colors.white,
                                            side: MaterialStateBorderSide.resolveWith(
                                                  (states) =>
                                                  BorderSide(width: 1.5, color: Color(0xFF59AC4E)),
                                            ),
                                            onChanged: (value) {
                                              fundWalletController.isCreditChecked = value!;
                                              fundWalletController.update();
                                            }))),

                              ])))
                ],) )));
  }

  Widget topView(FundWalletController fundWalletController) {
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
                        fundWalletController.exitScreen();
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
                'Fund Wallet',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
