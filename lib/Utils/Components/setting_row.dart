import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';

class SettingsRow extends StatelessWidget {
  final String label;
  final Function onTap;
  final IconData icon;
  const SettingsRow({
    Key? key,
    required this.label,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                CommonText(
                  text: label,
                  fontsize: 18,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 10,
          color: Colors.black,
        ),
      ],
    );
  }
}
