import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/config/global.dart';
import 'package:insta/controller/post.dart';
import 'package:insta/screens/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});
  TextEditingController desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (con) => Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      con.image != null
                          ? Container(
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.grey)),
                              child: Image.file(con.image ?? File(''),fit: BoxFit.fill,))
                          : Container(
                              height: 30.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                  onTap: () {
                                    con.pickImage();
                                    con.update();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 5.h,
                                  ))),
                      SizedBox(
                        height: 2.h,
                      ),
                      textFieldWithHintText("Write a Caption",maxline: 2, textEditingController: desController),
                
                      SizedBox(height: 5.h,),
                
                      InkWell(
                        onTap: () {
                          post.description = desController.text;
                          con.setPost();
                         
                         
                        },
                        child: Center(
                          child: Container(
                            height: 8.h,
                            width: 85.w,
                            decoration: BoxDecoration(color: const Color(0xFF451859),borderRadius: BorderRadius.circular(20)),
                            child: Center(child: Text("Post",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18.sp))),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
