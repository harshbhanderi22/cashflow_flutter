import 'package:flutter/material.dart';

class LoginMethodCircle extends StatelessWidget {
  final String path;
  final Function onTap;

  const LoginMethodCircle({super.key, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.red.shade200,
            width: 2.0,
          ),
        ),
        child: ClipOval(
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Image.asset(
              path,
              height: 20,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
