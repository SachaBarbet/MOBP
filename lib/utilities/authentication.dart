import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class UserAuthentication {
  static late final FirebaseAuth auth;

  static Future<void> initAuth() async {
    auth = FirebaseAuth.instance;
    await auth.setPersistence(Persistence.NONE);
  }

  static Future<void> signIn(String email, String password) async {
    if(auth.currentUser != null){
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }
  }

  static Future<void> signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

}