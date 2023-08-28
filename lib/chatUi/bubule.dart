import 'package:flutter/material.dart';
import 'package:insta/config/colors.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/message.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class Bubble extends StatelessWidget {
  Bubble(
    this.msg, {
    Key? key,
  }) : super(key: key);
  MessageModel msg;

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
      child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          textDirection: msg.ownerId == currentUser.id
              ? TextDirection.rtl
              : TextDirection.ltr,
          children: [_bubble(context, msg)]));

  Widget _bubble(BuildContext context, MessageModel msg) => Container(
      constraints: BoxConstraints(maxWidth: 100.w * .7),
      padding: EdgeInsets.symmetric(vertical: 2.8.w),
      child: msg.ownerId == currentUser.id
          ? Container(
              constraints: BoxConstraints(maxWidth: 100.w * .9),
              padding: EdgeInsets.symmetric(vertical: 2.5.w),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('03:33',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            color: MyColors.black)),
                    SizedBox(width: 2.w),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: SizedBox(
                            width: 60.w,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(msg.message,
                                    textDirection: TextDirection.ltr,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        color: MyColors.black))))),
                  ]))
          : Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                  decoration: BoxDecoration(
                      color: MyColors.bGrey,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6))),
                  child: SizedBox(
                      width: 60.w,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            msg.message,
                            style: GoogleFonts.montserrat(
                                fontSize: 15.sp, color: MyColors.black),
                          )))),
              SizedBox(width: 2.w),
              Text('03:33',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      color: MyColors.black))
            ]));
}
