import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta/chatUi/userChatPage.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: Text("Contacts",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500)),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: allUsers.length,
          itemBuilder: (context, index) {
            return allUsers[index].id != currentUser.id
                ? ListTile(
                    minVerticalPadding: 3.h,
                    leading: CircleAvatar(
                      radius: 3.h,
                      backgroundImage:
                          const AssetImage('assets/walk_through/man.jpg'),
                    ),
                    title: Text(
                      allUsers[index].username,
                      style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    ),
                    trailing: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Map<String, dynamic> data = {
                        'name': allUsers[index].username,
                        'id': allUsers[index].id,
                      };
                      Get.to(() => ChatPageUser(data));
                    },
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

List<UserModel> allUsers = [];
Future<void> getAllUsers() async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('userProfile').get();
  allUsers = snapshot.docs.map((DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel.toModel(
        data); // Assuming you have a fromJson method in UserModel class
  }).toList();

  print(allUsers.length);
}
