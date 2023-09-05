import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';

class ActionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;
  const ActionWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
          ),
          const SizedBox(
            height: 10,
          ),
          CommonText(
            text: label,
            fontsize: 16,
          )
        ],
      ),
    );
  }
}
