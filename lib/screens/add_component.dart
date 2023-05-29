import 'package:flutter/material.dart';
import 'package:mobp/screens/components/add_image.dart';
import 'package:mobp/screens/components/add_subtitle.dart';
import 'package:mobp/screens/components/add_text.dart';
import 'package:mobp/screens/components/add_title.dart';

import '../models/process.dart';
import '../utilities/remote_database.dart';


class AddComponent extends StatefulWidget {
  final AppProcess process;
  final int index;

  const AddComponent({super.key, required this.process, required this.index});

  @override
  State<StatefulWidget> createState() => _AddComponent();
}

class _AddComponent extends State<AddComponent> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> addSeparator() async {
    await RemoteDatabase.getUserData().collection('ListProcess')
        .doc(widget.process.id).collection('Components')
        .add({'componentIndex': 0, 'componentWidget': 'separator', 'data': []});
  }

  Future<void> addList() async {
    await RemoteDatabase.getUserData().collection('ListProcess')
        .doc(widget.process.id).collection('Components')
        .add({'componentIndex': 0, 'componentWidget': 'list', 'data': []});
  }

  @override
  Widget build(BuildContext context) {

    const int boxColor = 0xFF3D3B3C;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF262525),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEAC435),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Add a component', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 30, bottom: 30),
          child: Center(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(boxColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Text Component', style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => AddTextComponent(processID: widget.process.id, index: widget.index)));
                            },
                            icon: const Icon(Icons.add, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(boxColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Image Component', style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddImageComponent(processID: widget.process.id, index: widget.index)));
                              },
                              icon: const Icon(Icons.add, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(boxColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Title Component', style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddTitleComponent(processID: widget.process.id, index: widget.index)));
                              },
                              icon: const Icon(Icons.add, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(boxColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Subtitle Component', style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddSubtitleComponent(processID: widget.process.id, index: widget.index)));
                              },
                              icon: const Icon(Icons.add, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(boxColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Separator Component', style: TextStyle(color: Colors.white,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () async {
                                await addSeparator();
                              },
                              icon: const Icon(Icons.add, color: Colors.white,)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
