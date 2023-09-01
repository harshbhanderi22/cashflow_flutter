import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key, required this.transactionModel, required this.onDelete});

  final TransactionModel transactionModel;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    var balance = transactionModel.total - transactionModel.cost;
    return Container(
      height: 100,
      width: GeneralUtils.getWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 5, offset: Offset(5, 2))
          ],
          color: Colors.grey.shade100),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                balance > 0 ? Colors.green.shade200 : Colors.red.shade200,
            child: const CommonText(
              text: "₹",
              fontsize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 20,
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
                  text: (transactionModel.total - transactionModel.cost)
                      .toString(),
                  color: (transactionModel.total - transactionModel.cost) > 0
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                )
              ],
            ),
          ),
          Consumer<TransactionListProvider>(builder: ((context, val, child) {
            return PopupMenuButton(
                position: PopupMenuPosition.under,
                child: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 2) {
                    onDelete();
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 2,
                      child: Text("Delete"),
                    ),
                  ];
                });
          }))
        ],
      ),
    );
  }
}
