import 'package:cloud_firestore/cloud_firestore.dart';

class PeopleModel {
  String? id;
  String? com_id;
  String? photo;

  PeopleModel({
    this.id,
    this.com_id,
    this.photo,
  });

  PeopleModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    com_id = doc['com_id'];
    photo = doc['photo'];
  }
  Map<String, dynamic> toMap() {
    return {
      'com_id': com_id,
      'photo': photo,
    };
  }
}
