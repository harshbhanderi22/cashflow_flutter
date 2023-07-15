import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData prefix;
  final IconData? suffix;
  final Function? onSuffixTap;
  final bool? obsecure;

  const CommonTextField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.prefix,
      this.suffix,
      this.onSuffixTap,
      this.obsecure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecure ?? false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 12),
          border: InputBorder.none,
          hintStyle: const TextStyle(fontSize: 14),
          prefixIcon: Icon(
            prefix,
            color: Colors.red.shade400,
          ),
          suffixIcon: InkWell(
            onTap: () {
              onSuffixTap!();
            },
            child: Icon(
              suffix,
              color: Colors.red.shade400,
            ),
          ),
          hintText: hint),
    );
  }
}
