import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/address_controller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/model/address_type_model.dart';
import 'package:tmween/model/country_model.dart';
import 'package:tmween/model/state_model.dart';
import 'package:tmween/screens/drawer/profile/fund_wallet_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../controller/add_address_controller.dart';
import '../../../controller/my_wallet_controller.dart';
import '../../../utils/views/custom_text_form_field.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


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
                  color: Colors.white,
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
              color: Colors.white,

                padding: EdgeInsets.all(
                  15,
                ),
                child:Column(children: [
                  Container(
                    color: Color(0xFFF2F2F2),
                    padding: EdgeInsets.all(
                      10,
                    ),

                    child: Row(children: [
                      SvgPicture.asset(ImageConstanst.yourWalletIcon,color:Color(0xFF555555),height: 32,width: 32,),
                      10.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Wallet Summary',style: TextStyle(color: Color(0xFF555555),fontSize: 15,fontWeight: FontWeight.bold),),
                     3.heightBox,
                        RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'Current Balance ',
                                style: TextStyle(
                                  color: Color(0xFF1992CE),
                                  fontSize: 15,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Rs 0',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]))
                      ],)
                    ],),
                  ),
                  10.heightBox,
                  CustomButton(text: 'FUND WALLET', onPressed: (){
                    myWalletController.navigateTo(FundWalletScreen());
                  },
                  fontSize: 15,),
            10.heightBox,
            Container(
                color: Color(0xFFF2F2F2),
                padding: EdgeInsets.all(
                  10,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Wallet activity for',style: TextStyle(color: Color(0xFF555555),fontSize: 15,
                      ),),
                  5.heightBox,
                  Padding(padding: EdgeInsets.only(left: 10),child:MediaQuery.removePadding(
                      context: myWalletController.context,
                      removeTop: true,
                      child:ListView.builder(
                    shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: myWalletController.walletActivitys.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,children: [
                          5.heightBox,
                          Text(myWalletController.walletActivitys[index],style:
                          TextStyle(color: Color(0xFFF18369),fontSize: 15,),),
5.heightBox,
                          if(index !=(myWalletController.walletActivitys.length-1))
                          Divider(height: 1,thickness: 1,color: Color(0xFFE6E6E6),)
                        ],);
                      })))

                ]))
                ],) )));
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
