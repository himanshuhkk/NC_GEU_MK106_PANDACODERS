
import 'package:careertrack/analyst/verifyQues.dart';
import 'package:careertrack/auth/profile.dart';
import 'package:careertrack/theme/appTheme.dart';
import 'package:careertrack/ui/pages/home.dart';
import 'package:careertrack/ui/ytPlayer/videoList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:careertrack/theme/configs.dart';
import 'package:provider/provider.dart';

class AnalystScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
//        onWillPop: () async {
//      Fluttertoast.showToast(
//        msg: 'Disabled',
//        backgroundColor: Theme.of(context).accentColor,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
////        timeInSecForIos: 1,
//      );
//
//      return false;
//    },
        child: Consumer<Config>(
          builder: (context, config, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: config.isLightMode ? AppTheme.lightTheme : AppTheme.darkTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: Home.id,
              routes: {
                Home.id: (context) => Home(),
                Verify.id: (context) => Verify(),
//                HomePage.id: (context) => HomePage(),
//              VideoList.id: (context) => VideoList(),
                //        ClassRoom.id: (context) => ClassRoom(),
                Profile.id: (context) => Profile(),
              },
            );
          },
        )
//      MaterialApp(
//        theme: config.isLightMode ? AppTheme.lightTheme : AppTheme.darkTheme,
//        darkTheme: AppTheme.darkTheme,
//        debugShowCheckedModeBanner: false,
//        initialRoute: Home.id,
//        routes: {
//          Home.id: (context) => Home(),
//          MyDashBoard.id: (context) => MyDashBoard(),
//          HomePage.id: (context) => HomePage(),
//  //        TestRoom.id: (context) => TestRoom(),
//  //        ClassRoom.id: (context) => ClassRoom(),
//          Profile.id: (context) => Profile(),
//        },
//      )
    );
  }

}

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeMain createState() => _HomeMain();
}

class _HomeMain extends State<Home> {
  int _selectedPage = 0;
  final _pageOptions = [
//    MyDashBoard(),
    Verify(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,

        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'verify',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.table_chart,
//              color: Colors.white,
//            ),
//            title: Text(
//              'Quiz',
//              style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.green,
      ),
    );
  }
}