import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';


class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> emailSignIn(String email, password) async {
    try {
      UserCredential fbUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (fbUser.user != null) {
        currentUser.id = fbUser.user?.uid ?? "";
        return "";
      }
      return "error";
    } on FirebaseAuthException catch (error) {
      FirebaseAuth.instance.signOut();
      return error.message ?? error.code;
    }
  }

  checkUser() async {
    try {
      currentUser.id = _auth.currentUser?.uid ?? "";
    } on FirebaseAuthException {
      currentUser.id = "";
    }
  }

  Future<String> emailSignUp(email, password) async {
    try {
      UserCredential fbUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (fbUser.user != null) {
        currentUser.id = fbUser.user!.uid;
        return "";
      }
      return "error";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  // Future<String> changeEmail(String newEmail) async {
  //   try {
  //     EasyLoading.show();
  //     await FirebaseAuth.instance.currentUser!.updateEmail(newEmail);

  //     EasyLoading.dismiss();
  //     return "";
  //   } on FirebaseAuthException catch (error) {
  //     print(error.message ?? error.code);
  //     return (error.message ?? error.code);
  //   }
  // }

  // Future<bool> checkEmailVarification() async {
  //   try {
  //     await FirebaseAuth.instance.currentUser!.reload();
  //     return FirebaseAuth.instance.currentUser!.emailVerified;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> logOut() async {
    try {
    await _auth.signOut();
    currentUser = UserModel();
    return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
