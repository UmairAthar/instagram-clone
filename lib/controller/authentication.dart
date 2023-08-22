import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';
import 'package:insta/screens/home.dart';
import 'package:insta/screens/splash.dart';
import 'package:insta/service/authService.dart';
import 'package:insta/service/firestoreService.dart';

class AuthenticationController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController date = TextEditingController();

  bool isAgree = false;

  updateUser() async {
    await Get.find<FirestoreServices>().updateUser(currentUser);
  }

  loginUser() async {
    if (email.text.isEmpty) {
      EasyLoading.showInfo("Enter Email");
      return;
    }
    if (!email.text.isEmail) {
      EasyLoading.showInfo("Enter Valid Email");
      return;
    }
    if (password.text.isEmpty) {
      EasyLoading.showInfo("Enter Password");
      return;
    }
    EasyLoading.show();
    String result =
        await Get.find<AuthServices>().emailSignIn(email.text, password.text);
    if (result == "") {
      currentUser =
          await Get.put(FirestoreServices()).getUser(currentUser.id) ??
              UserModel();
      print(currentUser.username);
      email.text = "";
      password.text = "";
      EasyLoading.dismiss();
      Get.offAll(HomePage());
    } else {
      EasyLoading.showError(result);
    }
  }

  Future<bool> registerUser(DateTime dob) async {
    if (email.text.isEmpty) {
      EasyLoading.showInfo("Enter Email");
      return false;
    }
    if (!email.text.isEmail) {
      EasyLoading.showInfo("Enter Valid Email");
      return false;
    }
    if (password.text.isEmpty) {
      EasyLoading.showInfo("Enter Valid Password");
      return false;
    }
    if (password.text != confirmPassword.text) {
      EasyLoading.showInfo("Password Doesn't Match");
      return false;
    }
    EasyLoading.show();
    String str =
        await Get.find<AuthServices>().emailSignUp(email.text, password.text);
    EasyLoading.dismiss();
    if (str == "") {
      currentUser.email = email.text;
      currentUser.username = username.text;
      currentUser.dob = dob;
      email.text = "";
      username.text = "";
      date.text = "";
      password.text = "";
      confirmPassword.text = "";
      await Get.find<FirestoreServices>().registerUser();
      Get.offAll(HomePage());
      return true;
    } else {
      EasyLoading.showError(str);
    }
    return false;
  }
}
