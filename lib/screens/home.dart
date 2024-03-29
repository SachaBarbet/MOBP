import 'package:flutter/material.dart';
import 'package:mobp/screens/add_folder.dart';
import 'package:mobp/screens/add_process.dart';
import 'package:mobp/utilities/locale_database.dart';
import 'package:mobp/widgets/process_widget.dart';

import '../widgets/folder_widget.dart';
import 'account.dart';
import 'auth.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  late Future<List<Widget>> widgetList;

  Future<List<Widget>> getAllWidgets(context) async {
    List<Widget> allWidgets = [];
    if (LocaleDatabase.connected) {
      allWidgets.addAll(await FolderWidget.getFolderWidgets(context));
      allWidgets.addAll(await ProcessWidget.getProcessWidgets(context));
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
    widgetList = getAllWidgets(context);
  }
  
  void reloadData() {
    setState(() {
      widgetList = getAllWidgets(context);
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
                children = snapshot.data!;
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

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFEAC435),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AddProcess()));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: const Color(0xFF262525),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: IconButton(icon: const Icon(Icons.folder, color: Colors.white,), onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const AddFolder()));
                },),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: IconButton(icon: const Icon(Icons.refresh, color: Colors.white,), onPressed: (){
                        reloadData();
                      },),
                    ),
                    IconButton(icon: const Icon(Icons.account_circle, color: Colors.white,), onPressed: () {
                      if (LocaleDatabase.connected) {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const Account()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const Auth()));
                      }
                    },),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}