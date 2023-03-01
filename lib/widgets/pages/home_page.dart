import 'package:flutter/material.dart';
import 'package:mobp/models/database_table.dart';
import 'package:mobp/widgets/pages/settings_page.dart';
import 'package:mobp/widgets/procedure_box.dart';
import '../../app.locator.dart';
import '../../services/local_storage_service.dart';
import 'new_process_page.dart';
import 'connect_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  final localStorageService = locator<LocalStorageService>();

  List<Widget> getProcedureBox() {
    List<DatabaseTable> dbValues = [];
    List<Widget> procedureBoxList = [];
    localStorageService.initLocalDatabase().then((db) =>
      localStorageService.values(db, 'procedures').then((values) => dbValues = values)
    );
    for(var procedure in dbValues) {
      procedureBoxList.add(ProcedureBox(name: procedure.columns['name'], description: procedure.columns['description'], software: procedure.columns['software']));
    }
    return procedureBoxList;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: Scaffold(
        backgroundColor: const Color(0xFF3C3C42),

        body: Center(
          child: ListView(
            children: getProcedureBox(),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const NewProcessPage()));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: const Color(0xFF13131D),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: IconButton(icon: const Icon(Icons.dashboard, color: Colors.white,), onPressed: (){},)
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: IconButton(icon: const Icon(Icons.swap_vert, color: Colors.white,), onPressed: (){},)
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: IconButton(icon: const Icon(Icons.account_circle, color: Colors.white,), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ConnectPage()));
                      },),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: IconButton(icon: const Icon(Icons.settings, color: Colors.white,), onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                      },),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}