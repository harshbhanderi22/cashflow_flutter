// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:khatabook/Helper/pdf_helper.dart';

import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Utils/Components/balance_card.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Components/transaction_card.dart';
import 'package:khatabook/Utils/Components/transaction_floating.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/profile_provider.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';

class TransactionListScreen extends StatefulWidget {
  final BookModel bookModel;
  const TransactionListScreen({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  double total = 0;
  double cost = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionListProvider>(context, listen: false)
          .fetchTransactions(widget.bookModel.id);
      Provider.of<TransactionListProvider>(context, listen: false)
          .getBalance(widget.bookModel.id, context);
      Provider.of<ProfileProvider>(context, listen: false).fetchUserModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: TransactionFloating(
        bookModel: widget.bookModel,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CommonText(
                      text: "${widget.bookModel.name}'s Book",
                      fontsize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Consumer<TransactionListProvider>(
                    builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                       PdfHelper().generateTransactionPdf(
                          value.getTransactions,
                          Provider.of<ProfileProvider>(context, listen: false)
                              .getUserModel, widget.bookModel, Provider.of<ProfileProvider>(context,listen: false).getBussinessName);
                    },
                    child: const Icon(
                      Icons.print,
                      size: 28,
                    ),
                  );
                })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<TransactionListProvider>(builder: (context, value, child) {
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
                      label: "${widget.bookModel.name}'s Book",
                      net: value.getTotalIncome - value.getTotalCost,
                      income: value.getTotalIncome,
                      expense: value.getTotalCost);
            }),
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
            Expanded(
                flex: 1,
                child: Consumer<TransactionListProvider>(
                    builder: (context, value, child) {
                  if (value.getLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (value.getTransactions.isEmpty) {
                      return const Center(
                        child: CommonText(text: "No Transaction Avaliable"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: value.getTransactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionCard(
                            transactionModel: value.getTransactions[index],
                            onDelete: () {
                              value.deleteTransaction(widget.bookModel.id,
                                  value.getTransactions[index].id, context);
                            },
                          );
                        },
                      );
                    }
                  }
                })),
          ],
        ),
      ),
    ));
  }
}
