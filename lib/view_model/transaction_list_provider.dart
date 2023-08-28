import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/data/Firebase%20Data/transaction_data.dart';

class TransactionListProvider with ChangeNotifier {
  String _time = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
  String _date =
      "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";
  int _selectedIncome = 0;
  int _selectedExpense = 0;
  int _selectedOption = 0;
  bool _loading = false;
  List _transactions = [];
  bool _fetchLoading = false;

  final List<String> _incomeCategoryList = [
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

  final List<String> _expenseCategoryList = [
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
  int get getSelectedOption => _selectedOption;
  bool get getLoading => _loading;
  bool get getFetchLoading => _fetchLoading;
  List get getTransactions => _transactions;

  void setTransactionList(List<TransactionModel> value) {
    _transactions.clear();
    _transactions.addAll(value);
    _transactions = _transactions.toSet().toList();
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setFetchLoading(bool value) {
    _fetchLoading = value;
    notifyListeners();
  }

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners();
  }

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
    notifyListeners();
  }

  void setDate(String value) {
    _date = value;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) setDate("${picked.day}/${picked.month}/${picked.year}");
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setTime("${picked.hour}:${picked.minute}");
    }
  }

  void fetchTransactions(String id) async {
    setFetchLoading(true);

    try {
      List<TransactionModel> transactionList = await TransactionData()
          .getAllTransactions(id)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        GeneralUtils.showToast("Failed To Load Transactions, Try Again");
        setLoading(false);
        return [];
      });
      setFetchLoading(false);
      setTransactionList(transactionList);
    } catch (e) {
      setFetchLoading(false);

      if (kDebugMode) {
        print(e);
      }
    }
  }
}
