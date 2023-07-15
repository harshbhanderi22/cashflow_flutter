import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  double _income = 20000;
  double _expnese = 15000;

  double get getIncome => _income;
  double get getExpense => _expnese;

  void setIncome(double value) {
    _income = value;
    notifyListeners();
  }

  void setExpense(double value) {
    _expnese = value;
    notifyListeners();
  }

  
}
