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

  static Future<void> signIn(String email, String password) async {
    if(auth.currentUser == null){
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        LocaleDatabase.db.update("UserData", {"value": email}, where: 'dataID = ?', whereArgs: ['login']);
        LocaleDatabase.db.update("UserData", {"value": password}, where: 'dataID = ?', whereArgs: ['password']);
      } catch(e) {print(e);}
    }
  }

  static Future<void> signUp(String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await auth.signOut();
    LocaleDatabase.db.update("UserData", {"value": ""}, where: 'dataID = ?', whereArgs: ['login']);
    LocaleDatabase.db.update("UserData", {"value": ""}, where: 'dataID = ?', whereArgs: ['password']);
  }

}