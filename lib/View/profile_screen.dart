// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text_field.dart';
import 'package:khatabook/Utils/Components/setting_row.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/Auth%20Providers/signup_provider.dart';
import 'package:provider/provider.dart';

import 'package:khatabook/Utils/Components/action_widget.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/view_model/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "User";
  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    var email = FirebaseAuth.instance.currentUser!.email!;
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("user").doc(email).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      name = data['name'];
    }
  }

  final TextEditingController _companyName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const CommonText(
              text: "Profile",
              fontsize: 24,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ProfileProvider>(builder: (context, value, child) {
                    return Center(
                      child: Column(
                        children: [
                          Hero(
                            tag: "profile",
                            child: CircleAvatar(
                              radius: 72,
                              backgroundColor: blue,
                              child: value.getNameLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : CommonText(
                                      text: value.getName[0].toUpperCase(),
                                      fontsize: 72,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          value.getNameLoading
                              ? const Center(
                                  child: CommonText(
                                    text: "Fetching..",
                                    fontsize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : CommonText(
                                  text: value.getName,
                                  fontsize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonText(
                            text: value.getBussinessName,
                            fontsize: 18,
                            //fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ActionWidget(
                                icon: CupertinoIcons.star,
                                label: "Rate App",
                                onTap: () {},
                              ),
                              ActionWidget(
                                icon: Icons.share,
                                label: "Share App",
                                onTap: () {},
                              ),
                              Consumer<SignupProvider>(
                                  builder: (context, value, child) {
                                return ActionWidget(
                                  icon: Icons.logout,
                                  label: "Log Out",
                                  onTap: () {
                                    value.signOut();
                                  },
                                );
                              })
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  const CommonText(
                    text: "Settings",
                    fontsize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      SettingsRow(
                        icon: Icons.category,
                        label: "Add Income Category",
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.category,
                        label: "Add Expense Category",
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.business,
                        label: "Add Business Name",
                        onTap: () {
                          _openDialog(context);
                        },
                      ),
                      SettingsRow(
                        icon: Icons.app_registration,
                        label: "App Guide",
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.developer_board,
                        label: "Developer Contact",
                        onTap: () {},
                      ),
                      SettingsRow(
                        icon: Icons.coffee,
                        label: "Buy Me a Coffee",
                        onTap: () {
                          GeneralUtils.showToast("Coming Soon");
                        },
                      ),
                      Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                        return SettingsRow(
                            label: "Delete Account",
                            onTap: () {
                              // FirebaseAuth.instance.currentUser!.delete();
                              value.deleteUser(
                                  context,
                                  "Are You Sure to delete Account? ",
                                  "content");
                            },
                            icon: Icons.delete);
                      })
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Bussiness Name"),
          content: CommonTextField(
              hint: "Enter Bussiness Name",
              controller: _companyName,
              prefix: Icons.business_center),
          actions: <Widget>[
            Consumer<ProfileProvider>(builder: (context, value, child) {
              return TextButton(
                onPressed: () {
                  value.addCompanyName(_companyName.text, context);
                  // Access the text entered in the dialog here using _textController.text
                  //String enteredText = _companyName.text;
                  // You can do something with the entered text here.
                },
                child: const Text("Submit"),
              );
            })
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _companyName.dispose();
  }
}
