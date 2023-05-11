import 'package:flutter/material.dart';
import 'package:mobp/models/folder.dart';
import 'package:mobp/models/process.dart';

import '../models/user.dart';
import '../utilities/remote_database.dart';


class FolderWidget {
  final AppFolder folder;

  FolderWidget({required this.folder});

  // Les fonctions sont à refaire pour fonctionner avec les folders
  void deleteFolder(BuildContext context, String folderID) async {
    switch (await showDialog<bool>(
        context: context,
        builder: (BuildContext builderContext) {
          return SimpleDialog(
            title: const Text('Confirm to delete this folder'),
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
        // On enlève la ref du dossier que l'on supprime sur chaque procédure
        List<AppProcess> listAppProcess = await RemoteDatabase.getAllProcess();
        for(var process in listAppProcess) {
          if(process.folderID == folderID) {
            await RemoteDatabase.getUserData().collection('ListProcess')
                .doc(process.id).update({'folderID': ''});
          }
        }
        // Puis on supprime le dossier
        await RemoteDatabase.getUserData().collection('ListFolders')
            .doc(folderID).delete();
        break;
      default:
        break;
    }
  }

  Future<void> editFolder(context) async {}
  Future<void> screenFolder(context) async {}

  Widget getWidget(context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF262525), borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 8, right: 8, top: 36, bottom: 36),
            decoration: const BoxDecoration(border: Border(right: BorderSide(style: BorderStyle.solid, color: Colors.white24, width: 1))),
            child: const Icon(Icons.folder, color: Colors.white),
          ),
          Material(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {screenFolder(context);},
              child: Container(
                decoration: const BoxDecoration(border: Border(right: BorderSide(style: BorderStyle.solid, color: Colors.white24, width: 1))),
                padding: const EdgeInsets.all(10),
                width: 251,
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
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(5)),
                color: Colors.transparent,
                child: IconButton(
                    onPressed: () {editFolder(context);},
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
      List<AppFolder> userAllFolders = await RemoteDatabase.getAllFolders();
      for (var element in userAllFolders) {
        widgetsFolder.add(FolderWidget(folder: element).getWidget(context));
      }
    }

    if (widgetsFolder.isEmpty) widgetsFolder.add(const Text('No folder'));
    return widgetsFolder;
  }
}