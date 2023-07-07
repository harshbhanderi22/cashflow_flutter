import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatabook/Utils/general_utils.dart';

class LoginProvider with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

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

  Future<bool> login(BuildContext context) async {
    setLoading(true);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, "home_screen");
      });

      setLoading(false);

      return true;
    } on FirebaseAuthException catch (e) {
      setLoading(false);

      if (e.code == 'user-not-found') {
        GeneralUtils.showWarningOrError("No user found for that email.");
        //print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        GeneralUtils.showWarningOrError(
            "Wrong password provided for that user.");
        //print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  void disposeController() {
    print("It Disposed");
    emailController.dispose();
    passwordController.dispose();
  }
}
