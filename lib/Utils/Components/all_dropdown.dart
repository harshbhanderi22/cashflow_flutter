import 'package:flutter/material.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';

class IncomeDropDown extends StatelessWidget {
  const IncomeDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
        builder: (context, value, child) {
      return DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            elevation: 0,
            value: value.getSelectedIncome,
            hint: const Text("Select Income Category"),
            alignment: AlignmentDirectional.bottomCenter,

            // disabledHint: Text("Set Income Category"),
            items: List.generate(value.getIncomeCategory.length,
                (index) {
              return DropdownMenuItem(
                  value: index,
                  child: Text(value.getIncomeCategory[index]));
            }),
            onChanged: (val) {
              value.setIncome(val!);
            }),
      );
    });
  }
}

class ExpenseDropDown extends StatelessWidget {
  const ExpenseDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(
        builder: (context, value, child) {
      return DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            elevation: 0,
            value: value.getSelectedExpense,
            hint: const Text("Select Expense Category"),
            alignment: AlignmentDirectional.bottomCenter,
            // disabledHint: Text("Set Income Category"),
            items: List.generate(value.getExpenseCategory.length,
                (index) {
              return DropdownMenuItem(
                  value: index,
                  child: Text(value.getExpenseCategory[index]));
            }),
            onChanged: (val) {
              value.setExpense(val!);
            }),
      );
    });
  }
}