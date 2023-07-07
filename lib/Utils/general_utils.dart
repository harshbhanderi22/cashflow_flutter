import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GeneralUtils {
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showWarningOrError(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
