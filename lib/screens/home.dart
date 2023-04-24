import 'package:flutter/material.dart';
import 'package:mobp/screens/add_proccess.dart';
import 'package:mobp/utilities/locale_database.dart';

import 'account.dart';
import 'auth.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  String state = LocaleDatabase.connected.toString();
  late List<Widget> widgetList;

  @override
  void initState() {
    super.initState();
    if (!LocaleDatabase.connected) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Login())));
    }
    reloadData();
  }

  void reloadData() {
    setState(() {
      state = LocaleDatabase.connected.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBP',
      home: Scaffold(
        backgroundColor: const Color(0xFF3D3B3C),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: widgetList,
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFEAC435),
          onPressed: () {
            reloadData();
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AddProcess()));
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          color: const Color(0xFF262525),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: IconButton(icon: const Icon(Icons.dashboard, color: Colors.white,), onPressed: (){},),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: IconButton(icon: const Icon(Icons.account_circle, color: Colors.white,), onPressed: () {
                  if (LocaleDatabase.connected) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const Account()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const Login()));
                  }
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}