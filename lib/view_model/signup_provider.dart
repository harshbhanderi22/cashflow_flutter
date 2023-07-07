import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/general_utils.dart';

class SignupProvider with ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get nameController => _nameController;
  TextEditingController get confirmController => _confirmController;

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

  Future<void> Signup(BuildContext context) async {
    setLoading(true);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, "home_screen");
      });

      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'weak-password') {
        GeneralUtils.showWarningOrError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        GeneralUtils.showWarningOrError(
            'The account already exists for that email.');
      }
    }
  }

  

  Future<void> SignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
