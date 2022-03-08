import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/fund_wallet_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/my_wallet_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

class MyWalletScreen extends StatelessWidget {
  late String language;

  final myWalletController = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<MyWalletController>(
        init: MyWalletController(),
        builder: (contet) {
          myWalletController.context = context;
          return Scaffold(
              body: Container(
                  color:  Color(0xFFF2F2F2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              minWidth: double.infinity, maxHeight: 90),
                          color: AppColors.appBarColor,
                          padding: EdgeInsets.only(top: 20),
                          child: topView(myWalletController)),
                      _bottomView(myWalletController),
                    ],
                  )));
        });
  }

  Widget _bottomView(MyWalletController myWalletController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Container(

                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstanst.yourWalletIcon,
                            color: Color(0xFF555555),
                            height: 32,
                            width: 32,
                          ),
                          10.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Current Balance  ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,

                                    ),
                              ),
                              3.heightBox,

                                        Text(
                                           '${LocaleKeys.sar.tr} 0',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),

                            ],
                          )
                        ],
                      ),
                    ),
                    15.heightBox,
                    Text(
                      'Add money',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 15,
                      ),
                    ),
                    10.heightBox,
                    Container(color: Colors.white,
                      padding:EdgeInsets.all(10),child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      CustomTextFormField(
                        isPrefix: false,
                          controller: myWalletController.amountController,
                          keyboardType: TextInputType.number,
                          hintText: 'Amount',
                          prefixIcon: Text(LocaleKeys.sar.tr,style: TextStyle(fontSize: 14),),
                          validator: (value) {}),
                        15.heightBox,
                        Wrap(
                          spacing: 10,
                          children: List.generate(
                          myWalletController.amounts.length,
                              (index) =>  InkWell(
                                  onTap: (){

                                    myWalletController.amountController.text = myWalletController
                                        .amounts[index];
                                    myWalletController.update();
                                  },
                                  child:Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlueBackground,
                                  border: Border.all(color: AppColors.blue),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                                ),
                                child: Text('+${LocaleKeys.sar.tr} ${myWalletController.amounts[index]}',
                                  style: TextStyle(color: AppColors.blue,fontSize: 12),),
                              )),)),
                        20.heightBox,
                        CustomButton(
                          text: 'FUND WALLET',
                          onPressed: () {
                            myWalletController.navigateTo(FundWalletScreen());
                          },
                          fontSize: 15,
                        ),
                    ],),),

                    15.heightBox,
                    Text(
                      'Wallet activity for',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 15,
                      ),
                    ),
                    10.heightBox,
                    Container(
                        color: Colors.white,
                       child: MediaQuery.removePadding(
                                      context: myWalletController.context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: myWalletController
                                              .walletActivitys.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                10.heightBox,
                                                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                                               Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                  Text(
                                                  myWalletController
                                                      .walletActivitys[index],
                                                  style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                    Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey[400],)],)),
                                                10.heightBox,
                                                if (index !=
                                                    (myWalletController
                                                            .walletActivitys
                                                            .length -
                                                        1))
                                                  Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    color: Color(0xFFE6E6E6),
                                                  )
                                              ],
                                            );
                                          })))

                  ],
                ))));
  }

  Widget topView(MyWalletController myWalletController) {
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
                        myWalletController.exitScreen();
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
                'My Wallet',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
