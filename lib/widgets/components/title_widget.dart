import 'package:flutter/material.dart';

class TitleComponent extends StatelessWidget {
  final String text;

  const TitleComponent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(text, style: const TextStyle(
            fontSize: 32,
            color: Colors.white
        ))
      ),
    );
  }
}