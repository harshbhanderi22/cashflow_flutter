import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Routes/Arguments/book_form_argument.dart';
import 'package:khatabook/Utils/Routes/Arguments/transaction_list_argument.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/View/Forms/book_add_screen.dart';
import 'package:khatabook/View/Forms/add_entry_screen.dart';
import 'package:khatabook/View/home_screen.dart';
import 'package:khatabook/View/login_screen.dart';
import 'package:khatabook/View/sign_up_screen.dart';
import 'package:khatabook/View/transaction_list.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
          case RouteNames.addEntry:
        return MaterialPageRoute(builder: (_) => const AddEntryScreen());
      case RouteNames.addBook:
        final args = routeSettings.arguments as BookFormArguments?;
        return MaterialPageRoute(
            builder: (_) => AddBookScreen(
                edit: args!.edit,
                id: args.id,
                bookModel: args.bookModel));

      case RouteNames.transactionList:
        final args = routeSettings.arguments as TransactionListArgument?;
        return MaterialPageRoute(
            builder: (_) => TransactionListScreen(
                bookModel: args!.bookModel));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text("No Routes Defined")),
                ));
    }
  }
}
