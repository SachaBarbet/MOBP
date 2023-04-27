import 'package:flutter/material.dart';
import 'package:mobp/models/folder.dart';

import '../models/process.dart';
import '../models/user.dart';
import '../utilities/remote_database.dart';

class FolderWidget {
  final AppFolder folder;

  FolderWidget({required this.folder});

  // Les fonctions sont à refaire pour fonctionner avec les folders
  void deleteFolder(BuildContext context, String processID) async {
    switch (await showDialog<bool>(
        context: context,
        builder: (BuildContext builderContext) {
          return SimpleDialog(
            title: const Text('Confirm to delete this process'),
            children: [
              SimpleDialogOption(
                onPressed: () {Navigator.pop(context, true);},
                child: const Text('DELETE'),
              ),
              SimpleDialogOption(
                onPressed: () {Navigator.pop(context, false);},
                child: const Text('CANCEL'),
              )
            ],
          );
        }
    )) {
      case true:
        await RemoteDatabase.db.collection('Process').doc(AppUser.id).collection('ListProcess').doc(processID).delete();
        break;
      default:
        break;
    }
  }

  Future<void> editFolder() async {}
  Future<void> screenFolder() async {}

  Widget getWidget(context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF262525), borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {screenFolder();},
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
                    onPressed: () {editFolder();},
                    icon: const Icon(Icons.edit, color: Colors.white,)
                ),
              ),
              Material(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5)),
                color: Colors.transparent,
                child: IconButton(
                    onPressed: () {deleteFolder(context, folder.id);},
                    icon: const Icon(Icons.delete, color: Colors.white,)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static Future<List<Widget>> getFolderWidgets(context) async {
    List<Widget> widgetsFolder = [];
    if (AppUser.id.isNotEmpty) {
      List<AppFolder> userAllFolders = await RemoteDatabase.getAllFolders(AppUser.id);
      for (var element in userAllFolders) {
        widgetsFolder.add(FolderWidget(folder: element).getWidget(context));
      }
    }

    if (widgetsFolder.isEmpty) widgetsFolder.add(const Text('No folder'));
    return widgetsFolder;
  }
}