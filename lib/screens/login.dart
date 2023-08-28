import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/config/global.dart';
import 'package:insta/controller/authentication.dart';
import 'package:insta/screens/signUp.dart';
import 'package:insta/screens/splash.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'widgets.dart';

class InstaLoginScreen extends StatelessWidget {
  const InstaLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        // specify type as Controller
        init: AuthenticationController(),
        builder: (AuthenticationController con) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Container(
                  height: 100.h,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10.h,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Text(
                            "𝓘𝓷𝓼𝓽𝓪𝓰𝓻𝓪𝓶",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600),
                          ))),
                      Positioned(
                          top: 15.h,
                          left: 0,
                          right: 0,
                          child:
                              Image.asset("assets/walk_through/Exclude.png")),
                      Positioned(
                        top: 30.h,
                        left: 8.w,
                        right: 8.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            textFieldWithIconAndHintText(
                                "Enter email here", "email_icon.png",
                                textEditingController: con.email),
                            SizedBox(
                              height: 2.h,
                            ),
                            textFieldWithIconAndHintText(
                                "Enter password here", "lock_icon.png",
                                textEditingController: con.password,
                                isObscure: true),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot password?",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            primaryButton("Login", () async {
                              con.loginUser();
                              con.email.text = "";
                              con.password.text = "";
                            }, color: const Color(0xFF471d59)),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don' '\'t have an account? ',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    )),
                                InkWell(
                                  child: Text('Signup',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          decoration:
                                              TextDecoration.underline)),
                                  onTap: () {
                                    Get.to(() => const InstaSignUpScreen());
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    con.signInWithGoogle();
                                  },
                                  child: Image.asset(
                                    "assets/logo/google_logo.png",
                                    height: 4.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    con.signInWithFacebook();
                                  },
                                  child: Image.asset(
                                    "assets/logo/fb_logo.png",
                                    height: 4.h,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          "assets/walk_through/yellow_back_design.png",
                          height: 11.h,
                          color: const Color(0xFFA974BF),
                        ),
                      ),
                      Positioned(
                          bottom: -1.h,
                          child: Image.asset(
                            "assets/walk_through/blue_back_design.png",
                            height: 16.h,
                            color: const Color(0xFF52136e),
                          ))
                    ],
                  )),
            ));
  }
}
