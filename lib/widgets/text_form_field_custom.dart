import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final int maxCharacters;

  const TextFormFieldCustom(this.hintText, this.validator, {super.key, this.maxCharacters = 512});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: TextFormField(
        maxLength: maxCharacters,
        maxLines: 1,
        cursorColor: Colors.orange,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
          hintText: hintText, hintStyle: const TextStyle(color: Colors.grey),
        ),
        validator: validator,
      ),
    );
  }
}