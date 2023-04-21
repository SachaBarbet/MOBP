import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDatabase {
  static late FirebaseFirestore db;
  static late bool connectedToInternet;

  static Future<void> initData() async {
    db = FirebaseFirestore.instance;
    connectedToInternet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      connectedToInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {}
  }

  static Future<bool> isUserInDb(String userLogin, String password) async {
    var querySnapshot = await db.collection('Users').where('login', isEqualTo: userLogin).get();
    if(querySnapshot.docs.isEmpty) return false;
    if(password == querySnapshot.docs[0]['password'] as String) return true;
    return false;
  }

  static userConnection() {

  }

  static syncFromLocal() {

  }
}