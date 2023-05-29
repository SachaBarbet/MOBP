import 'package:flutter/material.dart';
import 'package:mobp/screens/add_component.dart';

import '../models/component.dart';
import '../models/process.dart';
import '../utilities/locale_database.dart';
import '../utilities/remote_database.dart';
import 'auth.dart';


class EditProcessComponent extends StatefulWidget {
  final AppProcess process;
  const EditProcessComponent({super.key, required this.process});

  @override
  State<StatefulWidget> createState() => _EditProcessComponent();
}


class _EditProcessComponent extends State<EditProcessComponent> {

  late Future<List<ProcessComponent>> widgetList;
  int maxIndex = 0;

  Future<List<ProcessComponent>> getComponents(context) async {
    List<ProcessComponent> components = [];
    if (LocaleDatabase.connected) {
      components = await RemoteDatabase.getProcessComponents(widget.process.id);
      widget.process.componentsNumber = components.length;
    }
    return components;
  }

  void reloadData() {
    setState(() {
      widgetList = getComponents(context);
      maxIndex = widget.process.componentsNumber;
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

    setState(() {
      widgetList = getComponents(context);
      maxIndex = widget.process.componentsNumber;
    });
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
                    builder: (context) => AddComponent(process: widget.process, index: maxIndex)));
              },
              icon: const Icon(Icons.add)
            ),
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
                  future: widgetList,
                  builder: (context, snapshot) {
                    List<ProcessComponent> children = [ProcessComponent(id: "", widget: "error", index: 0, data: ['No data'], processID: '')];
                    if(snapshot.hasData) {
                      children = snapshot.data!;
                    } else if (snapshot.hasError) {
                      children = [
                        ProcessComponent(id: "", widget: 'error', index: 0, data: ['Result : ${snapshot.error}'], processID: '')
                      ];
                    }
                    return Center(
                      child: ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) async {
                          ProcessComponent component = ProcessComponent(
                              id: "",
                              widget: "",
                              index: 0,
                              data: [], processID: ''
                          );

                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            component = children.removeAt(oldIndex);
                            children.insert(newIndex, component);
                          });

                          if (component.id.isNotEmpty) {
                            await RemoteDatabase.getUserData()
                                .collection('ListProcess')
                                .doc(widget.process.id)
                                .collection('Components')
                                .doc(component.id).update({'componentIndex': newIndex});
                          }
                          reloadData();
                        },
                        children: children.map((component) {
                          return component.getListWidget(context);
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