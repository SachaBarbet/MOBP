import 'package:flutter/material.dart';
import 'package:mobp/utilities/authentication.dart';

import '../models/user.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<StatefulWidget> createState() => _Account();
}

class _Account extends State<Account> {

  void leaveAccountPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF262525),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
          child: Center(
            child: Column(
              children: [
                Text(AppUser.name),
                Text(AppUser.id),
                TextButton(onPressed: () async {await UserAuthentication.signOut(); leaveAccountPage();}, child: const Text('Update')),
                TextButton(onPressed: () async {await UserAuthentication.signOut(); leaveAccountPage();}, child: const Text('Sign out'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}