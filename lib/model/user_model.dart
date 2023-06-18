import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uname;
  final String uemail;
  final String upassword;
  final String uphone;
  final String uaddress;
  final String userUid;
  UserModel({
    required this.uname,
    required this.uemail,
    required this.upassword,
    required this.uphone,
    required this.uaddress,
    required this.userUid,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uname: doc['uname'],
      uemail: doc['uemail'],
      upassword: doc['upassword'],
      uphone: doc['uphone'],
      uaddress: doc['uaddress'],
      userUid: doc['userUid'],
    );
  }
}
