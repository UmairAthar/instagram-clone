import 'package:uuid/uuid.dart';

class MessageModel {
  String messId = const Uuid().v1();
  String ownerId = "",
      receiverId = "",
      message = "click to start a chat",
      file = "";
  int type = 0; // 0:message, 1:file, 2:audio, 3:sticker
  bool isRead = false, enable = true;
  DateTime creationDate = DateTime.now();
  MessageModel();

  MessageModel.toModel(jsonMap) {
    messId = jsonMap['messId'];
    type = jsonMap['type'];
    enable = jsonMap['enable'];
    file = jsonMap['file'];
    isRead = jsonMap['isRead'];
    message = jsonMap['message'];
    ownerId = jsonMap['ownerId'];
    creationDate = jsonMap['creationDate'].toDate();
  }
  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['messId'] = messId;
    jsonMap['type'] = type;
    jsonMap['file'] = file;
    jsonMap['message'] = message;
    jsonMap['enable'] = enable;
    jsonMap['ownerId'] = ownerId;
    jsonMap['isRead'] = isRead;
    jsonMap["creationDate"] = creationDate;
    return jsonMap;
  }
}
