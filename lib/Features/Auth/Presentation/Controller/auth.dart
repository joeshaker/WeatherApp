import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/Features/Auth/Presentation/Screen/LoginScreen.dart';
class Auth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentuser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signout({
    required BuildContext context
  })
  async{
    await firebaseAuth.signOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>LoginScreen()));
  }
}
