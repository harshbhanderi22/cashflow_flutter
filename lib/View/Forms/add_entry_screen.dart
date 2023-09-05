// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/Utils/Components/all_dropdown.dart';
import 'package:khatabook/Utils/Components/all_selecters.dart';
import 'package:khatabook/Utils/Components/common_button.dart';
import 'package:khatabook/Utils/Components/common_form_field.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';

class AddEntryScreen extends StatefulWidget {
  BookModel bookModel;
  AddEntryScreen({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  final TextEditingController _recieved = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Consumer<TransactionListProvider>(
                        builder: (context, value, child) {
                      return Radio(
                          activeColor: lightBlue,
                          value: 0,
                          groupValue: value.getSelectedOption,
                          onChanged: (val) {
                            value.setSelectedOption(0);
                          });
                    }),
                    const CommonText(fontsize: 16, text: "Revenue"),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Consumer<TransactionListProvider>(
                        builder: (context, value, child) {
                      return Radio(
                          activeColor: lightBlue,
                          value: 1,
                          groupValue: value.getSelectedOption,
                          onChanged: (val) {
                            value.setSelectedOption(1);
                          });
                    }),
                    const CommonText(fontsize: 16, text: "Expenditure"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CommonFormField(controller: _title, hint: "Enter Title"),
            Consumer<TransactionListProvider>(builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: value.getSelectedOption == 0
                    ? const IncomeDropDown()
                    : const ExpenseDropDown(),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            Consumer<TransactionListProvider>(builder: (context, value, child) {
              return value.getSelectedOption == 0
                  ? Column(
                      children: [
                        CommonFormField(
                            controller: _total, hint: "Enter Total Income"),
                        CommonFormField(
                            controller: _cost, hint: "Enter Cost On Income"),
                              CommonFormField(
                            controller: _recieved, hint: "Enter Recieved Amount")
                      ],
                    )
                  : CommonFormField(controller: _cost, hint: "Enter Cost");
            }),
            const DateSelecter(),
            const TimeSelecter(),
            const SizedBox(
              height: 20,
            ),
            Consumer<TransactionListProvider>(builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  value.setId();
                  TransactionModel transactionModel = TransactionModel(
                      title: _title.text,
                      recieved: double.tryParse(_recieved.text) ?? 0,
                      category: value.getSelectedOption == 0
                          ? value.getIncomeCategory[value.getSelectedIncome]
                          : value.getExpenseCategory[value.getSelectedExpense],
                      cost: double.tryParse(_cost.text) ?? 0,
                      total: double.tryParse(_total.text) ?? 0,
                      date: value.getDate,
                      time: value.getTime,
                      id: value.getId);
                  value.addTransaction(widget.bookModel, transactionModel,
                      widget.bookModel.id, context);
                },
                child: CommonButton(
                    child: value.getLoading
                        ? const CircularProgressIndicator()
                        : CommonButtonText(label: "Add Transaction")),
              );
            })
          ],
        ),
      ),
    ));
  }
}
