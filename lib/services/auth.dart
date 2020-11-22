import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:flutter/material.dart';



class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db  = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  User get getUser => _auth.currentUser;
  Stream<User> get user => _auth.userChanges();



  Future<User> anonLogin()async{
    var authResult =  await _auth.signInAnonymously();
    updateUserData(authResult.user);
    return authResult.user;
  }



  Future<User> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var authResult = await _auth.signInWithCredential(credential);
      if(authResult.additionalUserInfo.isNewUser) {
        updateUserData(authResult.user);
      }
      return authResult.user;
    } catch (error) {
      print(error);
      return null;
    }
  }


  Future<void> updateUserData(User user){

    DocumentReference userRef = _db.collection('users').doc(user.uid);
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);

    reportRef.update({

      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'total': 0,

    }, );

    return userRef.update({

      'uid': user.uid,
      'lastActivity': DateTime.now(),
      'username':user.displayName,
      'img': 'https://i.pinimg.com/originals/29/b8/92/29b8927c804073e215ed8fcfabb105df.jpg',
      'email': user.email,
      'gold': 100,
      'gems':4,

    }, );

  }

  Future<void> signOut(){

    return _auth.signOut();
}


}