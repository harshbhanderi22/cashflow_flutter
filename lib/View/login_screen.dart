import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text_field.dart';
import 'package:khatabook/Utils/Components/login_method_circle.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/google_sign_in_provider.dart';
import 'package:khatabook/view_model/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.red.shade900,
                Colors.red.shade800,
                Colors.red.shade400
              ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    height: GeneralUtils.getHeight(context) * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 40,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(255, 68, 44, 0.294),
                                    blurRadius: 15,
                                    offset: Offset(0, 10))
                              ],
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Column(
                            children: [
                              Consumer<LoginProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Enter Email",
                                  prefix: Icons.email,
                                  controller: value.emailController,
                                );
                              }),
                              const Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Consumer<LoginProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Enter Password",
                                  obsecure: value.isPasswordVisible,
                                  prefix: Icons.lock,
                                  controller: value.passwordController,
                                  onSuffixTap: () {
                                    value.setPasswordVisiblity(
                                        !value.isPasswordVisible);
                                  },
                                  suffix: value.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Consumer<LoginProvider>(
                            builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              if (value.emailController.text.isEmpty) {
                                GeneralUtils.showToast("Email cannot be empty");
                              } else if (value
                                  .passwordController.text.isEmpty) {
                                GeneralUtils.showToast(
                                    "Password cannot be empty");
                              } else {
                                value.login(context);
                              }
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30),
                                  ),
                                  color: Colors.red.shade600),
                              child: Center(
                                child: value.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<GoogleSingInProivder>(
                                builder: ((context, value, child) {
                              return LoginMethodCircle(
                                path: "assests/images/google.png",
                                onTap: () {
                                  value.googleLogIn(context);
                                },
                              );
                            })),
                            const SizedBox(
                              width: 20,
                            ),
                            LoginMethodCircle(
                              path: "assests/images/facebook2.png",
                              onTap: () {
                                GeneralUtils.showToast("Coming Soon");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have an Account? "),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "signup_screen");
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.red.shade600),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )));
  }
}
