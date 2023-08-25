import 'package:flutter/material.dart';
import 'package:khatabook/Models/book_model.dart';

import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Routes/Arguments/book_form_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/data/Firebase%20Data/book_data.dart';
import 'package:khatabook/view_model/book_form_provider.dart';
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
          color: Colors.grey.shade100),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<BookFormProvider>(
                    builder: (context, value, child) {
                      return value.getImageLoading
                          ? const CircularProgressIndicator()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: bookModel.image == ""
                                  ? Image.asset(
                                      "assests/images/user3.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      bookModel.image!,
                                      fit: BoxFit.cover,
                                    ),
                            );
                    },
                  )),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: GeneralUtils.getWidth(context) / 3,
                      child: CommonText(
                        text: bookModel.name,
                        fontsize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CommonText(
                    text: bookModel.type,
                    fontsize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assests/images/location.png",
                        height: 12,
                        width: 12,
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
              children: [
                CommonText(
                  text: bookModel.balance.toString(),
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
                            id: bookModel.time.toString(),
                            bookModel: bookModel,
                            edit: true));
                  } else {
                    val.deleteBook(bookModel.time);
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
