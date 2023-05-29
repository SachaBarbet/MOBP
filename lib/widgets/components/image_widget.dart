import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String url;

  const ImageComponent({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(url),
    );
  }
}