import 'package:flutter/material.dart';

import 'component.dart';

class AppProcess {
  late String id;
  late String name;
  late String description;
  late String folderID;
  late List<ProcessComponent> components;

  AppProcess({
    required this.id,
    required this.name,
    required this.description,
    required this.folderID
  });

  Widget getWidget() {
    List<Widget> listWidget = [];
    for (var value in components) {
      listWidget.add(value.getWidget());
    }
    return ListView(
      children: listWidget,
    );
  }
}