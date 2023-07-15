import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double? fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const CommonText(
      {super.key,
      required this.text,
      this.fontsize,
      this.fontWeight,
      this.color,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style:
          TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}