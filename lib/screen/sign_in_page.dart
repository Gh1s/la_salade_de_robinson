import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_salade_de_robinson/main.dart';
import 'package:la_salade_de_robinson/screen/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: SignInPage(),
  ));
}

class SignInPage extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
              'Créer votre compte',
              style: GoogleFonts.indieFlower(
                textStyle: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                ),
              ),
          ),
          backgroundColor: Colors.green,
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
                  child: TextFormField(
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Adresse email',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'SVP tapez du texte';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mot de passe',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'SVP tapez du texte';
                      }
                      return null;
                    },
                  ),
                ),

                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                        child: Text('ANNULER'),
                        textColor: Colors.black87,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        onPressed: () {
                          emailTextEditingController.clear();
                          passwordTextEditingController.clear();
                        }
                    ),
                    RaisedButton(
                      child: Text('ENVOYER'),
                      color: Colors.green[600],
                      textColor: Colors.black87,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () async {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email adress is not Valid", context);
                        } else if (passwordTextEditingController.text.length < 6) {
                          displayToastMessage("Password must be at least 6 characters", context);
                        } else {
                          registerNewUser(context);
                        }
                      },
                    )
                  ],
                ),
              ],
            )
        )
      );
    }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {

      Map userDataMap = {
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };

      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Hey congratulation you're account has been created", context);

      Navigator.pop(context);
      
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => MyHomePage(title: 'La salade de Robinson')),
              ModalRoute.withName('/'));
    } else {
      displayToastMessage("New user account has not been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}


