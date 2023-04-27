import 'package:flutter/material.dart';
import 'package:mobp/models/folder.dart';

import '../models/process.dart';
import '../models/user.dart';
import '../utilities/remote_database.dart';

class DropdownWidget {
  final String id;
  final String name;

  DropdownWidget({required this.id, required this.name});

  Widget getWidget() {
    return DropdownMenuItem(
      value: id,
      child: Text(name)
    );
  }

  static Future<List<Widget>> getDropDownWidgets() async {
    List<Widget> widgetsDropdown = [];
    if (AppUser.id.isNotEmpty) {
      Map<String, String> foldersMap = await RemoteDatabase.getFoldersID(AppUser.id);
      foldersMap.forEach((key, value) {
        widgetsDropdown.add(DropdownWidget(id: key, name: value).getWidget());
      });
    }
    if (widgetsDropdown.isEmpty) widgetsDropdown.add(const Text('No Data'));
    return widgetsDropdown;
  }
}