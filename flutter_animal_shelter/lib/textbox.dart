import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  TextBox(this.controller, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
            filled: true,
            labelText: this.label,
            suffix: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                controller.clear();
              },
            )),
      ),
    );
  }
}
