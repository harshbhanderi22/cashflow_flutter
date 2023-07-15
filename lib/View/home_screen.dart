import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Cash Flow"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.red.shade400,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 75,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 10),
                                color: Colors.black38,
                                blurRadius: 15)
                          ],
                          color: Colors.green.shade400,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Income",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Text(
                              "10000 \$",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ]),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 10),
                                color: Colors.black38,
                                blurRadius: 15)
                          ],
                          color: Colors.red.shade400,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(children: const [
                        Text(
                          "Expense",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "10000 \$",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      ]),
                    )),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Account Books",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shubham",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text("Cash"),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "500",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Balance: 500")
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Text("Edit By You at 10:39 AM")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
