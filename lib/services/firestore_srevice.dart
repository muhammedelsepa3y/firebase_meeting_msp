import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_meeting_msp/models/user_model.dart';
import 'package:firebase_meeting_msp/services/auth_service.dart';
import 'package:flutter/material.dart';

class FirestoreService extends ChangeNotifier{
  bool loading = false;
  final _firebaseFirestore=FirebaseFirestore.instance;
  void setLoading(bool value){
    loading = value;
    print ("loading: $loading");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

   setUserData(String id,String name,String age,)async{
   await _firebaseFirestore.collection('users').doc(id).set({
      'name': name,
      'age': age,
      'lastLogin': DateTime.now(),
    });
   }
   UserModel? userModel;

  Future<UserModel>getUserData() async{
    String id = AuthService().getCurrentUserId();
    var data= await _firebaseFirestore.collection('users').doc(id).get();
    userModel= UserModel.fromMap(data.data()!);
    print (userModel!.name);
    notifyListeners();
    return userModel!;
  }

  setName(String text)async {
    String id = AuthService().getCurrentUserId();
    await _firebaseFirestore.collection('users').doc(id).update({
      'name': text,
    });
    userModel!.name = text;
    notifyListeners();
  }


}