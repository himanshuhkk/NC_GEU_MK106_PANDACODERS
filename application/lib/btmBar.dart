import 'package:careertrack/auth/profile.dart';
import 'package:careertrack/theme/appTheme.dart';
import 'package:careertrack/theme/configs.dart';
import 'package:careertrack/ui/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashBd.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Config>(
      builder: (context, config, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme:
              config.isLightMode ? AppTheme.lightTheme : AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: Home.id,
          routes: {
            Home.id: (context) => Home(),
            MyDashBoard.id: (context) => MyDashBoard(),
            QuizHome1.id: (context) => QuizHome1(),
            Profile.id: (context) => Profile(),
          },
        );
      },
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
    MyDashBoard(),
    QuizHome1(),
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
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.table_chart,
              color: Colors.white,
            ),
            title: Text(
              'Quiz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
    );
  }
}
