import 'package:flutter/material.dart';

class CommonFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? inputType;

  const CommonFormField(
      {super.key, required this.controller, required this.hint,this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        cursorColor: Colors.grey,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
