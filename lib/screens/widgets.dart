import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/config/colors.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/postModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget textFieldWithIconAndHintText(String hintText, String iconName,
    {color,TextEditingController? textEditingController, isObscure = false}) {
  return Container(
    height: 5.2.h,
    //width: 100.w,
    decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey, width: 0.5)),
    child: TextField(
      controller: textEditingController??TextEditingController(),
      obscureText: isObscure? true: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
            fontSize: 15.sp, fontWeight: FontWeight.w400),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            "assets/icons/$iconName",
            width: 5.w,
            color: Colors.black,
          ),
        ),
        border: InputBorder.none,
      ),
    ),
  );
}



InkWell primaryButton(String text, Function? onTap, {Color? color}) {
  return InkWell(
    onTap: () {
      if (onTap != null) onTap();
    },
    child: Container(
      height: 6.h,
      width: 90.w,
      decoration: BoxDecoration(
          color: color ?? Color(0xff31D8E3),
          borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      )),
    ),
  );
}


Widget textFieldWithHintText(String hintText,
    {Color? color, int maxline = 1, TextEditingController? textEditingController}) {
  return Container(
    // height: 4.5.h,
    width: 100.w,
    decoration: const BoxDecoration(
      color: Color(0xFF454343),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: TextField(
      maxLines: maxline,
      style: const TextStyle(color: Colors.white),
      controller: textEditingController?? TextEditingController(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: color ?? const Color(0xFF8E8E8E)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}



Widget postCard(PostModel post)  {
  return Container(
   // height: 30.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 3.h,
                backgroundImage:
                    const AssetImage("assets/walk_through/man.jpg"),
              ),
              SizedBox(
                width: 4.w,
              ),
              currentUser.id.isNotEmpty
                  ? 
                  Text(
                     currentUser.username ,
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 17.sp),
                    )
                  : Text(
                      "GuestUser",
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 17.sp),
                    ),
              const Spacer(),
              const Icon(
                Icons.more_vert,
                color: Colors.white,
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        // post.ownerId == currentUser.id?
        // Image.network(      //for showing post details of relevant owner
        //   post.image,
        // ): SizedBox(),
        Image.network(post.image),
        SizedBox(
          height: 1.5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 3.5.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                Icons.chat_outlined,
                color: Colors.white,
                size: 3.5.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Icon(
                Icons.send,
                color: Colors.white,
                size: 3.5.h,
              ),
              const Spacer(),
              Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 3.5.h,
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            post.description.isNotEmpty
                ? Text(
                    //post.ownerId == currentUser.id? "${currentUser.username} :": "",    //for showing post details of relevant owner
                  "${currentUser.username} :" ,
                    style: GoogleFonts.pacifico(
                        color: Colors.white, fontSize: 16.sp),
                  )
                : const SizedBox(),
            SizedBox(
              width: 2.w,
            ),
            post.description.isNotEmpty
                ? Text(
                  // post.id == currentUser.id? post.description: "",      //for showing post details of relevant owner
                  post.description,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  )
                : const SizedBox()
          ],
        )
      ],
    ),
  );
}




Widget chatWidget(
    {ontap,
    String title = "Jimmy Johnson",
    title2 =
        "It is a long established fact that a reader will be distracted by the readable",
    time = "10:51 AM",
    img = "assets/images/img1.png"}) {
  return InkWell(
    onTap: ontap,
    splashColor: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        // elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          leading: CircleAvatar(
            radius: 2.5.h,
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
          title: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: MyColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text(time,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      color: MyColors.grey2, fontSize: 14.sp))
            ],
          ),
          subtitle: Text(
            title2,
            maxLines: 2,
            style: GoogleFonts.poppins(color: MyColors.grey2, fontSize: 14.sp),
          ),
        ),
      ),
    ),
  );
}


