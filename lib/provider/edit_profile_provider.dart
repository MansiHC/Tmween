import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmween/screens/drawer/profile/update_profile_screen.dart';

import '../screens/authentication/login/login_screen.dart';

class EditProfileProvider extends ChangeNotifier{
  late BuildContext context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool enablePhone=true;
  bool enableEmail=true;
  final formKey = GlobalKey<FormState>();


  void getProfileDetails(){
    nameController.text = 'Salim';
    lastNameController.text ='Akka';
    mobileNumberController.text = '+249 9822114455';
    emailController.text = 'salim.akka@tmween.com';
  }

  void enableMobileNumber(){
    enablePhone = false;
    notifyListeners();
}
void enableEmailAddress(){
    enableEmail = false;
    notifyListeners();
}

  void exitScreen() {
    Navigator.of(context).pop();
  }
  void pop() {
    Navigator.of(context).pop(false);
    notifyListeners();
  }


}