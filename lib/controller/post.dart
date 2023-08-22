import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/config/global.dart';
import 'package:insta/screens/home.dart';


class PostController extends GetxController {
  final ImagePicker picker = ImagePicker();
  String imageUrl = "";
  XFile? pickedImage;
  File? image;
  pickImage() async {
    try {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return 'error';
      image = File(pickedImage!.path);

      update();
    } catch (error) {
      return 'error';
    }
  }

  Future<bool> setPost() async {
    try {
      Reference referenceRoot =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}');
      EasyLoading.show();
      await referenceRoot.putFile(image!);
      imageUrl = await referenceRoot.getDownloadURL();
      post.image = imageUrl;
      post.ownerId = currentUser.id;
      post.creationDate = DateTime.now();
      post.id = FirebaseFirestore.instance.collection('posts').doc().id;
      //print(imageUrl);
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .set(post.toJSON());
          EasyLoading.dismiss();
          Get.offAll(const HomePage());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
