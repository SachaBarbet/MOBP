import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({super.key, required this.connected});
  bool connected;

  String

  @override
  State<StatefulWidget> createState() => _Account();
}

class _Account extends State<Account> {
  @override
  Widget build(BuildContext context) {

    MaterialApp output = MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(data)
            ],
          ),
        ),
      ),
    );
    if (!widget.connected) {
      output = MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                Container(),
              ],
            ),
          ),
        ),
      );
    }

    return output;
  }

}