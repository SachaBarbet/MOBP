import 'package:flutter/material.dart';
import 'package:mobp/models/folder.dart';

import '../models/process.dart';
import '../models/user.dart';
import '../utilities/remote_database.dart';

class FolderWidget {
  final AppFolder folder;

  FolderWidget({required this.folder});

  Widget getWidget() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF262525), borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: visual,
            child: Container(
              decoration: const BoxDecoration(border: Border(right: BorderSide(style: BorderStyle.solid, color: Colors.white24, width: 1))),
              padding: const EdgeInsets.all(10),
              width: 292,
              height: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(folder.name, style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis),),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(folder.description, style: const TextStyle(color: Colors.white),)
                      )
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(5)),
                color: Colors.transparent,
                child: IconButton(
                    onPressed: edit,
                    icon: const Icon(Icons.edit, color: Colors.white,)
                ),
              ),
              Material(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5)),
                color: Colors.transparent,
                child: IconButton(
                    onPressed: delete,
                    icon: const Icon(Icons.delete, color: Colors.white,)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static Future<List<Widget>> getFolderWidgets() async {
    List<Widget> widgetsFolder = [];
    if (AppUser.id.isNotEmpty) {
      List<AppFolder> userAllFolders = await RemoteDatabase.getAllFolders(AppUser.id);
      for (var element in userAllFolders) {
        widgetsFolder.add(FolderWidget(folder: element).getWidget());
      }
    }

    if (widgetsFolder.isEmpty) widgetsFolder.add(const Text('No folder'));
    return widgetsFolder;
  }
}