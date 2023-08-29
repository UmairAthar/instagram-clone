import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/chatUi/userChatPage.dart';
import 'package:insta/config/colors.dart';
import 'package:insta/config/global.dart';
import 'package:insta/controller/homeController.dart';
import 'package:insta/screens/usersList.dart';
import 'package:insta/screens/widgets.dart';
import 'package:insta/service/chatServices.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (HomeController _) => Scaffold(
            backgroundColor: Colors.black,
            body: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 12),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.white,
                                                
                                              )),
                                          const Spacer(),
                                          const Icon(
                                            Icons.more_vert_outlined,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Text("All Messages".tr,
                                          style: GoogleFonts.poppins(
                                              color: MyColors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 3.h),
                                      TextField(
                                        controller: _.friendName,
                                        onChanged: (value) => _.update(),
                                        style: GoogleFonts.poppins(
                                            color: MyColors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                        decoration: InputDecoration(
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 18.0),
                                              child: Image.asset(
                                                "assets/icons/search2.png",
                                                color: MyColors.grey1,
                                              ),
                                            ),
                                            hintText: "Search".tr,
                                            hintStyle: GoogleFonts.poppins(
                                                color: MyColors.grey1),
                                            suffixIconConstraints:
                                                BoxConstraints(
                                                    // maxWidth: 40.w,
                                                    maxHeight: 2.5.h),
                                            contentPadding: EdgeInsets.all(14),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                    color: MyColors.grey)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: const BorderSide(
                                                    color: Colors.deepPurple))),
                                      ),
                                      SizedBox(height: 2.h),
                                      Expanded(
                                        child: PaginateFirestore(
                                            key: Key(_.friendName.text.isNotEmpty
                                                ? 'searchUser:${_.friendName.text}'
                                                : 'conversation:${currentUser.id}'),
                                            onEmpty: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 30.h),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                       Get.to(const UsersScreen());
                                                      },
                                                      child:  CircleAvatar(radius: 3.h,backgroundColor: Colors.deepPurple,child: Icon(Icons.add,color: Colors.white,),)),
                                                    SizedBox(height: 3.h,),
                                                    Text(
                                                        "No Conversation Found".tr,
                                                        style: GoogleFonts.abel(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            wordSpacing: 1.5,
                                                            letterSpacing: .5)),
                                                  ],
                                                )),
                                            initialLoader: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 45.h),
                                                child: const Center(
                                                    child: CircularProgressIndicator(
                                                        strokeWidth: 2))),
                                            itemBuilder: (context, documentSnapshots, index) {
                                              if (documentSnapshots[index]
                                                  .exists) {
                                                Map<String, dynamic> data =
                                                    documentSnapshots[index]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                return chatWidget(
                                                  ontap: () {
                                                    data['id'] =
                                                        documentSnapshots[index]
                                                            .id;
                                                    Get.to(() =>
                                                        ChatPageUser(data));
                                                  },
                                                  title: data['name']
                                                      .toString()
                                                      .capitalizeFirst!,
                                                  title2: (data['message'] ??
                                                          "Click to send a message")
                                                      .toString(),
                                                  time: timeago.format(
                                                      data['creationDate'] ==
                                                              null
                                                          ? data['dob'].toDate()
                                                          : data['creationDate']
                                                              .toDate(),
                                                      locale: 'en_short'),
                                                  // img:
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                            query: _.friendName.text.isNotEmpty
                                                ? Get.find<ChatServices>()
                                                    .searchFriend(_.friendName.text)
                                                : Get.find<ChatServices>().conversation(currentUser.id),
                                            itemBuilderType: PaginateBuilderType.listView,
                                            isLive: true),
                                      )
                                    ])))
                      ]),
                ))));
  }
}
