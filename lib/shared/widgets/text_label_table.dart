import 'package:flutter/material.dart';

class TextLabelTable extends StatelessWidget {
  final String texto;
  const TextLabelTable({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 11.5),
      ),
    );
  }
}
