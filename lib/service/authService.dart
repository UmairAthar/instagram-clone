

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  googleLogin() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return 'Cancelled';
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      UserCredential fbUser = await _auth.signInWithCredential(credential);
      if (fbUser.user != null) {
        currentUser.id = fbUser.user?.uid ?? "";
        currentUser.email=fbUser.user!.email!;
        currentUser.username=fbUser.user!.displayName!;
        return "";
      }
    } on FirebaseAuthException catch (error) {
      FirebaseAuth.instance.signOut();
      return error.message ?? error.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }


    facebookLogin() async {
    try {
      LoginResult facebookLoginResult =
          await FacebookAuth.instance.login(permissions: ["public_profile","email"]);
                    // if(facebookLoginResult.message==null)return 'cancelled';

      if (facebookLoginResult.status == LoginStatus.success) {
        String token = facebookLoginResult.accessToken!.token;
        AuthCredential authCredential = FacebookAuthProvider.credential(token);
        UserCredential fbUser =
            await _auth.signInWithCredential(authCredential);
        // Check if the fbUser contains a valid user object
        if (fbUser.user != null) {
          currentUser.id = fbUser.user?.uid??"";

          currentUser.email = fbUser.user?.email ?? "";
          currentUser.username = fbUser.user?.displayName ?? "";
          return "";
        }
      } else if (facebookLoginResult.status == LoginStatus.cancelled) {
        return("Cancelled");
      } else if (facebookLoginResult.status == LoginStatus.failed) {
        return("Failed");
      }
    } on FirebaseAuthException catch (error) {
      FirebaseAuth.instance.signOut();
      return error.message ?? error.code;
    } catch (e) {
      print(e);
      return e.toString();
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
