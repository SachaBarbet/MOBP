import 'package:flutter/material.dart';
import 'package:mobp/utilities/authentication.dart';

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
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                TextButton(onPressed: () async {await UserAuthentication.signOut(); leaveAccountPage();}, child: const Text('Sign out'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}