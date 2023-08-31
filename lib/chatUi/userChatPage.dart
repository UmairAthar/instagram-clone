
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/chatUi/bubule.dart';
import 'package:insta/config/colors.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/message.dart';
import 'package:insta/service/chatServices.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageUser extends StatefulWidget {
  Map<String, dynamic> data;
  ChatPageUser(this.data, {Key? key}) : super(key: key);
  @override
  _ChatPageUserState createState() => _ChatPageUserState();
}

TextEditingController cont = TextEditingController();

class _ChatPageUserState extends State<ChatPageUser> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
            leading: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                    child:
                        const Icon(Icons.arrow_back_ios_new, color: Colors.white))),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    SizedBox(width: 2.w),
                    Text(
                      widget.data['name']??widget.data['username'],
                      style: GoogleFonts.montserrat(
                          color: MyColors.white,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ]),
      ),
      bottomNavigationBar: Container(
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 6),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Divider(thickness: 1, color: Colors.deepPurple),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: TextField(
                            controller: cont,
                            onChanged: (value) {
                              setState(() {});
                            },
                            style: GoogleFonts.montserrat(
                                fontSize: 15.sp, color: MyColors.white),

                            decoration: InputDecoration(
                              
                                prefixIconConstraints: BoxConstraints(
                                    maxWidth: 10.w, maxHeight: 3.h),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                hintText: "Enter Message".tr,
                                hintStyle: GoogleFonts.montserrat(
                                    fontSize: 15.sp, color: MyColors.white),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10))),
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () async {
                          MessageModel message = MessageModel();
                          message.message = cont.text;
                          message.ownerId = currentUser.id;
                          message.receiverId = widget.data["id"];
                          Get.find<ChatServices>()
                              .sendMessage(widget.data, message);
                          cont.text = "";},
                        //   NotificationModel notification = NotificationModel();
                        //   notification.id = FirebaseFirestore.instance
                        //       .collection('notifications')
                        //       .doc()
                        //       .id;
                        //   notification.receiverId = widget.data['id'];
                        //   notification.userId = currentUser.id;
                        //   notification.title = "New Message";
                        //   notification.additionalId = "";
                        //   notification.type = 0;
                        //   notification.body =
                        //       "You got the new message from ${currentUser.name}";
                        //   String fcm = await Get.find<FirestoreServices>()
                        //       .getFcm(widget.data['id']);
                        //   if (fcm != "") {
                        //     await Get.find<NotificationServices>()
                        //         .sendNotificationsDeviceId(
                        //             fcm,
                        //             "New Message",
                        //             "You got the new message from ${currentUser.name}",
                        //             {});
                        //   }
                        //   await FirebaseFirestore.instance
                        //       .collection('notifications')
                        //       .doc(notification.id)
                        //       .set(notification.toMap());
                        //   setState(() {});
                        // },
                        child:
                            Image.asset("assets/icons/send.png",height: 2.5.h,color: Colors.deepPurple,))
                  ]))
            ])),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
        child: PaginateFirestore(
            key: Key('friendMessages:${widget.data["id"]}'),
            onEmpty: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text("No chat found",
                    style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 18,
                        wordSpacing: 1.5,
                        letterSpacing: .5))),
            initialLoader: Padding(
                padding: EdgeInsets.only(bottom: 45.h),
                child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2))),
            itemBuilder: (context, documentSnapshots, index) {
              if (documentSnapshots[index].exists) {
                Map<String, dynamic> data =
                    documentSnapshots[index].data() as Map<String, dynamic>;
                MessageModel message = MessageModel();
                message = MessageModel.toModel(data);
                return Bubble(message);
              } else {
                return SizedBox();
              }
            },
            reverse: true,
            query: Get.find<ChatServices>()
                .friendMessages(widget.data["id"] ?? ""),
            itemBuilderType: PaginateBuilderType.listView,
            isLive: true),
      ));
}
