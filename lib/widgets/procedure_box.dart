import 'package:flutter/material.dart';

class ProcedureBox extends StatelessWidget {
  final String name;
  final String description;
  final String software;

  const ProcedureBox({required this.name, this.description = '', this.software = '', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Text(description, style: const TextStyle(color: Colors.white)),
          Text(software, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}