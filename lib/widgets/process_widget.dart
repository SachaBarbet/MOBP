import 'package:flutter/material.dart';

import '../models/process.dart';
import '../models/user.dart';
import '../screens/edit_process.dart';
import '../screens/process.dart';
import '../utilities/remote_database.dart';

class ProcessWidget {
  final AppProcess process;

  ProcessWidget({required this.process});

  Future<void> deleteProcess(BuildContext context, String processID) async {
    switch (await showDialog<bool>(
        context: context,
        builder: (BuildContext builderContext) {
          return SimpleDialog(
            title: const Text('Click on DELETE to confirm the suppression of this process', style: TextStyle(fontSize: 16),),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SimpleDialogOption(
                    onPressed: () {Navigator.pop(context, true);},
                    child: const Text('DELETE', style: TextStyle(color: Colors.red),),
                  ),
                  SimpleDialogOption(
                    onPressed: () {Navigator.pop(context, false);},
                    child: const Text('CANCEL'),
                  )
                ],
              )
            ],
          );
        }
    )) {
      case true:
        await RemoteDatabase.getUserData().collection('ListProcess')
            .doc(processID).delete();
        break;
      default:
        break;
    }
  }

  Future<void> editProcess(context) async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => EditProcess(process: process)));
  }

  Future<void> screenProcess(context) async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ProcessScreen(process: process)));
  }

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
            child: const Icon(Icons.file_open_rounded, color: Colors.white),
          ),
          Material(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {screenProcess(context);},
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
                      child: Text(process.name, style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis),),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(process.description, style: const TextStyle(color: Colors.white),)
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
                    onPressed: () {editProcess(context);},
                    icon: const Icon(Icons.edit, color: Colors.white,)
                ),
              ),
              Material(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5)),
                color: Colors.transparent,
                child: IconButton(
                    onPressed: () {deleteProcess(context, process.id);},
                    icon: const Icon(Icons.delete, color: Colors.white,)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  static Future<List<Widget>> getProcessWidgets(context) async {
    List<Widget> widgetsProcess = [];
    if (AppUser.id.isNotEmpty) {
      List<AppProcess> userAllProcess = await RemoteDatabase.getAllProcess();
      for (var element in userAllProcess) {
        if (element.folderID.isEmpty) {
          widgetsProcess.add(ProcessWidget(process: element).getWidget(context));
        }
      }
    }

    if (widgetsProcess.isEmpty) {
      widgetsProcess.add(const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('You don\'t have a process, you can create one with the + button.', style: TextStyle(color: Color(0xFFAAAAAA)),),
        ),
      ));
    }
    return widgetsProcess;
  }

  static Future<List<Widget>> getFolderProcessWidgets(context, folderID) async {
    List<Widget> widgetsProcess = [];
    if (AppUser.id.isNotEmpty) {
      List<AppProcess> userAllProcess = await RemoteDatabase.getAllProcess();
      for (var element in userAllProcess) {
        if (element.folderID == folderID) {
          widgetsProcess.add(ProcessWidget(process: element).getWidget(context));
        }
      }
    }

    if (widgetsProcess.isEmpty) {
      widgetsProcess.add(const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('There is no process here.', style: TextStyle(color: Color(0xFFAAAAAA)),),
        ),
      ));
    }
    return widgetsProcess;
  }
}

