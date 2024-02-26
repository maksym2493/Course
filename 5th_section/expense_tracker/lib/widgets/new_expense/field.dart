import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  const Field(this.text, this.controler,
      {super.key, this.maxLength, this.prefix});

  final int? maxLength;
  final String? prefix;

  final String text;
  final TextEditingController controler;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controler,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixText: prefix,
        label: Text(text),
      ),
    );
  }
}
