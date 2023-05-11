import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobp/utilities/locale_database.dart';

import '../models/user.dart';

class UserAuthentication {
  static late final FirebaseAuth auth;

  static Future<void> initAuth() async {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        LocaleDatabase.connected = false;
        AppUser.id = '';
      } else {
        LocaleDatabase.connected = true;
        AppUser.id = user.uid;
      }
    });
  }

  static Future<bool> signIn(String email, String password) async {
    if(auth.currentUser == null){
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        LocaleDatabase.db.update("UserData", {"value": email}, where: 'dataID = ?', whereArgs: ['login']);
        LocaleDatabase.db.update("UserData", {"value": password}, where: 'dataID = ?', whereArgs: ['password']);
        if (auth.currentUser!.displayName != null) {
          AppUser.name = auth.currentUser!.displayName!;
        }
        AppUser.id = auth.currentUser!.uid;
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
    return false;
  }

  static Future<bool> signUp(String email, String password, String name) async {
    if(auth.currentUser == null){
      try {
        await auth.createUserWithEmailAndPassword(email: email, password: password);
        await auth.currentUser?.updateDisplayName(name);
        return true;
      } catch(e) {print(e);}
    }
    return false;
  }

  static Future<void> signOut() async {
    await auth.signOut();
    LocaleDatabase.db.update("UserData", {"value": ""}, where: 'dataID = ?', whereArgs: ['login']);
    LocaleDatabase.db.update("UserData", {"value": ""}, where: 'dataID = ?', whereArgs: ['password']);
  }

}