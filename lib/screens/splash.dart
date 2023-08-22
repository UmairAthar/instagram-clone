import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';
import 'package:insta/screens/home.dart';
import 'package:insta/screens/login.dart';
import 'package:insta/service/authService.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../service/firestoreService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String keyLogin = "login";

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "𝓘𝓷𝓼𝓽𝓪𝓰𝓻𝓪𝓶",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 4.h,
            ),
            const CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  void checkLoginState() async {
    await Get.find<AuthServices>().checkUser();
    Timer(const Duration(seconds: 2), () async {
      if (currentUser.id != "") {
    currentUser=(await Get.find<FirestoreServices>().getUser(currentUser.id))??UserModel();


        Get.off(HomePage());
      } else {
        Get.off(InstaLoginScreen());
      }
    });
  }
}
