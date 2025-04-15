import 'package:flutter/material.dart';
import 'package:curemate/Screens/HomePage.dart';
import 'package:curemate/Screens/LoginPage.dart';
import 'package:curemate/utils/routes.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async{
  await dotenv.load(fileName: ".env");
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}
