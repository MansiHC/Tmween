import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmween/controller/edit_profile_contoller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/change_password_screen.dart';
import 'package:tmween/screens/drawer/profile/deactivate_account_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../utils/helper.dart';
import '../../../utils/views/custom_text_form_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  late String language;

  final editAccountController = Get.put(EditProfileController());


  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (contet) {
          editAccountController.context = context;
          editAccountController.getProfileDetails();
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
                          child: topView(editAccountController)),
                      _middleView(editAccountController),
                    ],
                  )));
        });
  }

  Widget _middleView(EditProfileController editAccountController) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 110,
            color: AppColors.appBarColor,
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 80,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ))),
        15.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: _bottomView(editAccountController),
        ),
      ],
    )));
  }

  Widget _bottomView(EditProfileController editAccountController) {
    return Form(
        key: editAccountController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.name.tr,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomBoxTextFormField(
                controller: editAccountController.nameController,
                keyboardType: TextInputType.name,
                hintText: LocaleKeys.name,
                textInputAction: TextInputAction.done,
                validator: (value) {}),
            10.heightBox,
            Text(
              LocaleKeys.lastName.tr,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomBoxTextFormField(
                controller: editAccountController.lastNameController,
                keyboardType: TextInputType.name,
                hintText: LocaleKeys.lastName,
                textInputAction: TextInputAction.done,
                validator: (value) {}),
            15.heightBox,
            CustomButton(
              backgroundColor: Color(0xFF0188C8),
                text: LocaleKeys.update, fontSize: 14, onPressed: () {}),
            20.heightBox,
            Text(
              LocaleKeys.mobileNumber.tr,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomBoxTextFormField(
                controller: editAccountController.mobileNumberController,
                keyboardType: TextInputType.phone,
                hintText: LocaleKeys.mobileNumber,
                textInputAction: TextInputAction.done,
                suffixIcon: InkWell(
                    onTap: () {
                      _showOtpVerificationDialog(editAccountController,'+249 9822114455',language=='ar'?210:200);
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          LocaleKeys.update.tr,
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ))),
                validator: (value) {}),
            10.heightBox,
            Text(
              LocaleKeys.email.tr,
              style: TextStyle(
                  color:  Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomBoxTextFormField(
                controller: editAccountController.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: LocaleKeys.email,
                textInputAction: TextInputAction.done,
                suffixIcon: InkWell(
                    onTap: () {
                      _showOtpVerificationDialog(editAccountController,'sali.akka@tmween.com',language=='ar'?220:205);
                    },
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          LocaleKeys.update.tr,
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ))),
                validator: (value) {}),
            30.heightBox,
            Divider(
              thickness: 1,
              color: AppColors.lightGrayColor,
            ),
            5.heightBox,
            InkWell(onTap:(){
              Helper.showToast(LocaleKeys.otpSentSuccessfully.tr);
              editAccountController.navigateTo(ChangePasswordScreen());
            },child:Text(
              LocaleKeys.changePassword.tr,
              style: TextStyle(color: Color(0xFF888888), fontSize: 16,fontWeight: FontWeight.bold),
            )),
            5.heightBox,
            Divider(
              thickness: 1,
              color: AppColors.lightGrayColor,
            ),
            5.heightBox,
            InkWell(onTap:(){
              editAccountController.navigateTo(DeactivateAccountScreen());
            },child:Text(
              LocaleKeys.deactivateAccount.tr,
              style: TextStyle(color: Color(0xFF888888), fontSize: 16,fontWeight: FontWeight.bold),
            )),
            50.heightBox,
          ],
        ));
  }

  Widget topView(EditProfileController editAccountController) {
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
                        editAccountController.exitScreen();
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
                LocaleKeys.updateProfile.tr,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }

  void _showOtpVerificationDialog(EditProfileController editProfileController,String text,double height) async {
    await showDialog(
        context: editProfileController.context,
        builder: (_) => AlertDialog(

          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          buttonPadding: EdgeInsets.zero,
          actions: [],
          content: Container(
            height: height,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.heightBox,
                Text(
                  LocaleKeys.otpVerification.tr,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C7C7C)
                  ),
                ),
            15.heightBox,
            Text(
              '${LocaleKeys.enterOtpSentTo.tr} $text',
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9B9B9B),
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomTextFormField(
                controller: editProfileController.otpController,
                keyboardType: TextInputType.number,
                hintText: LocaleKeys.otp,
                textInputAction: TextInputAction.done,
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          LocaleKeys.resend.tr,
                          style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ))),
                validator: (value) {}),
            18.heightBox,
            Row(
              children: [
                Expanded(child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),onPressed: () {
                  editProfileController.pop();
                },
                  child: Text(
                    LocaleKeys.cancel.tr,
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ) ,
                )),
                Expanded(child:TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),onPressed: () {  },
                  child: Text(
                    LocaleKeys.save.tr,
                    style: TextStyle(
                        color: AppColors.darkblue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ))
              ],
            ),
          ],),)

        ));
  }
}
