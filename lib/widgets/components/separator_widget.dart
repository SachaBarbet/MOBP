import 'package:flutter/material.dart';

class SeparatorComponent extends StatelessWidget {
  const SeparatorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      decoration: const BoxDecoration(color: Color(0xFF3D3B3C)),
    );
  }
}