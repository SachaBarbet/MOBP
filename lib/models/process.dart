import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobp/utilities/remote_database.dart';

import 'folder.dart';

class AppProcess {
  late String id;
  late String name;
  late String description;
  late String folderID;
  int componentsNumber = 0;

  AppProcess({
    required this.id,
    required this.name,
    required this.description,
    required this.folderID,
  });

  Future<AppFolder> getFolder() async {
    DocumentSnapshot<Map<String, dynamic>> data = await RemoteDatabase.getUserData().collection('ListFolders').doc(folderID).get();
    return AppFolder(id: data.data()!['id'], name: data.data()!['name'], description: data.data()!['description'])  ;
  }
}