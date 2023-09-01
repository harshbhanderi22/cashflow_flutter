// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/balance_card.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:provider/provider.dart';

import 'package:khatabook/Utils/Components/book_card.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Components/homepage_floating.dart';
import 'package:khatabook/Utils/Routes/Arguments/transaction_list_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name = "User";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomePageProvider>(context, listen: false).fetchCustomerList();
      Provider.of<HomePageProvider>(context, listen: false).getBalance(context);
    });
    getName();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomePageProvider>(context, listen: false).fetchCustomerList();
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                // Consumer<HomePageProvider>(builder: (context, value, child) {
                //   return Text(
                //     "₹ ${value.getIncome - value.getExpense}",
                //     style: const TextStyle(
                //         fontSize: 24, fontWeight: FontWeight.bold),
                //   );
                // })
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: CommonText(
                    text: name[0].toUpperCase(),
                    fontsize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   height: 130,
            //   width: double.infinity,
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: Container(
            //           padding: const EdgeInsets.all(12.0),
            //           margin: const EdgeInsets.symmetric(vertical: 8.0),
            //           decoration: BoxDecoration(
            //               color: Colors.green.withOpacity(0.3),
            //               borderRadius: BorderRadius.circular(12.0)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               const CircleAvatar(
            //                 radius: 15.0,
            //                 backgroundColor: Colors.white,
            //                 child: Icon(
            //                   Icons.arrow_downward,
            //                   color: Colors.green,
            //                 ),
            //               ),
            //               Expanded(child: Container()),
            //               Consumer<HomePageProvider>(
            //                   builder: (context, value, child) {
            //                 return Text(
            //                   "₹ ${value.getIncome}",
            //                   style: const TextStyle(
            //                       fontSize: 18,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w700),
            //                 );
            //               }),
            //               const SizedBox(height: 3),
            //               Text(
            //                 "Your Income",
            //                 style: TextStyle(
            //                     fontSize: 14,
            //                     color: Colors.black.withOpacity(0.7),
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 12.0,
            //       ),
            //       Expanded(
            //         child: Container(
            //           padding: const EdgeInsets.all(12.0),
            //           margin: const EdgeInsets.symmetric(vertical: 8.0),
            //           decoration: BoxDecoration(
            //               color: Colors.red.withOpacity(0.3),
            //               borderRadius: BorderRadius.circular(12.0)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               const CircleAvatar(
            //                 radius: 15.0,
            //                 backgroundColor: Colors.white,
            //                 child: Icon(
            //                   Icons.arrow_upward,
            //                   color: Colors.red,
            //                 ),
            //               ),
            //               Expanded(child: Container()),
            //               Consumer<HomePageProvider>(
            //                   builder: (context, value, child) {
            //                 return Text(
            //                   "₹ ${value.getExpense}",
            //                   style: const TextStyle(
            //                       fontSize: 18,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w700),
            //                 );
            //               }),
            //               const SizedBox(height: 3),
            //               Text(
            //                 "Your Expense",
            //                 style: TextStyle(
            //                     fontSize: 14,
            //                     color: Colors.black.withOpacity(0.7),
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
             Consumer<HomePageProvider>(builder: (context, value, child) {
              return value.getBalanceLoading
                  ? Container(
                      height: 200,
                      width: GeneralUtils.getWidth(context),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    )
                  : BalanceCard(
                      label: "Net Balance",
                      net: value.getIncome - value.getExpense,
                      income: value.getIncome,
                      expense: value.getExpense);
            }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Books",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: Consumer<HomePageProvider>(
                    builder: (context, value, child) {
                  if (value.getLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (value.getCustomerList.isEmpty) {
                      return const Center(
                        child: CommonText(text: "No Books Avaliable"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: value.getCustomerList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  RouteNames.transactionList,
                                  arguments: TransactionListArgument(
                                      bookModel: value.getCustomerList[index]));
                            },
                            child: BookCard(
                              bookModel: value.getCustomerList[index],
                            ),
                          );
                        },
                      );
                    }
                  }
                })),
          ],
        ),
      ),
      floatingActionButton: const HomePageFlotingButton(),
    ));
  }
}
