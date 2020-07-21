import 'package:flutter/material.dart';
import 'package:flutterapp/checkout.dart';
import 'package:flutterapp/splash.dart';

import 'home.dart';
import 'detail.dart';
import 'models/coffee.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Cafe',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        DetailScreen.routeName: (context) => DetailScreen(),
        CheckOutScreen.routeName: (context) => CheckOutScreen(),
      },
     
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
