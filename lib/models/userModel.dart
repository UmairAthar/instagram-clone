class UserModel {
  String id = '';
  String email = '';
  String username = "";
  String fcm = '';
  DateTime dob = DateTime.now();
  UserModel();

  UserModel.toModel(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    username = jsonMap['username'];
    email = jsonMap['email'];
    fcm = jsonMap['fcm'];
    dob =jsonMap['dob']!=null? jsonMap['dob'].toDate():DateTime.now();

  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['email'] = email;
    jsonMap['username'] = username;
    jsonMap['fcm'] = fcm;
    jsonMap['dob'] = dob;

    return jsonMap;
  }
}
