import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  //TODO: Send to Onboarding Page
                }
              else
                {
                  //TODO: Send to Main Page
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
      decoration: new BoxDecoration(
//            color: Colors.red,
        image: DecorationImage(
          image: AssetImage("assets/img/bgsplash.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
          child: Column(children: <Widget>[
        SizedBox(
          height: 270,
        ),
        Image.asset(
          'assets/img/logocs.png',
          height: 150,
          width: 150,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "Career",
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrange,
                ),
                children: [
                  TextSpan(
                    text: '\nSuccour',
                    style:
                        TextStyle(color: Colors.lightBlueAccent, fontSize: 30),
                  ),
                  TextSpan(
                    text: '',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ]),
          ),
        ),
      ])),
    ));
  }
}
