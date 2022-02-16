import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmween/generated/locale_keys.g.dart';
import 'package:tmween/provider/my_account_provider.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../provider/edit_profile_provider.dart';
import '../../../utils/views/custom_text_form_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateProfileScreenState();
  }
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late int userId;
  late int loginLogId;
  late String language;

  @override
  void initState() {
    /*MySharedPreferences.instance
        .getIntValuesSF(SharedPreferencesKeys.userId)
        .then((value) async {
      userId = value!;
      MySharedPreferences.instance
          .getIntValuesSF(SharedPreferencesKeys.loginLogId)
          .then((value) async {
        loginLogId = value! ;
      });
    });*/
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    language = context.locale.toString().split('_')[0];
    return Consumer<EditProfileProvider>(
        builder: (context, myAccountProvider, _) {
      myAccountProvider.context = context;
      myAccountProvider.getProfileDetails();
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
                      child: topView(myAccountProvider)),
                  _middleView(myAccountProvider),
                ],
              )));
    });
  }

  Widget _middleView(EditProfileProvider myAccountProvider) {
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
          child: _bottomView(myAccountProvider),
        ),
      ],
    )));
  }

  Widget _bottomView(EditProfileProvider myAccountProvider) {
    return Form(
        key: myAccountProvider.formKey,
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.name.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: myAccountProvider.nameController,
            keyboardType: TextInputType.name,
            hintText: LocaleKeys.name,
            textInputAction: TextInputAction.done,
            validator: (value) {}),
        10.heightBox,
        Text(
          LocaleKeys.lastName.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            controller: myAccountProvider.lastNameController,
            keyboardType: TextInputType.name,
            hintText: LocaleKeys.lastName,
            textInputAction: TextInputAction.done,
            validator: (value) {}),
        15.heightBox,
        CustomButton(text: LocaleKeys.update, fontSize: 14, onPressed: () {}),
        20.heightBox,
        Text(
          LocaleKeys.mobileNumber.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            readOnly: myAccountProvider.enablePhone,
            controller: myAccountProvider.mobileNumberController,
            keyboardType: TextInputType.phone,
            hintText: LocaleKeys.mobileNumber,
            textInputAction: TextInputAction.done,
            suffixIcon: InkWell(
                onTap: () {
                  myAccountProvider.enableMobileNumber();
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      LocaleKeys.update.tr(),
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ))),
            validator: (value) {}),
        10.heightBox,
        Text(
          LocaleKeys.email.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        10.heightBox,
        CustomBoxTextFormField(
            readOnly: myAccountProvider.enableEmail,
            controller: myAccountProvider.emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: LocaleKeys.email,
            textInputAction: TextInputAction.done,
            suffixIcon: InkWell(
                onTap: () {
                  myAccountProvider.enableEmailAddress();
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      LocaleKeys.update.tr(),
                      style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ))),
            validator: (value) {}),
        30.heightBox,
        Divider(
          thickness: 1,
          color: Colors.grey[300]!,
        ),
        5.heightBox,
        Text(
          LocaleKeys.changePassword.tr(),
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        5.heightBox,
        Divider(
          thickness: 1,
          color: Colors.grey[300]!,
        ),
        5.heightBox,
        Text(
          LocaleKeys.deactivateAccount.tr(),
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        50.heightBox,
      ],
    ));
  }

  Widget topView(EditProfileProvider myAccountProvider) {
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
                        myAccountProvider.exitScreen();
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
                LocaleKeys.updateProfile.tr(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
