


import 'package:insta/config/global.dart';
import 'package:insta/models/userModel.dart';
import 'package:insta/service/fireStoreApi.dart';

class FirestoreServices {
  final FirestoreApi _instance = FirestoreApi();

  // Users
  registerUser() async {
    await _instance.postANode(
        path: 'userProfile/${currentUser.id}', data: currentUser.toJSON());
  }

  updateUser(UserModel user) async {
    await _instance.updateANode(
        path: 'userProfile/${user.id}', data: user.toJSON());
  }

  Future<UserModel?> getUser(String uId) async {
    MyResponse response = await _instance.fetchANode(path: 'userProfile/$uId');
    if (response.success) {
      return UserModel.toModel(response.data);
    }
    return null;
  }
}
