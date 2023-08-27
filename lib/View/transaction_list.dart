// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Components/transaction_floating.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class TransactionListScreen extends StatefulWidget {
  BookModel bookModel;
  TransactionListScreen({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  TransactionModel transactionModel = TransactionModel(
      title: "First Income",
      category: "Salary",
      cost: "0",
      total: "75000",
      date: "01-01-2023",
      time: "12:00",
      id: "010120231200");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("${widget.bookModel.name}'s Book"),
      ),
      floatingActionButton: const TransactionFloating(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Net Balance",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Consumer<TransactionListProvider>(
                    builder: (context, value, child) {
                  return const Text(
                    "₹ 5000",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 130,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            ),
                          ),
                          Expanded(child: Container()),
                          Consumer<TransactionListProvider>(
                              builder: (context, value, child) {
                            return const Text(
                              "₹ 10000",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            );
                          }),
                          const SizedBox(height: 3),
                          Text(
                            "Credit",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),
                          ),
                          Expanded(child: Container()),
                          Consumer<TransactionListProvider>(
                              builder: (context, value, child) {
                            return const Text(
                              "₹ 5000",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            );
                          }),
                          const SizedBox(height: 3),
                          Text(
                            "Debt",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Transactions",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: GeneralUtils.getWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 5,
                        offset: Offset(5, 2))
                  ],
                  color: Colors.grey.shade100),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: GeneralUtils.getWidth(context) / 3,
                            height: 20,
                            child: CommonText(
                              text: transactionModel.title,
                              fontsize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          CommonText(
                            text: transactionModel.category,
                            fontsize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              CommonText(
                                text: transactionModel.date,
                                fontsize: 12,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              const Icon(CupertinoIcons.clock, size: 16),
                              const SizedBox(
                                width: 4,
                              ),
                              CommonText(
                                text: transactionModel.time,
                                fontsize: 12,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: transactionModel.total.toString(),
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontsize: 18,
                        )
                      ],
                    ),
                  ),
                  PopupMenuButton(
                      position: PopupMenuPosition.under,
                      child: const Icon(Icons.more_vert),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 1,
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text("Delete"),
                          ),
                        ];
                      })
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
