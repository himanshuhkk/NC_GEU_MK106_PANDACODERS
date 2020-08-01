import 'package:careertrack/auth/splashPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Profile extends StatefulWidget{
  static const String id = 'ProfileId';
  @override
  _Pro createState() => _Pro();
}

class _Pro extends State<Profile> {

  String imgPath = 'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584_960_720.png';

  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,

          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, Theme.of(context).errorColor)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .55, Theme.of(context).scaffoldBackgroundColor)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
//                          Icon(
//                            Icons.keyboard_arrow_left,
//                            color: Colors.white,
//                            size: 40,
//                          ),
//                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
//                                decoration: InputDecoration(
//                                  labelText: "Type Something...",
//                                  hintText: "Type Something...",
//                                  hintStyle: TextStyle(
//                                    color: Colors.white54,
//                                    fontSize: 30,
//                                    fontWeight: FontWeight.w400
//                                  )
//                                ),

                                "You",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400),
                              ),
//                              IconButton(
//                                icon: Icon(Icons.settings),
//                                color: Colors.white,
//                                onPressed: (){
////                                  Navigator.pushReplacement(context,
////                                      MaterialPageRoute(builder: (context) => DesignCourseHomeScreen()));
//                                },
////                                size: 30,
//                              )
                            ],
                          ),
//                          SizedBox(height: 10),
//                          Text(
//                            "Type Something...",
//                            style: TextStyle(
//                                color: Colors.white54,
//                                fontSize: 30,
//                                fontWeight: FontWeight.w500),
//                          )
                        ],
                      )))
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _profilePic(){
    return Container(
      height: 180,
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(imgPath),
      ),
    );
  }

  Widget _profileDetaiil(context){
    return Column(
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Your Name',
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
              children: [
                TextSpan(
                  text: '\nOccupation',
                  style: TextStyle(color: Theme.of(context).errorColor, fontSize: 22),
                ),
//                TextSpan(
//                  text: '',
//                  style: TextStyle(color: Colors.blueAccent, fontSize: 30),
//                ),
              ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _header(context),
                SizedBox(height: 20),
                _profilePic(),
                SizedBox(height: 20),
                _profileDetaiil(context),
                SizedBox(height: 20),
                FlatButton(
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text('Log Out'),
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return SplashPage();
                    }));
                  },
                ),
                SizedBox(height: 20),
//                FlatButton(
//                  color: Colors.grey,
//                  textColor: Colors.white,
//                  child: Text('Side Bar'),
//                  onPressed: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context) {
//                      return SideBarLayout();
//                    }));
//                  },
//                ),
                SizedBox(height: 20),
//                CustomSwitch(
//                  activeColor: Colors.lightBlueAccent,
//                  value: Settings.status,
//                  onChanged: (value){
//                    setState(() async{
//                      Settings.status = value;
//                      final prefstatus = await SharedPreferences.getInstance();
//                      prefstatus.setBool( 'dark', value);
//                    });
//                  },
//                ),
//              _categoryRow("Featured", LightColor.orange, LightColor.orange),
//              _featuredRowA(context),
//              SizedBox(height: 0),
//              _categoryRow(
//                  "Featured", LightColor.purple, LightColor.darkpurple),
//              _featuredRowB()
              ],
            ),
          )),

    );
  }
}
