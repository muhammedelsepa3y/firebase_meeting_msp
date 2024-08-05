import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firestore_srevice.dart';

class AuthService extends ChangeNotifier{
  bool loading = false;
  final _firebaseAuth=FirebaseAuth.instance;
  void setLoading(bool value){
    loading = value;
    print ("loading: $loading");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

 login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    }on FirebaseAuthException catch (e){
      switch (e.code){
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'Wrong password provided for that user.';
        case 'user-disabled':
          throw 'User disabled';
        case 'too-many-requests':
          throw 'Too many requests';
        case 'operation-not-allowed':
          throw 'Operation not allowed';
          case 'invalid-credential':
          throw 'User credential is invalid';
        default:
          print (e.code);
          throw 'An error occurred';
       }
    }catch (e){
      print (e);
      throw 'An error occurred';
    }
 }

  register(String email, String password,String name,String age) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String id = _firebaseAuth.currentUser!.uid;
      await FirestoreService().setUserData(id,name, age);
    }on FirebaseAuthException catch (e){
      switch (e.code){
        case 'email-already-in-use':
          throw 'The account already exists for that email.';
        case 'weak-password':
          throw 'The password provided is too weak.';
        case 'too-many-requests':
          throw 'Too many requests';
        case 'operation-not-allowed':
          throw 'Operation not allowed';

        default:
          print (e.code);
          throw 'An error occurred';
      }
    }catch (e){
      print (e);
      throw 'An error occurred';
    }
  }

  logout()async {
    await _firebaseAuth.signOut();
  }

  getCurrentUserId(){
    return _firebaseAuth.currentUser!.uid;
  }
}