import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/config/global.dart';
import 'package:insta/models/message.dart';


class ChatServices {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  sendMessage(Map<String, dynamic> friend, MessageModel message) async {
    // Last Message
    Map<String, dynamic> temp = message.toJSON();
    temp["image"] = friend['image'];
    temp["name"] = friend['name'];
    _instance
        .collection('userProfile')
        .doc(message.ownerId)
        .collection('chat')
        .doc(message.receiverId)
        .set(temp, SetOptions(merge: true));

    temp["name"] = currentUser.username;
    _instance
        .collection('userProfile')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.ownerId)
        .set(temp, SetOptions(merge: true));

    // Send Message
    _instance
        .collection('userProfile')
        .doc(message.ownerId)
        .collection('chat')
        .doc(message.receiverId)
        .collection('messages')
        .doc(message.messId)
        .set(message.toJSON(), SetOptions(merge: true));

    _instance
        .collection('userProfile')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.ownerId)
        .collection('messages')
        .doc(message.messId)
        .set(message.toJSON(), SetOptions(merge: true));
  }

  Query conversation(String friendId) {
    return _instance
        .collection('userProfile')
        .doc(currentUser.id)
        .collection("chat")
        .orderBy('creationDate', descending: true);
  }

  Query searchFriend(String searchKey) {
    return _instance
        .collection('userProfile')
        .where('searchParameter', arrayContains: searchKey)
        .orderBy('dob', descending: true);
  }

  Query friendMessages(String friendId) {
    return _instance
        .collection('userProfile')
        .doc(currentUser.id)
        .collection("chat")
        .doc(friendId)
        .collection("messages")
        .orderBy('creationDate', descending: true);
  }
}
