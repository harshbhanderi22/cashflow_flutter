import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/view_model/transaction_list_provider.dart';
import 'package:provider/provider.dart';

class DateSelecter extends StatelessWidget {
  const DateSelecter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(builder: (context, value, child) {
      return InkWell(
        onTap: () {
          value.selectDate(context);
        },
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Row(children: [
            const Icon(CupertinoIcons.calendar),
            const SizedBox(
              width: 10,
            ),
            CommonText(
              text: value.getDate,
              color: Colors.black,
              fontsize: 18,
            )
          ]),
        ),
      );
    });
  }
}

class TimeSelecter extends StatelessWidget {
  const TimeSelecter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionListProvider>(builder: (context, value, child) {
      return InkWell(
        onTap: () {
          value.selectTime(context);
        },
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Row(children: [
            const Icon(CupertinoIcons.time),
            const SizedBox(
              width: 10,
            ),
            CommonText(
              text: value.getTime,
              color: Colors.black,
              fontsize: 18,
            )
          ]),
        ),
      );
    });
  }
}
