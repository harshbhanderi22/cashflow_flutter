// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:khatabook/Models/book_model.dart';

class BookFormArguments {
  BookModel? bookModel;
  String? id;
  bool edit;
  BookFormArguments({this.bookModel, required this.edit, this.id});
}
