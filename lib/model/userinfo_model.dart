import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  String? username;
  String? email;
  String? phone;
  String? uid;
  UserInfoModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.uid,
  });

  UserInfoModel.fromJson(DocumentSnapshot documentSnapshot) {
    username = documentSnapshot['username'];
    email = documentSnapshot['email'];
    phone = documentSnapshot['phone'];
    uid = documentSnapshot["uid"];
  }
}
