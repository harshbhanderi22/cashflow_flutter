import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransactionListProvider with ChangeNotifier {
  String _time = "";
  String _date = "";
  int _selectedIncome = 0;
  int _selectedExpense = 0;
  List<String> _incomeCategoryList = [
    "Product Sales",
    "Service Revenue",
    "Consultancy Services",
    "Subscription Payments",
    "Fees",
    "Royalties",
    "Commission",
    "Refunds",
    "Other"
  ];

  List<String> _expenseCategoryList = [
    "Purchase Costs",
    "Shipping and Delivery",
    "Employee Salaries",
    "Marketing Expenses",
    "Maintenance Costs",
    "Rent",
    "Utilities",
    "Insurance",
    "Taxes",
    "Other"
  ];

  String get getDate => _date;
  String get getTime => _time;
  List get getIncomeCategory => _incomeCategoryList;
  List get getExpenseCategory => _expenseCategoryList;
  int get getSelectedIncome => _selectedIncome;
  int get getSelectedExpense => _selectedExpense;

  void setIncome(int value) {
    _selectedIncome = value;
    notifyListeners();
  }

  void setExpense(int value) {
    _selectedExpense = value;
    notifyListeners();
  }

  void setTime(String value) {
    _time = value;
  }

  void setDate(String value) {
    _date = value;
  }
}
