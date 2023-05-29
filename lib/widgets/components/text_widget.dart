import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;

  const TextComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}