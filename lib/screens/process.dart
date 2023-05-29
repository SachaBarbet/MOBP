import 'package:flutter/material.dart';
import 'package:mobp/screens/edit_process_component.dart';
import 'package:mobp/utilities/remote_database.dart';

import '../models/component.dart';
import '../models/process.dart';
import '../utilities/locale_database.dart';
import 'auth.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.process});
  final AppProcess process;

  @override
  State<StatefulWidget> createState() => _ProcessScreen();
}

class _ProcessScreen extends State<ProcessScreen> {

  late Future<List<ProcessComponent>> components;

  Future<List<ProcessComponent>> getAllWidgets(context) async {
    List<ProcessComponent> components = [];
    if (LocaleDatabase.connected) {
      components = await RemoteDatabase.getProcessComponents(widget.process.id);
    }
    return components;
  }

  void reloadData() {
    setState(() {
      components = getAllWidgets(context);
    });
  }

  @override
  void initState() {
    super.initState();

    if (!LocaleDatabase.connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Auth())));
    }
    components = getAllWidgets(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF3D3B3C),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEAC435),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.process.name, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: IconButton(icon: const Icon(Icons.refresh, color: Colors.white,), onPressed: (){
                reloadData();
              },),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditProcessComponent(process: widget.process)));
              },
              icon: const Icon(Icons.edit))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
          child: Container(
            decoration: const BoxDecoration(color: Color(0xFF262525), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: FutureBuilder(
                  future: components,
                  builder: (context, snapshot) {
                    List<ProcessComponent> components = [ProcessComponent(id: "", widget: "error", index: 0, data: ['No data'], processID: '')];
                    if(snapshot.hasData) {
                      components = snapshot.data!;
                    } else if (snapshot.hasError) {
                      components = [
                        ProcessComponent(id: "", widget: "error", index: 0, data: ['Result : ${snapshot.error}'], processID: '')
                      ];
                    }
                    return Center(
                      child: ListView(
                        children: components.map((component) {
                          return component.getWidget();
                        }).toList(),
                      )
                    );
                  },
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}