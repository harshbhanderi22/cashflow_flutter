import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Routes/Arguments/book_form_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/constant.dart';

class HomePageFlotingButton extends StatelessWidget {
  const HomePageFlotingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.addBook,
            arguments: BookFormArguments(
              edit: false
              ));
      },
      child: Container(
        height: 50,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: redColor),
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
                text: "Add",
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
