import 'package:flutter/material.dart';
import 'package:khatabook/Models/book_model.dart';

import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Routes/Arguments/book_form_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/data/Firebase%20Data/book_data.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;

  const BookCard({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 5, offset: Offset(5, 2))
          ],
          color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(
                  bookModel.image ??
                      "https://freesvg.org/img/abstract-user-flat-4.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: bookModel.name,
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CommonText(
                    text: bookModel.type,
                    fontsize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assests/images/location.png",
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CommonText(
                        text: bookModel.address,
                        fontsize: 12,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CommonText(
                  text: "50000",
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                )
              ],
            ),
          ),
          Consumer<HomePageProvider>(builder: ((context, val, child) {
            return PopupMenuButton(
                position: PopupMenuPosition.under,
                child: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.of(context).pushNamed(RouteNames.addBook,
                        arguments: BookFormArguments(
                            id: bookModel.id.toString(),
                            bookModel: bookModel,
                            edit: true));
                  } else {
                    StoreBookDataToUser()
                        .deleteBook(bookModel.id)
                        .whenComplete(() {
                      val.fetchCustomerList();
                    });
                  }
                },
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
                });
          }))
        ],
      ),
    );
  }
}
