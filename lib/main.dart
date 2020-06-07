import 'package:ags_wis/in/home.dart';
//import 'package:ags_wis/ui/login.dart';
import 'package:ags_wis/ui/Berandaadmin.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
//import 'package:ags_wis/in/home.dart';
import 'package:ags_wis/ui/login.dart';

void main() {
  runApp(new MaterialApp(
    title: "MyApps",
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/ui/Berandaadmin': (BuildContext context) => new Berandaadmin(),
      '/in/home': (BuildContext context) => new MyApp(),
      '/ui/login': (BuildContext context) => new Login(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _mockCheckForSession().then((status) {
      if (status) {
        _navigateToHome();
      }
      // else {
      //   _navigateToLogin();
      // }
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  // void _navigateToLogin(){
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => LoginScreen()
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
                opacity: 0.5, child: Image.asset('assets/appimages/bg.jpg')),
            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Color(0xff7f00ff),
              highlightColor: Color(0xffe100ff),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Wishop",
                  style: TextStyle(
                      fontSize: 70.0,
                      fontFamily: 'Pacifico',
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 18.0,
                            color: Colors.black87,
                            offset: Offset.fromDirection(120, 12))
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
