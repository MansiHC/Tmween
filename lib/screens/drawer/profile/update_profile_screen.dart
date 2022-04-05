import 'dart:io';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:tmween/model/get_customer_data_model.dart';
import 'package:tmween/screens/drawer/profile/change_password_screen.dart';
import 'package:tmween/screens/drawer/profile/deactivate_account_screen.dart';
import 'package:tmween/utils/extensions.dart';
import 'package:tmween/utils/global.dart';
import 'package:tmween/utils/views/custom_button.dart';
import 'package:tmween/utils/views/otp_text_field.dart';

import '../../../utils/views/circular_progress_bar.dart';
import '../../../utils/views/custom_text_form_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  final ProfileData? profileData;

  UpdateProfileScreen({Key? key, this.profileData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UpdateProfileScreenState();
  }
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late String language;
  final editAccountController = Get.put(EditProfileController());

  Future<void> readSMS(EditProfileController otpController,bool fromMobile) async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    if(comingSms.contains('Tmween')) {
      otpController.comingSms = comingSms;
      print("====>Message: ${otpController.comingSms}");
      final intInStr = RegExp(r'\d+');
      if(fromMobile)
      otpController.mobileOTPController.text =
          intInStr.allMatches(otpController.comingSms).map((m) => m.group(0)).toString().replaceAll('(', '').replaceAll(')','');
      else
        otpController.emailOTPController.text =
          intInStr.allMatches(otpController.comingSms).map((m) => m.group(0)).toString().replaceAll('(', '').replaceAll(')','');
      otpController.update();
    }
  }

  @override
  void initState() {
    editAccountController.nameController.text =
        widget.profileData!.yourName!.split(' ')[0];
    editAccountController.lastNameController.text =
        widget.profileData!.yourName!.split(' ')[1];
    editAccountController.mobileNumberController.text =
        widget.profileData!.phone!;
    if (widget.profileData!.email != null) {
      editAccountController.emailController.text = widget.profileData!.email!;
    }
    super.initState();
  }

  Future<bool> _onWillPop(EditProfileController editAccountController) async {
    editAccountController.exitScreen();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    language = Get.locale!.languageCode;

    return WillPopScope(
        onWillPop: () => _onWillPop(editAccountController),
        child: GetBuilder<EditProfileController>(
            init: EditProfileController(),
            builder: (contet) {
              editAccountController.context = context;
              // editAccountController.getProfileDetails();
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
                              Visibility(
                                visible: editAccountController.loading,
                                child: Expanded(child: CircularProgressBar()),
                              ),
                              if (!editAccountController.loading)
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
                                          minWidth: double.infinity,
                                          maxHeight: 90),
                                      color: AppColors.appBarColor,
                                      padding: EdgeInsets.only(top: 20),
                                      child: topView(editAccountController)),
                                  Visibility(
                                    visible: editAccountController.loading,
                                    child:
                                        Expanded(child: CircularProgressBar()),
                                  ),
                                  if (!editAccountController.loading)
                                    _middleView(editAccountController),
                                ],
                              )));
            }));
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
                        ? widget.profileData!.largeImageUrl!.isNotEmpty
                            ? CircleAvatar(
                                radius: 40,
                                /*backgroundImage: NetworkImage(
                                    widget.profileData!.image!)*/
                                foregroundColor: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: widget.profileData!.largeImageUrl!,
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  imageBuilder: (context, image) =>
                                      CircleAvatar(
                                    backgroundImage: image,
                                    radius: 40,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    child: SvgPicture.asset(
                                      ImageConstanst.user,
                                      height: 80,
                                      width: 80,
                                    ),
                                    radius: 40,
                                  ),
                                ))
                            : SvgPicture.asset(
                                ImageConstanst.user,
                                height: 80,
                                width: 80,
                              )
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
                onSubmitted: (term) {
                  FocusScope.of(editAccountController.context).unfocus();
                },
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
                onPressed: () {
                  editAccountController.updateNameImage(
                      widget.profileData!.image, language);
                }),
            Visibility(
              visible: editAccountController.loadingImageName,
              child: CircularProgressBar(),
            ),
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
                      editAccountController.generateOTP(
                          editAccountController.mobileNumberController.text,
                          language,
                          true);
                      readSMS(editAccountController,true);
                      editAccountController.filled = false;
                      _showOtpVerificationDialog(
                          editAccountController,
                          editAccountController.mobileNumberController.text,
                          language == 'ar' ? 340 : 350,
                          false);
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(12),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emptyPhoneNumber.tr;
                  } else if (editAccountController
                          .mobileNumberController.value.text.length <
                      10) {
                    return LocaleKeys.validPhoneNumber.tr;
                  }
                  return null;
                }),
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
                      editAccountController.generateOTP(
                          editAccountController.emailController.text,
                          language,
                          false);
                      readSMS(editAccountController,false);
                      editAccountController.filled = false;
                      _showOtpVerificationDialog(
                          editAccountController,
                          editAccountController.emailController.text,
                          language == 'ar' ? 340 : 350,
                          true);
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
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.emptyYourEmail.tr;
                  } else if (!editAccountController.emailController.value.text
                      .validateEmail()) {
                    return LocaleKeys.validYourEmail.tr;
                  }
                  return null;
                }),
            30.heightBox,
            Divider(
              thickness: 1,
              color: AppColors.lightGrayColor,
            ),
            5.heightBox,
            CustomButton(
                backgroundColor: Color(0xFF0188C8),
                text: LocaleKeys.changePassword,
                fontSize: 15,
                onPressed: () {
                  //Helper.showToast(LocaleKeys.otpSentSuccessfully.tr);
                  editAccountController.navigateTo(ChangePasswordScreen(
                      email: editAccountController.emailController.text,
                      mobile:
                          editAccountController.mobileNumberController.text));
                }),
            /*InkWell(
                onTap: () {

                },
                child: Text(
                  LocaleKeys.changePassword.tr,
                  style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),*/
            /* 5.heightBox,
            Divider(
              thickness: 1,
              color: AppColors.lightGrayColor,
            ),*/
            5.heightBox,
            Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Wrap(
                    children: [
                      SvgPicture.asset(
                        ImageConstanst.deactivateUserIcon,
                        height: 24,
                        width: 24,
                        color: Colors.white,
                      ),
                      10.widthBox,
                      Text(
                        LocaleKeys.deactivateAccount.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onPressed: () {
                    editAccountController.navigateTo(DeactivateAccountScreen(mobileNumber: editAccountController.mobileNumberController.text,email: editAccountController.emailController.text,));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                  ),
                )),
            /*InkWell(
                onTap: () {
                  editAccountController.navigateTo(DeactivateAccountScreen());
                },
                child: Text(
                  LocaleKeys.deactivateAccount.tr,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),*/
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
      String text, double height, bool isEmail) async {
    await showDialog(
        context: editProfileController.context,
        builder: (_) => AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            buttonPadding: EdgeInsets.zero,
            actions: [],
            content: GetBuilder<EditProfileController>(
                init: EditProfileController(),
                builder: (contet) {
                  return Container(
                    height: height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.heightBox,
                        if (!editProfileController.loadingDialog)
                          Text(
                            'Otp is : ${editProfileController.otpValue}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7C7C7C)),
                          ),
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
                        RichText(
                          text: TextSpan(
                              text: '${LocaleKeys.enterOtpSentTo.tr} ',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF7C7C7C),
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: text,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                        10.heightBox,
                        if (!editProfileController.loadingDialog &&
                            !editProfileController.otpExpired)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.otpExpire.tr,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              5.widthBox,
                              TweenAnimationBuilder<Duration>(
                                  duration:
                                      Duration(seconds: AppConstants.timer),
                                  tween: Tween(
                                      begin:
                                          Duration(seconds: AppConstants.timer),
                                      end: Duration.zero),
                                  onEnd: () {
                                    editProfileController.otpExpired = true;
                                    editProfileController.update();
                                  },
                                  builder: (BuildContext context,
                                      Duration value, Widget? child) {
                                    final minutes = value.inMinutes;
                                    final seconds = value.inSeconds % 60;
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text('$minutes:$seconds',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)));
                                  }),
                            ],
                          ),
                        if (editProfileController.otpExpired)
                          Text(
                            'Please Resend the Otp.',
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        10.heightBox,
                        OtpTextField(
                          length: 4,
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: AppColors.primaryColor,
                            activeColor: AppColors.primaryColor,
                            selectedColor: AppColors.primaryColor,
                            selectedFillColor: AppColors.primaryColor,
                            inactiveFillColor: AppColors.lightGrayColor,
                            inactiveColor: AppColors.lightGrayColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          cursorColor: Colors.white,
                          textStyle: TextStyle(color: Colors.white),
                          controller: isEmail
                              ? editProfileController.emailOTPController
                              : editProfileController.mobileOTPController,
                          onCompleted: (v) {
                            if(!editProfileController.filled) {
                              editProfileController.pop();
                              editProfileController.filled = true;
                              if (isEmail) {
                                editProfileController.updateEmail(
                                    text, language);
                              } else {
                                editProfileController.updateMobileNumber(
                                    text, language);
                              }
                            }
                          },
                          onChanged: (value) {
                            debugPrint(value);
                            editProfileController.currentText = value;
                            editProfileController.update();
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                          appContext: editProfileController.context,
                        ),
                        Visibility(
                          visible: editProfileController.loadingDialog,
                          child: CircularProgressBar(),
                        ),
                        10.heightBox,
                        Text(
                          LocaleKeys.notReceivedOtp.tr,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        5.heightBox,
                        if (editProfileController.otpExpired)
                          InkWell(
                              onTap: () {
                                editAccountController.resendOTP(text, !isEmail);
                              },
                              child: Text(
                                LocaleKeys.resendCode.tr,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.primaryColor),
                              )),
                        18.heightBox,
                        Row(
                          children: [
                            Expanded(
                                child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
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
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              onPressed: () {
                                editProfileController.pop();
                                if (isEmail) {
                                  editProfileController.updateEmail(text, language);
                                } else {
                                  editProfileController.updateMobileNumber(
                                      text, language);
                                }
                              },
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
                  );
                })));
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
