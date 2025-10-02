import 'package:flutter/material.dart';

class Textformfeild extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const Textformfeild({super.key, required this.controller, required this.multiLines, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              maxLines: multiLines ? 6 :1,
              minLines: multiLines ? 6 :1,
              controller: controller,
              validator: (value) =>
                  value!.isEmpty ? "$name can't be empty" : null,
              decoration: InputDecoration(hintText: name),
            ),
          );
  }
}