import 'package:flutter/material.dart';

class ProcessComponent {
  late String name;
  late List<String> date;
  late Widget component;

  Widget getWidget() {
    return component;
  }
}