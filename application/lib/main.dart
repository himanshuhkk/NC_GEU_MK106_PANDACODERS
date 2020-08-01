import 'package:careertrack/auth/splashPage.dart';
import 'package:careertrack/theme/appTheme.dart';
import 'package:careertrack/theme/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<Config>(create: (_) => Config(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
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
