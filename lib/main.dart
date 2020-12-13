import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:la_salade_de_robinson/products/products_card.dart';
import 'package:la_salade_de_robinson/screen/map_page.dart';
import 'package:la_salade_de_robinson/screen/sign_in_page.dart';
import 'screen/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/authentification_page.dart';
import 'products/products_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  final appTitle = 'La salade de Robinson';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      //home: MyHomePage(title: appTitle),

      initialRoute: '/',
      routes: {
        '/': (context) => MyAuthenticationPage(),
        '/home': (context) => MyHomePage(),
        '/signIn': (context) => SignInPage(),
        '/map': (context) => MyMapPage(),
        '/product': (context) => ProductPage(),
      },
    );
  }
}



