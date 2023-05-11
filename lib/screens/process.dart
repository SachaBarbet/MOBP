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
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text("Ajout de stock", style: TextStyle(fontSize: 32, color: Colors.white),),
                      ),
                    ),
                    Container(
                      height: 2,
                      decoration: const BoxDecoration(color: Color(0xFF3D3B3C)),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("1. Lancer l'ERP", style: TextStyle(color: Colors.red, fontSize: 22),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text("- Lancer la connection TSE avec vos identifiants", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text("- Ouvrir l'ERP", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("2. Ouvrir l'outil de stock", style: TextStyle(color: Colors.red, fontSize: 22),),
                    ),
                    const Image(
                        image: AssetImage('assets/images/process_exp1.png')
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("3. Saisir les données", style: TextStyle(color: Colors.red, fontSize: 22),),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text("- saisir l'article", style: TextStyle(color: Colors.white, fontSize: 18),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text("- saisir l'emplacement", style: TextStyle(color: Colors.white, fontSize: 18),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text("- saisir la quantité", style: TextStyle(color: Colors.white, fontSize: 18),),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("4. Valider et vérifier le mouvement de stock", style: TextStyle(color: Colors.red, fontSize: 22),),
                    ),
                  ],
                ),
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