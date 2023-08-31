import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta/controller/post.dart';
import 'package:insta/models/postModel.dart';
import 'package:insta/screens/chatList.dart';
import 'package:insta/screens/login.dart';
import 'package:insta/screens/postDetails.dart';
import 'package:insta/screens/splash.dart';
import 'package:insta/screens/widgets.dart';
import 'package:insta/service/authService.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
bool enable = true;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData()async{
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      enable = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (con) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "𝓘𝓷𝓼𝓽𝓪𝓰𝓻𝓪𝓶",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                centerTitle: false,
                actions: [
                   InkWell(
                    onTap: () {
                      Get.to(ChatLists());
                    },
                    child:
                    Icon(Icons.message_rounded,color: Colors.white,size: 3.h,)),
                  SizedBox(width: 5.w,),
                  InkWell(
                      splashColor: Colors.transparent,
                      onTap: () async {
                        bool check = await Get.find<AuthServices>().logOut();
                        if (check) Get.offAll(const InstaLoginScreen());
                      },
                      child: const Icon(Icons.logout)),
                  const Icon(
                    Icons.ad_units,
                    color: Colors.transparent,
                  )
                ],
              ),
              backgroundColor: Colors.black,
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xFF311E51),
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Get.to(PostDetailScreen());
                },
              ),
              body: PaginateFirestore(
                itemBuilder: (context, documentSnapshots, index) {
                  PostModel post = PostModel();
                  final data = documentSnapshots[index].data();
                  post = PostModel.toModel(data);
                  return postCard(post,enable);
                },
                query: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('creationDate', descending: true),
                itemBuilderType: PaginateBuilderType.listView,
                isLive: true,
              ),
            ));
  }
}
