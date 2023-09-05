import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/user_model.dart';
import 'package:khatabook/data/Firebase%20Data/user_data.dart';

class ProfileProvider with ChangeNotifier {
  String _name = " ";
  bool _nameLoading = false;
  UserModel _userModel = UserModel(total: 0, cost: 0);
  String _bussinessName = "";

  String get getName => _name;
  bool get getNameLoading => _nameLoading;
  UserModel get getUserModel => _userModel;
  String get getBussinessName => _bussinessName;

  void setBussinessName(String name) {
    _bussinessName = name;
    notifyListeners();
  }

  void setUserModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setNameLoading(bool value) {
    _nameLoading = value;
    notifyListeners();
  }

  void fetchName() async {
    setNameLoading(true);
    var email = FirebaseAuth.instance.currentUser!.email!;
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("user").doc(email).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      setName(data["name"]);
      setBussinessName(data["company_name"]);
      setNameLoading(false);
    } else {
      setName("User");
      setNameLoading(false);
    }
  }

  void fetchUserModel() async {
    final UserModel userModel = await UserData().getUserModel();
    setUserModel(userModel);
  }

  void addCompanyName(String name, BuildContext context) async {
    var mail = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(mail)
        .update({"company_name": name}).then((value) {
      Navigator.of(context).pop();
    }); // Remove the double quotes around "company_name"
  }

  Future<bool?> deleteUser(
      BuildContext context, String title, String content) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false when "No" is pressed.
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Return true when "Yes" is pressed.
              },
            ),
          ],
        );
      },
    );
  }
}
