// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/user_model.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/data/Firebase%20Data/user_data.dart';

class SignupProvider with ChangeNotifier {
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

  void validateRegisterDetailsAndRegister(
      String name, String email, String password, String confirmPassword) {
    if (name.isEmpty) {
      GeneralUtils.showToast(nameValidation);
    } else if (email.isEmpty) {
      GeneralUtils.showToast(emailValidation);
    } else if (GeneralUtils().checkValidEmail(email) == false) {
      GeneralUtils.showToast(inValidEmailValidation);
    } else if (password.isEmpty) {
      GeneralUtils.showToast(passwordValidation);
    } else if (password.length < 8) {
      GeneralUtils.showToast(passwordLengthValidation);
    } else if (confirmPassword.isEmpty) {
      GeneralUtils.showToast(confirmPasswordValidation);
    } else if (confirmPassword != password) {
      GeneralUtils.showToast(passwordNotMatchValidation);
    } else {
      registerUser(email, password);
      UserModel userModel = UserModel(
          name: FirebaseAuth.instance.currentUser!.displayName ?? name,
          email: FirebaseAuth.instance.currentUser!.email ?? email,
          image: FirebaseAuth.instance.currentUser!.photoURL);
      UserData().addUser(userModel.toMap(), "user", email);
    }
  }

  Future<void> registerUser(String email, String password) async {
    setLoading(true);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        GeneralUtils.showToast("User Created Successfully 🎉🎉");
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'weak-password') {
        GeneralUtils.showToast(
            'Your password lacks strength. Please choose a stronger one.');
      } else if (e.code == 'email-already-in-use') {
        GeneralUtils.showToast(
            'Account already exists. Please choose a different email address.');
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
