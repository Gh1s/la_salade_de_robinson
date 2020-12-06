//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:la_salade_de_robinson/screen/map_page.dart';
import 'map_page.dart';
import 'detail_page.dart';
import 'authentification_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            title,
            style: GoogleFonts.indieFlower(
        textStyle: TextStyle(
          fontSize: 24,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.green[600],
    ),
      body: Center(child: CarouselDemo()),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              //child: Text('Drawer Header'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/salade_1.png"),
                ),
                color: Colors.white,
              ),
            ),

            ListTile(
              title: Text(
                  'Localisez-nous',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/map');
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                  'Passer votre commande',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
              onTap: () {
                Navigator.pushNamed(
                    context,
                    '/detail');
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                  'Déconnexion',
                  style: GoogleFonts.indieFlower(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
              onTap: () {
                signOut(context);
                displayToastMessage('Vous êtes déconnecter', context);
                Navigator.pushNamed(
                    context,
                    '/');
              },
            ),
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
    } catch (e) {
      return e.message;
    }
  }

}

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}
class _CarouselDemoState extends State<CarouselDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            SizedBox(
                height: 350.0,
                width: double.infinity,
                child: Carousel(
                  images: [
                    AssetImage("lib/images/salade_2.png"),
                    AssetImage("lib/images/salade_3.png"),
                    AssetImage("lib/images/salade_4.png"),
                    AssetImage("lib/images/salade_5.png"),
                  ],
                  dotColor: Colors.red,
                )
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: Text(
                "La salade de Robinson est cultivée pendant 8 semaines "
                "en culture hors sol hydroponique, sans antiparasites.\n"
                "Elle profite du soleil du Mont-dore, ell contient de "
                "la vitamine B9, de la vitamine C, du beta-carotène, "
                "ainsi qu'un forte teneur en calcium.\n"
                "Les salades sont vendues 150 Francs pièces sur place "
                "pour la livraison il faut rajouter un supplément de 20 CFP.\n",
                style: GoogleFonts.indieFlower(
                  textStyle: TextStyle(

                    color: Colors.black87,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}