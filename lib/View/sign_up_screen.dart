import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text_field.dart';
import 'package:khatabook/Utils/Components/other_signin_method.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/Auth%20Providers/signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [darkBlue, blue, lightBlue])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  height: GeneralUtils.getHeight(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Streamline Your Finances with Us",
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
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
                                    color: Color.fromRGBO(34, 30, 255, 0.286),
                                    blurRadius: 15,
                                    offset: Offset(0, 10))
                              ],
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Column(
                            children: [
                              Consumer<SignupProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Enter Name",
                                  prefix: Icons.person,
                                  controller: _nameController,
                                );
                              }),
                              const Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Consumer<SignupProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Enter Email",
                                  prefix: Icons.email,
                                  controller: _emailController,
                                );
                              }),
                              const Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Consumer<SignupProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Enter Password",
                                  prefix: Icons.lock,
                                  controller: _passwordController,
                                );
                              }),
                              const Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Consumer<SignupProvider>(
                                  builder: (context, value, child) {
                                return CommonTextField(
                                  hint: "Confirm Password",
                                  obsecure: value.isPasswordVisible,
                                  prefix: Icons.lock,
                                  controller: _confirmController,
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
                        // const SizedBox(
                        //   height: 40,
                        // ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: const Text(
                        //     "Forgot Password?",
                        //     style: TextStyle(fontSize: 14, color: Colors.grey),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        Consumer<SignupProvider>(
                            builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              value.validateRegisterDetailsAndRegister(
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _confirmController.text);
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
                                  color: blue),
                              child: Center(
                                child: value.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Sign Up",
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
                        const OtherLoginMethod(),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already Have an Account? "),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "login_screen");
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(color: blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
