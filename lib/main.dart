import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Routes/routes.dart';
import 'package:khatabook/View/home_screen.dart';
import 'package:khatabook/View/login_screen.dart';
import 'package:khatabook/view_model/Auth%20Providers/google_sign_in_provider.dart';
import 'package:khatabook/view_model/Auth%20Providers/login_provider.dart';
import 'package:khatabook/view_model/Auth%20Providers/signup_provider.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SignupProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoogleSingInProivder(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "popins"),
          //initialRoute: RouteNames.signUp,
          onGenerateRoute: Routes.generateRoutes,
          home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.hasError){
              return const Center(child: Text("Something Went Wrong"),);
            }
            else if(snapshot.hasData)
              {
                return const Center(child: HomeScreen(),);
              }
            else {
              return const LoginScreen();
            }

          }
        ),
        ));
  }
}
