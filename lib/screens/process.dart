import 'package:flutter/material.dart';

import '../models/process.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.process});
  final AppProcess process;

  @override
  State<StatefulWidget> createState() => _ProcessScreen();
}

class _ProcessScreen extends State<ProcessScreen> {
  Icon buttonIcon = const Icon(Icons.list);
  bool stateAddComponent = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF3D3B3C),
        body: Padding(
          padding: const EdgeInsets.only(top: 41, bottom: 15, left: 15, right: 15),
          child: Container(
            decoration: const BoxDecoration(color: Color(0xFF262525), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: ListView(
                children: const [Text("salut")],
              ),
            ),
          ),
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25, right: 8),
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFEAC435),
            onPressed: () {
              setState(() {
                if (stateAddComponent == false) {
                  buttonIcon = const Icon(Icons.close);
                  stateAddComponent = true;
                } else {
                  buttonIcon = const Icon(Icons.list);
                  stateAddComponent = false;
                }
              });
            },
            child: buttonIcon,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}