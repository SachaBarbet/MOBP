import 'package:flutter/material.dart';

class ListElementComponent extends StatelessWidget {
  final String text;

  const ListElementComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(text),
    );
  }
}