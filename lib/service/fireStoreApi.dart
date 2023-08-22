import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  static final FirebaseFirestore firebaseRef = FirebaseFirestore.instance;

  static init() {
    // firebaseRef.settings = const Settings(
    //     persistenceEnabled: true,
    //     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  Future<MyResponse> postANode(
      {required String path, required Map<String, dynamic> data}) async {
    MyResponse response = MyResponse();
    try {
      await firebaseRef.doc(path).set(data).then((value) {
        response.success = true;
      });
    } catch (e) {
      log("exception while adding Node data: ${e.toString()}");
    }
    return response;
  }

  Future<bool> checkANode({required String path}) async {
    try {
      final event = await firebaseRef.doc(path).get();
      if (event.exists) {
        return true;
      }
    } catch (e) {
      log("exception while checking Node data: ${e.toString()}");
    }
    return false;
  }

  Future<bool> deleteANode({required String path}) async {
    try {
      await firebaseRef.doc(path).delete();
      return true;
    } catch (e) {
      log("exception while adding Node data: ${e.toString()}");
    }
    return false;
  }

  String postANodeId(String path) {
    return firebaseRef.collection(path).doc().id;
  }

  Future<MyResponse> updateANode(
      {required String path, required Map<String, Object?> data}) async {
    MyResponse response = MyResponse();
    try {
      await firebaseRef.doc(path).update(data).then((value) {
        response.success = true;
      });
    } catch (e) {
      log("exception while updating Node data: ${e.toString()}");
    }
    return response;
  }

  Future<MyResponse> fetchANode({required String path}) async {
    MyResponse response = MyResponse();
    try {
      final event = await firebaseRef.doc(path).get();
      if (event.exists) {
        response.success = true;
        response.data = event.data();
      } else {
        log("snap shot not exists");
      }
    } catch (e) {
      log("exception while fetching Node data: ${e.toString()}");
    }
    return response;
  }
}

class MyResponse {
  bool success;
  dynamic data;
  MyResponse({this.success = false, this.data});
}
