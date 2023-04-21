import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobp/screens/home.dart';
import 'package:mobp/utilities/authentication.dart';
import 'package:mobp/utilities/locale_database.dart';
import 'package:mobp/utilities/remote_database.dart';
import 'models/user.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocaleDatabase.initData();
  await RemoteDatabase.initData();
  await UserAuthentication.initAuth();
  await LocaleDatabase.setUser();
  if (User.login.isNotEmpty) {
    await UserAuthentication.signIn(User.login, User.password);
  }

  final currentUser = UserAuthentication.auth.currentUser;
  if (currentUser != null) {
    User.id = currentUser.uid;
    LocaleDatabase.connected = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MOBP',
      home: Home(),
    );
  }
}