import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';
import 'package:insta/screens/home.dart';
import 'package:insta/screens/login.dart';
import 'package:insta/screens/postDetails.dart';
import 'package:insta/screens/signUp.dart';
import 'package:insta/screens/splash.dart';
import 'package:insta/service/authService.dart';
import 'package:insta/service/chatServices.dart';
import 'package:insta/service/firestoreService.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


Future<void> main() async {
 await onInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          builder: EasyLoading.init());
    });
  }
}

onInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthServices());
  Get.put(FirestoreServices());
  Get.put(ChatServices());
  
}






















