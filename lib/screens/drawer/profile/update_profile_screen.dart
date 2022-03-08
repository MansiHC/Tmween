import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmween/controller/edit_profile_contoller.dart';
import 'package:tmween/lang/locale_keys.g.dart';
import 'package:tmween/screens/drawer/profile/change_password_screen.dart';
import 'package:tmween/screens/drawer/profile/deactivate_account_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';

import '../../../utils/helper.dart';
import '../../../utils/views/custom_text_form_field.dart';
import '../../../utils/views/otp_text_filed.dart';

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
          return editAccountController.sample == null
              ? Scaffold(
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
                      )))
              : editAccountController.lastCropped == null
                  ? _buildCroppingImage(editAccountController)
                  : Scaffold(
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

  Widget _buildCroppingImage(EditProfileController editAccountController) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(editAccountController.sample!,
              key: editAccountController.cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(LocaleKeys.crop.tr),
                onPressed: () => _cropImage(editAccountController),
              ),
              TextButton(
                child: Text(LocaleKeys.cancel.tr),
                onPressed: () {
                  editAccountController.sample = null;
                  editAccountController.lastCropped = null;
                  editAccountController.update();
                },
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> _cropImage(EditProfileController editAccountController) async {
    final scale = editAccountController.cropKey.currentState!.scale;
    final area = editAccountController.cropKey.currentState!.area;
    if (area == null) {
      return;
    }

    final sample = await ImageCrop.sampleImage(
      file: editAccountController.image!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    editAccountController.lastCropped?.delete();
    editAccountController.lastCropped = file;

    editAccountController.finalImage = editAccountController.lastCropped;
    var response = await ImageGallerySaver.saveImage(
        editAccountController.finalImage!.readAsBytesSync());

    editAccountController.imageString = response['filePath'];
    editAccountController.lastCropped = null;
    editAccountController.sample = null;
    editAccountController.update();
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
                child: Stack(
                  children: [
                    editAccountController.finalImage == null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage('http://i.imgur.com/QSev0hg.jpg'))
                        : CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                FileImage(editAccountController.finalImage!),
                          ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                            onTap: () {
                              FocusScope.of(editAccountController.context)
                                  .requestFocus(new FocusNode());
                              _requestPermission(editAccountController);
                            },
                            child: Container(
                              width: 30,
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.edit,
                                size: 13,
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            )))
                  ],
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
              ),
            )),
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
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.userIcon,
                  color: AppColors.primaryColor,
                ),
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
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.userIcon,
                  color: AppColors.primaryColor,
                ),
                validator: (value) {}),
            15.heightBox,
            CustomButton(
                backgroundColor: Color(0xFF0188C8),
                text: LocaleKeys.update,
                fontSize: 14,
                onPressed: () {}),
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
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.phoneCallIcon,
                  color: AppColors.primaryColor,
                ),
                suffixIcon: InkWell(
                    onTap: () {
                      _showOtpVerificationDialog(editAccountController,
                          '+249 9822114455', language == 'ar' ? 280 : 270);
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
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            10.heightBox,
            CustomBoxTextFormField(
                controller: editAccountController.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: LocaleKeys.email,
                prefixIcon: SvgPicture.asset(
                  ImageConstanst.emailIcon,
                  color: AppColors.primaryColor,
                ),
                textInputAction: TextInputAction.done,
                suffixIcon: InkWell(
                    onTap: () {
                      _showOtpVerificationDialog(editAccountController,
                          'sali.akka@tmween.com', language == 'ar' ? 290 : 270);
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
            InkWell(
                onTap: () {
                  Helper.showToast(LocaleKeys.otpSentSuccessfully.tr);
                  editAccountController.navigateTo(ChangePasswordScreen());
                },
                child: Text(
                  LocaleKeys.changePassword.tr,
                  style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            5.heightBox,
            Divider(
              thickness: 1,
              color: AppColors.lightGrayColor,
            ),
            5.heightBox,
            InkWell(
                onTap: () {
                  editAccountController.navigateTo(DeactivateAccountScreen());
                },
                child: Text(
                  LocaleKeys.deactivateAccount.tr,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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

  void _showOtpVerificationDialog(EditProfileController editProfileController,
      String text, double height) async {
    await showDialog(
        context: editProfileController.context,
        builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonPadding: EdgeInsets.zero,
            actions: [],
            content: Container(
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.heightBox,
                  Text(
                    LocaleKeys.otpVerification.tr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C7C7C)),
                  ),
                  15.heightBox,
                  RichText(text: TextSpan(text:'${LocaleKeys.enterOtpSentTo.tr} ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7C7C7C),
                        fontWeight: FontWeight.bold),children: [
                      TextSpan(text:text,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                      ]),),

                  10.heightBox,
               /*   CustomTextFormField(
                      controller: editProfileController.editProfileController,
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
                      validator: (value) {}),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpTextFormField(
                          controller: editProfileController.num1Controller,
                          onChanged: (value) {
                            if (value.length == 1) {
                              editProfileController.notifyClick1(true);
                              FocusScope.of(editProfileController.context).nextFocus();
                              editProfileController.notifyClick2(true);
                            }
                            if (value.length == 0) {
                              FocusScope.of(editProfileController.context).previousFocus();
                              editProfileController.notifyClick1(false);
                            }
                          },
                          clicked: editProfileController.click1,
                          onTap: () {
                            editProfileController.notifyClick1(true);
                          }),
                      OtpTextFormField(
                          controller: editProfileController.num2Controller,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(editProfileController.context).nextFocus();
                              editProfileController.notifyClick3(true);
                            }
                            if (value.length == 0) {
                              FocusScope.of(editProfileController.context).previousFocus();
                              editProfileController.notifyClick2(false);
                            }
                          },
                          clicked: editProfileController.click2,
                          onTap: () {
                            editProfileController.notifyClick2(true);
                          }),
                      OtpTextFormField(
                          controller: editProfileController.num3Controller,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(editProfileController.context).nextFocus();
                              editProfileController.notifyClick4(true);
                            }
                            if (value.length == 0) {
                              FocusScope.of(editProfileController.context).previousFocus();
                              editProfileController.notifyClick3(false);
                            }
                          },
                          clicked: editProfileController.click3,
                          onTap: () {
                            editProfileController.notifyClick3(true);
                          }),
                      OtpTextFormField(
                          controller: editProfileController.num4Controller,
                          clicked: editProfileController.click4,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(editProfileController.context).nextFocus();

                            }
                            if (value.length == 0) {
                              FocusScope.of(editProfileController.context).previousFocus();
                              editProfileController.notifyClick4(false);
                            }
                          },
                          onTap: () {
                            editProfileController.notifyClick4(true);
                          }),
                    ],
                  ),
                  10.heightBox,
                  Text(
                    LocaleKeys.notReceivedOtp.tr,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  5.heightBox,
                  InkWell(
                      onTap: () {
                      },
                      child: Text(
                        LocaleKeys.resendCode.tr,
                        style: TextStyle(fontSize: 13, color: AppColors.primaryColor),
                      )),
                  18.heightBox,
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          editProfileController.pop();
                        },
                        child: Text(
                          LocaleKeys.cancel.tr,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {},
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
                ],
              ),
            )));
  }

  void _shopImagePickerDialog(
      EditProfileController editProfileController) async {
    await showDialog(
        context: editProfileController.context,
        builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonPadding: EdgeInsets.zero,
            actions: [],
            content: Container(
              height: 205,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  15.heightBox,
                  Text(
                    LocaleKeys.chooseOption.tr,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7C7C7C)),
                  ),
                  15.heightBox,
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.camera),
                    title: Text(
                      LocaleKeys.camera.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Color(0xFF7C7C7C)),
                    ),
                    onTap: () {
                      editProfileController.pop();
                      _getImage(ImageSource.camera, editProfileController);
                    },
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(Icons.image),
                    title: Text(
                      LocaleKeys.gallery.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14, color: Color(0xFF7C7C7C)),
                    ),
                    onTap: () {
                      editProfileController.pop();
                      _getImage(ImageSource.gallery, editProfileController);
                    },
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          editProfileController.pop();
                        },
                        child: Text(
                          LocaleKeys.cancel.tr,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            )));
  }

  _requestPermission(EditProfileController editAccountController) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    PermissionStatus? info = statuses[Permission.storage];
    print('info....$info');
    switch (info) {
      case PermissionStatus.denied:
        break;
      case PermissionStatus.granted:
        _shopImagePickerDialog(editAccountController);
        break;
      default:
        return Colors.grey;
    }
  }

  void _getImage(ImageSource imageSource,
      EditProfileController editProfileController) async {
    try {
      PickedFile? imageFile =
          await editProfileController.picker.getImage(source: imageSource);
      if (imageFile == null) return;
      File tmpFile = File(imageFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(imageFile.path);
      tmpFile = await tmpFile.copy('${appDir.path}/$fileName');
      final sample = await ImageCrop.sampleImage(
        file: tmpFile,
        preferredSize: editProfileController.context.size!.longestSide.ceil(),
      );

      editProfileController.image = tmpFile;
      editProfileController.sample = sample;
      editProfileController.update();
    } catch (e) {
      debugPrint('image-picker-error ${e.toString()}');
    }
  }
}
