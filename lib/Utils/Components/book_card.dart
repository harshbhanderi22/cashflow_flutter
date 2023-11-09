import 'package:flutter/material.dart';
import 'package:khatabook/Models/book_model.dart';

import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/Routes/Arguments/book_form_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/book_form_provider.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final BookModel bookModel;

  const BookCard({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    var balance = bookModel.total - bookModel.cost;
    return Container(
      height: 100,
      width: GeneralUtils.getWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 5, offset: Offset(5, 2))
          ],
          color: Colors.grey.shade100),
      child: Row(
        children: [
          Consumer<BookFormProvider>(
            builder: (context, value, child) {
              return value.getImageLoading
                  ? const CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: bookModel.image == ""
                          ? CircleAvatar(
                              radius: 30,
                              backgroundColor: blue,
                              child: CommonText(
                                text: bookModel.name[0].toUpperCase(),
                                fontsize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                //backgroundColor: blue,
                                child: Image.network(
                                  bookModel.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ));
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: GeneralUtils.getWidth(context) / 3,
                    child: CommonText(
                      text: bookModel.name,
                      fontsize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonText(
                    text: bookModel.type,
                    fontsize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: balance.toString(),
                  color: balance >= 0 ? Colors.green : Colors.red,
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
                            id: bookModel.id,
                            bookModel: bookModel,
                            edit: true));
                  } else {
                    val.deleteBook(bookModel.id);
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
