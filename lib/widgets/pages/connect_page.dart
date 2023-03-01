import 'package:flutter/material.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBP - Connection',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Color(0xFF13131D)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('MOBP', style: TextStyle(color: Colors.orange, fontSize: 32.0)),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Continuer en mode hors ligne...', style: TextStyle(color: Colors.orange),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}