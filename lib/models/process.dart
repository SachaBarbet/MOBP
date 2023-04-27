import 'package:flutter/material.dart';
import 'package:mobp/models/user.dart';

import '../utilities/remote_database.dart';
import 'component.dart';

class AppProcess {
  late String id;
  late String name;
  late String description;
  late String folderID;
  late List<ProcessComponent> components;

  AppProcess({required String id, required this.name, required this.description, required this.folderID});
}