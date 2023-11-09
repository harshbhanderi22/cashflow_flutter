// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khatabook/Models/user_model.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
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

  void validateRegisterDetailsAndRegister(String name, String email,
      String password, String confirmPassword, BuildContext context) {
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
      registerUser(email, password, name, context);
    }
  }

  Future<void> registerUser(
      String email, String password, String name, BuildContext context) async {
    setLoading(true);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setLoading(false);
        UserModel userModel = UserModel(
            total: 0,
            cost: 0,
            name: name,
            email: FirebaseAuth.instance.currentUser!.email ?? email,
            image: FirebaseAuth.instance.currentUser!.photoURL);
        UserData().addUser(userModel.toMap(), "user", email);
        GeneralUtils.showToast("User Created Successfully 🎉🎉");
        Navigator.of(context).pushReplacementNamed(RouteNames.home);
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

  Future<void> signOut(BuildContext context) async {
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;
    final googlesignin = GoogleSignIn();

// Check if the user is logged in
    if (user != null) {
      // Get the authentication provider
      final String provider = user.providerData[0].providerId;
      //print(user.providerData);
      //GeneralUtils.showToast(provider);
      //print(provider);
      GeneralUtils.showToast("We Are Signing You Out. Please Wait..");

      // Check if the authentication provider is email and password
      if (provider == 'password') {
        await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacementNamed(context, RouteNames.signUp);

        });

        // The user is logged in with email and password
      } else if (provider == 'google.com') {
        // The user is logged in with Google
        await googlesignin.disconnect();
        await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacementNamed(context, RouteNames.signUp);

        });
      }
    }
  }

  Future<void> deleteUser() async {

      final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      // Get the currently signed-in user
      User? user = _auth.currentUser;

      if (user != null) {
        // Delete the user
        await user.delete();

        // Sign out the user after deletion (optional)
        await _auth.signOut();
      } else {
        // Handle the case where there's no signed-in user
        print("No user is currently signed in.");
      }
    } catch (e) {
      // Handle any errors that occur during user deletion
      print("Error deleting user: $e");
    }
  }

}
