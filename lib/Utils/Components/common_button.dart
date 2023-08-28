// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/constant.dart';

class CommonButton extends StatelessWidget {
  Widget child;
  CommonButton({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 80),
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: blue),
        child: child);
  }
}

class CommonButtonText extends StatelessWidget {
  String label;
      CommonButtonText({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonText(
      text: label,
      fontsize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }
}
