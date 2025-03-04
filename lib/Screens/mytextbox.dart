import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({
    Key? key,
    required this.ltxt,
    required this.rtxt,
    this.controller,
  }) : super(key: key);

  final String ltxt;
  final String rtxt;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
        labelText: ltxt,
        hintText: rtxt,
        floatingLabelBehavior: FloatingLabelBehavior.always, // or .always
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return rtxt;
        } else {
          return null;
        }
      },
    );
  }
}
