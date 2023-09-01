import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/data/Firebase%20Data/book_data.dart';
import 'package:khatabook/data/Firebase%20Data/user_data.dart';

class HomePageProvider with ChangeNotifier {
  double _income = 0;
  double _expnese = 0;
  bool _isLoading = false;
  bool _balanceLoading = false;

  List<BookModel> _customers = [];

  double get getIncome => _income;
  double get getExpense => _expnese;
  List<BookModel> get getCustomerList => _customers;
  bool get getLoading => _isLoading;
  bool get getBalanceLoading => _balanceLoading;

  void setIncome(double value) {
    _income = value;
    notifyListeners();
  }

  void setExpense(double value) {
    _expnese = value;
    notifyListeners();
  }

  void setBalanceLoading(bool value) {
    _balanceLoading = value;
    notifyListeners();
  }

  Future<void> getBalance(BuildContext context) async {
    setBalanceLoading(true);
    _income = await UserData().calculateTotalBookSum(context);
    _expnese = await UserData().calculateTotalBookCost(context);
    setBalanceLoading(false);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setCustomerList(List<BookModel> value) {
    _customers.clear();
    _customers.addAll(value);
    _customers = _customers.toSet().toList();
    notifyListeners();
  }

  void fetchCustomerList() async {
    setLoading(true);
    try {
      List<BookModel> customerList = await UserData()
          .getAllCustomers()
          .timeout(const Duration(seconds: 10), onTimeout: () {
        GeneralUtils.showToast("Failed To Load Books, Try Again");
        setLoading(false);
        return [];
      });
      setLoading(false);
      setCustomerList(customerList);
    } catch (e) {
      setLoading(false);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void updateBookTotal(String bookId, double newTotal) {
    final bookIndex = _customers.indexWhere((book) => book.id == bookId);
    if (bookIndex != -1) {
      _customers[bookIndex].total = newTotal;
      notifyListeners();
    }
  }

  void updateBookCost(String bookId, double newCost) {
    final bookIndex = _customers.indexWhere((book) => book.id == bookId);
    if (bookIndex != -1) {
      _customers[bookIndex].cost = newCost;
      notifyListeners();
    }
  }

  void deleteBook(dynamic id) {
    try {
      StoreBookDataToUser().deleteBook(id).whenComplete(() {
        _customers.removeWhere((book) => book.id == id);
        notifyListeners(); // Moved inside the callback
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
