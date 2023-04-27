import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/folder.dart';
import '../models/process.dart';

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

  static Future<List<AppProcess>> getAllProcess(String uid) async {
    List<AppProcess> userAllProcess = [];
    try {
      await db.collection('Process').doc(uid).collection('ListProcess').get().then((value) {
        for(var doc in value.docs) {
          Map<String, dynamic> element = doc.data();
          userAllProcess.add(AppProcess(id: doc.id, name: element['name'], description: element['description'], folderID: element['folderID']));
        }
      });
    } on SocketException catch (e) {print(e.toString());}
    return userAllProcess;
  }

  // For the dropdown on create a new process
  static Future<Map<String, String>> getFoldersID(String uid) async {
    Map<String, String> folders = {'': 'Select a folder'};
    try {
      await db.collection('Folders').doc(uid).collection('ListFolders').get().then((value) {
        for (var doc in value.docs) {
          Map<String, dynamic> element = doc.data();
          folders[doc.id] = element['name'];
        }
      });
    } on SocketException catch (e) {print(e.toString());}
    return folders;
  }

  static Future<List<AppFolder>> getAllFolders(String uid) async {
    List<AppFolder> userAllFolders = [];
    try {
      await db.collection('Folders').doc(uid).collection('ListFolders').get().then((value) {
        for(var doc in value.docs) {
          Map<String, dynamic> element = doc.data();
          userAllFolders.add(AppFolder(id: doc.id,name: element['name'], description: element['description']));
        }
      });
    } on SocketException catch (e) {print(e.toString());}
    return userAllFolders;
  }
}