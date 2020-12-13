import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:la_salade_de_robinson/screen/home_page.dart';
import '../main.dart';
import 'sign_in_page.dart';

void main() {
  runApp(MaterialApp(
    home: MyAuthenticationPage(),
  ));
}

class MyAuthenticationPage extends StatelessWidget {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Vous connecter',
            style: GoogleFonts.indieFlower(
              textStyle: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.green[500],
        ),
        body: Padding(

            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 225,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/salade_1.png',
                          fit: BoxFit.fitWidth),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse email',
                    ),
                    //controller: emailTextEditingController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mot de passe',
                    ),
                    //controller: passwordTextEditingController,
                  ),
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  textColor: Colors.black87,
                  child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(fontSize: 15)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green[600],
                    child: Text(
                      'Connexion',
                      style: TextStyle(fontSize: 25),
                    ),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                    elevation: 8.0,
                    onPressed: () {
                      //print(nameController.text);
                      //print(passwordController.text);
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMessage("Cet email n'est pas valide", context);
                      } else if (passwordTextEditingController.text.isEmpty) {
                        displayToastMessage("SVP veuillez taper votre mot de passe", context);
                      } else {
                        loginWithEmail(context);
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                    child: Row(
                      children: <Widget>[
                        //Text('Si vous n\'avez pas encore de compte?'),
                        FlatButton(
                          textColor: Colors.black87,
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(fontSize: 17),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                )
              ],
            )
        )
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginWithEmail(BuildContext context) async {

    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'La salade de Robinson')),
                  ModalRoute.withName('/home'));
          displayToastMessage("Vous êtes connecter", context);
        } else if (snap.value == null){
          _firebaseAuth.signOut();
          displayToastMessage("Ce compte n'existe pas, veuillez créer un compte SVP", context);
        }
      });

    } else if (firebaseUser == null) {

      displayToastMessage(
          "Erreur de connexion",
          context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
