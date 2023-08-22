import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/config/global.dart';
import 'package:insta/controller/authentication.dart';
import 'package:insta/screens/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InstaSignUpScreen extends StatefulWidget {
  const InstaSignUpScreen({super.key});

  @override
  State<InstaSignUpScreen> createState() => _InstaSignUpScreenState();
}

class _InstaSignUpScreenState extends State<InstaSignUpScreen> {
  bool isSelected = false;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
        init: AuthenticationController(),
        builder: (con) => Scaffold(
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
                        top: 23.h,
                        left: 8.w,
                        right: 8.w,
                        child: Container(
                          height: 80.h,
                          width: 100.w,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Text(
                                "Register",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              textFieldWithIconAndHintText(
                                  "Enter username", "user_icon.png",
                                  textEditingController: con.username),
                              SizedBox(
                                height: 2.h,
                              ),
                              textFieldWithIconAndHintText(
                                  "Enter email", "email_icon.png",
                                  textEditingController: con.email),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 5.2.h,
                                //width: 100.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5)),
                                child: TextField(
                                  controller: con.date,
                                  decoration: InputDecoration(
                                    hintText: "Select Date of Birth",
                                    hintStyle: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        "assets/icons/calendar.png",
                                        width: 5.w,
                                        color: Colors.black,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      helpText: "Select Date of Birth",
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme:
                                                const ColorScheme.light(
                                              primary: Color(0xFF471D59),
                                              onPrimary:
                                                  Colors.white, // <-- SEE HERE
                                              onSurface: Color(
                                                  0xFFA974BF), // <-- SEE HERE
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: const Color(
                                                    0xFF471D59), // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (pickedDate != null) {
                                      String formattedDate =
                                          "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";

                                      setState(() {
                                        con.date.text =
                                            formattedDate; 
                                        selectedDate = pickedDate;
                                      });
                                    } else {}
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              textFieldWithIconAndHintText(
                                  "Enter password here", "lock_icon.png",
                                  textEditingController: con.password,
                                  isObscure: true),
                              SizedBox(
                                height: 2.h,
                              ),
                              textFieldWithIconAndHintText(
                                  "Confirm Password", "lock_icon.png",
                                  textEditingController: con.confirmPassword,
                                  isObscure: true),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 1.5.w,
                                  ),
                                  InkWell(
                                      onTap: () => {
                                            setState(
                                              () => {isSelected = !isSelected},
                                            )
                                          },
                                      child: CircleAvatar(
                                        radius: 1.h,
                                        backgroundColor: Colors.grey[500],
                                        child: isSelected
                                            ? CircleAvatar(
                                                radius: 0.7.h,
                                                backgroundColor:
                                                    Color(0xFF471D59),
                                              )
                                            : const SizedBox(),
                                      )),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          text: 'I agree to abide by the ',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                          children: [
                                        TextSpan(
                                            text: 'Terms of Services',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline))
                                      ])),
                                ],
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              primaryButton("Sign Up", () {
                                if (isSelected == false) {
                                  Get.snackbar(
                                    "Alert",
                                    "Please Agree to Terms and Conditions",
                                  );
                                } else {
                                  con.registerUser(selectedDate);
                                }
                              }, color: const Color(0xFF471d59)),
                            ],
                          ),
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
