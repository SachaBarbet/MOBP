import 'package:flutter/material.dart';
import 'package:mobp/models/folder.dart';
import 'package:mobp/utilities/locale_database.dart';
import 'package:mobp/widgets/process_widget.dart';

import 'auth.dart';


class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key, required this.folder});
  final AppFolder folder;

  @override
  State<StatefulWidget> createState() => _FolderScreen();
}

class _FolderScreen extends State<FolderScreen> {
  late Future<List<Widget>> widgetList;

  Future<List<Widget>> getFolderWidgets(context) async {
    List<Widget> allWidgets = [];
    if (LocaleDatabase.connected) {
      allWidgets.addAll(await ProcessWidget.getFolderProcessWidgets(context, widget.folder.id));
    } else {
      allWidgets.add(const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('You are not connected !', style: TextStyle(color: Color(0xFFAAAAAA)),),
        ),
      ));
    }

    return allWidgets;
  }

  @override
  void initState() {
    super.initState();
    // Permet de se d'afficher la page de connection au lancement si non connecté
    if (!LocaleDatabase.connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Auth())));
    }
    widgetList = getFolderWidgets(context);
  }

  void leaveFolderScreen() {
    Navigator.pop(context);
  }
  
  void reloadData() {
    setState(() {
      widgetList = getFolderWidgets(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBP',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF3D3B3C),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Widget>>(
            future: widgetList,
            builder: (context, snapshot) {
              List<Widget> children;
              if(snapshot.hasData) {
                children = [
                  BackButton(
                  color: Colors.white,
                  onPressed: () {
                    leaveFolderScreen();
                  }
                ),];
                children.addAll(snapshot.data!);
              } else if (snapshot.hasError) {
                children = [
                  Text('Result : ${snapshot.error}')
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(color: Color(0xFFEAC435)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (ctxt/*context*/, ind) {return children[ind];},
                ),
              );
            },
          )
        ),
      ),
    );
  }
}