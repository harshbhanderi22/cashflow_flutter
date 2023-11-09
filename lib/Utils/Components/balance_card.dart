import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Components/credit_debit_box.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';

class BalanceCard extends StatelessWidget {
  String label;
  double net;
  double income;
  double expense;
    BalanceCard({
    Key? key,
    required this.label,
    required this.net,
    required this.income,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GeneralUtils.getWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            CommonText(
            text: label,
            color: Colors.white,
            fontsize: 16,
            fontWeight: FontWeight.w400,
          ),
          CommonText(
            text: "₹ ${income-expense}",
            fontsize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CreditDebitBox(
                label: "Credit",
                amount: income.round().toString(),
                icon: Icons.arrow_upward,
              ),
              const SizedBox(
                width: 10,
              ),
              CreditDebitBox(
                label: "Debit",
                amount:expense.round().toString(),
                icon: Icons.arrow_downward,
              ),
            ],
          )
        ],
      ),
    );
  }
}
