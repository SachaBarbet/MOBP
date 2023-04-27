import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utilities/remote_database.dart';

class DropdownWidget {
  final String id;
  final String name;

  DropdownWidget({required this.id, required this.name});

  DropdownMenuItem<String> getWidget() {
    return DropdownMenuItem(
      value: id,
      child: Text(name)
    );
  }

  static Future<List<DropdownMenuItem<String>>> getDropDownWidgets() async {
    List<DropdownMenuItem<String>> widgetsDropdown = [];
    if (AppUser.id.isNotEmpty) {
      Map<String, String> foldersMap = await RemoteDatabase.getFoldersID(AppUser.id);
      foldersMap.forEach((key, value) {
        widgetsDropdown.add(DropdownWidget(id: key, name: value).getWidget());
      });
    }
    if (widgetsDropdown.isEmpty) widgetsDropdown.add(DropdownWidget(id: '', name: 'No folder found').getWidget());
    return widgetsDropdown;
  }
}