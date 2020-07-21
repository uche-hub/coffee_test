import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/home.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _animation;


  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_animationController);
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => HomeScreen()
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 232, 232, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _animation,
              child: Image.asset("images/slpash.png"),
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(-1,0),
                end: Offset.zero
              ).animate(_animationController),
              child: Text(
                "Welcome To",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(
                /// To Make it come from below...
                  begin: Offset(0,1),
                  end: Offset.zero
              ).animate(_animationController),
              child: Text(
                "Uche's Cafe",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
