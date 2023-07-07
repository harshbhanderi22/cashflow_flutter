import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/View/home_screen.dart';
import 'package:khatabook/View/login_screen.dart';
import 'package:khatabook/View/sign_up_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text("No Routes Defined")),
                ));
    }
  }
}