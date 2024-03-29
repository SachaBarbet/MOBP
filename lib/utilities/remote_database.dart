import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/component.dart';
import '../models/folder.dart';
import '../models/process.dart';
import '../models/user.dart';


class RemoteDatabase {
  static late FirebaseFirestore db;
  static late bool connectedToInternet;

  static Future<void> initData() async {
    db = FirebaseFirestore.instance;
    connectedToInternet = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      connectedToInternet = result.isNotEmpty&&result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {}
  }

  static DocumentReference<Map<String, dynamic>> getUserData() {
    return db.collection('Users').doc(AppUser.id);
  }

  static Future<List<AppProcess>> getAllProcess() async {
    List<AppProcess> userAllProcess = [];
    try {
      QuerySnapshot<Map<String, dynamic>> value = await getUserData()
          .collection('ListProcess').get();
      for(var doc in value.docs) {
        Map<String, dynamic> element = doc.data();
        userAllProcess.add(AppProcess(
            id: doc.id,
            name: element['name'],
            description: element['description'],
            folderID: element['folderID']
        ));
      }
    } on SocketException catch (e) {print(e.toString());}
    return userAllProcess;
  }

  // For the dropdown on create a new process
  static Future<Map<String, String>> getFoldersID() async {
    Map<String, String> folders = {'': 'Select a folder'};
    try {
      QuerySnapshot<Map<String, dynamic>> value = await getUserData()
          .collection('ListFolders').get();
      for (var doc in value.docs) {
        Map<String, dynamic> element = doc.data();
        folders[doc.id] = element['name'];
      }
    } on SocketException catch (e) {print(e.toString());}
    return folders;
  }

  static Future<List<AppFolder>> getAllFolders() async {
    List<AppFolder> userAllFolders = [];
    try {
      QuerySnapshot<Map<String, dynamic>> value = await getUserData()
          .collection('ListFolders').get();
      for (var doc in value.docs) {
        Map<String, dynamic> element = doc.data();
        userAllFolders.add(AppFolder(
            id: doc.id,
            name: element['name'],
            description: element['description']
        ));
      }
    } on SocketException catch (e) {print(e.toString());}
    return userAllFolders;
  }

  static Future<List<ProcessComponent>> getProcessComponents(String processID) async {
    List<ProcessComponent> processComponents = [];
    try {
      QuerySnapshot<Map<String, dynamic>> components = await getUserData()
          .collection('ListProcess').doc(processID).collection('Components').get();
      for (var element in components.docs) {
        Map<String, dynamic> componentData = element.data();
        List<dynamic> componentDataList = [];
        if (componentData['data'] != null && componentData['data'].length != 0) {
          componentDataList = componentData['data'];
        }
        ProcessComponent component = ProcessComponent(
            id: element.id,
            processID: processID,
            widget: componentData['componentWidget'],
            index: componentData['componentIndex'],
            data: componentDataList
        );
        processComponents.add(component);
      }
      processComponents.sort((a, b) => a.index.compareTo(b.index));
    } on SocketException catch (e) {print(e.toString());}

    return processComponents;
  }
}