import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String age;
  String name;
  DateTime lastLogin;
  UserModel({
    required this.age,
    required this.name,
    required this.lastLogin,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      age: map['age'],
      name: map['name'],
      lastLogin:map['lastLogin'].toDate(),
    );
  }

}