import 'package:careertrack/auth/splashPage.dart';
import 'package:careertrack/theme/appTheme.dart';
import 'package:careertrack/theme/configs.dart';
import 'package:careertrack/theme/themeTest.dart';
import 'package:careertrack/ui/extraPages/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:careertrack/ui/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Career Succour',
//      theme: ThemeData(
//          primarySwatch: Colors.deepOrange,
//          accentColor: Colors.indigo,
//          fontFamily: "Montserrat",
//          buttonColor: Colors.deepOrange,
//          buttonTheme: ButtonThemeData(
//              buttonColor: Colors.deepOrangeAccent,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(20.0),
//              ),
//              textTheme: ButtonTextTheme.primary
//          )
//      ),
//      home: SplashPage(),
//    );
//  }
//}



void main() {
  runApp(
    ChangeNotifierProvider<Config>(create: (_) => Config(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    ));
    return Consumer<Config>(
      builder: (context, config, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter',
          theme: config.isLightMode ? AppTheme.lightTheme : AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          home: SplashPage(),
        );
      },
    );
  }
}