class PostModel {
  String id = "";
  String image = "";
  DateTime creationDate = DateTime.now();
  String ownerId = "";
  String description = "";

  PostModel();

  PostModel.toModel( jsonMap) {
    id = jsonMap['id'];
    ownerId = jsonMap['ownerId'];
    creationDate =jsonMap['creationDate']!=null? jsonMap['creationDate'].toDate():DateTime.now();
    image = jsonMap['image'];
    description = jsonMap['description'];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> jsonMap = <String, dynamic>{};
    jsonMap['id'] = id;
    jsonMap['ownerId'] = ownerId;
    jsonMap['creationDate'] = creationDate;
    jsonMap['image'] = image;
    jsonMap['description'] = description;
    return jsonMap;
  }
}
