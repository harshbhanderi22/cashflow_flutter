import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';

class CreditDebitBox extends StatelessWidget {
  String label;
  String amount;
  IconData icon;
  CreditDebitBox({
    Key? key,
    required this.label,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: "₹ $amount",
                  fontsize: 18,
                  fontWeight: FontWeight.bold,
                ),
                CommonText(
                  text: label,
                  fontsize: 16,
                )
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
