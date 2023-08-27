import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/constant.dart';

class TransactionFloating extends StatefulWidget {
  const TransactionFloating({super.key});

  @override
  State<TransactionFloating> createState() => _TransactionFloatingState();
}

class _TransactionFloatingState extends State<TransactionFloating> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(RouteNames.addBook,
        //     arguments: BookFormArguments(edit: false));
        Navigator.of(context).pushNamed(RouteNames.addEntry);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), color: blue),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              CommonText(
                text: "Add Entry",
                fontsize: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
