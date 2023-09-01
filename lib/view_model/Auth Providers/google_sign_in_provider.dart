import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:khatabook/Models/user_model.dart';
import 'package:khatabook/data/Firebase%20Data/user_data.dart';

class GoogleSingInProivder extends ChangeNotifier {
  final googlesignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn(BuildContext context) async {
    final googleuser = await googlesignin.signIn();
    if (googleuser == null) {
      return;
    }
    _user = googleuser;

    final googleauth = await googleuser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken: googleauth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      UserModel userModel = UserModel(
        total: 0,
        cost: 0,
          name: FirebaseAuth.instance.currentUser!.displayName,
          email: FirebaseAuth.instance.currentUser!.email,
          image: FirebaseAuth.instance.currentUser!.photoURL);
      UserData().addUser(
          userModel.toMap(), "user", FirebaseAuth.instance.currentUser!.email);
      Navigator.pushReplacementNamed(context, "home_screen");
    });

    notifyListeners();
  }

  Future googleLogOut() async {
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
