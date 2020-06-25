import 'package:covid/screens/about.dart';
import 'package:covid/screens/menu.dart';
import 'package:covid/screens/provinsi.dart';
import 'package:covid/screens/tips.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker Covid19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: "ibm-regular"
      ),
      home: SplashScreen.navigate(
        name: 'assets/images/intro.flr',
        next: (context) => Menu(),
        startAnimation: 'intro',
        fit: BoxFit.cover,
        until: () => Future.delayed(Duration(seconds: 1)),
      ),
      routes: {
        'tips': (context) => Tips(),
        'about': (context) => About(),
        'provinsi': (context) => Provinsi(),
      },
    );
  }
}