// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _passwordVisible = true;

  bool get isPasswordVisible => _passwordVisible;

  void setPasswordVisiblity(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }

  void validateLoginDetailsAndLogin(String email, String password, BuildContext context) {
    if (email.isEmpty) {
      GeneralUtils.showToast(emailValidation);
    } else if (GeneralUtils().checkValidEmail(email) == false) {
      GeneralUtils.showToast(inValidEmailValidation);
    } else if (password.isEmpty) {
      GeneralUtils.showToast(passwordValidation);
    } else if (password.length < 8) {
      GeneralUtils.showToast(passwordLengthValidation);
    } else {
      loginUser(email, password,context);
    }
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      final credential = FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        GeneralUtils.showToast("You Logged In Successfully");
        Navigator.pushReplacementNamed(context, RouteNames.home);
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      if (e.code == 'user-not-found') {
        GeneralUtils.showToast("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        GeneralUtils.showToast("Wrong password provided for that user.");
      }
    }
  }
}
