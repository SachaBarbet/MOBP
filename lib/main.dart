import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobp/app.locator.dart';
import 'firebase_options.dart';

import 'widgets/pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  setupLocator();
  runApp(const MOBP());
}

class MOBP extends StatelessWidget {
  const MOBP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBP',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
        inputDecorationTheme: const InputDecorationTheme(),
      ),
      home: const HomePage(),
    );
  }
}