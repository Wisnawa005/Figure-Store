import 'dart:async';
import 'dart:convert';

import 'package:ags_wis/in/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Berandaadmin.dart';

void main() => runApp(new Login());

String username = '';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Figure Store',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/ui/Berandaadmin': (BuildContext context) => new Berandaadmin(),
        '/in/home': (BuildContext context) => new MyApp(),
        '/ui/login': (BuildContext context) => new Login(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
        await http.post("http://192.168.43.6/apiflutter/login.php", body: {
      "email": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/ui/Berandaadmin');
      } else if (datauser[0]['level'] == 'user') {
        Navigator.pushReplacementNamed(context, '/in/home');
      }

      setState(() {
        username = datauser[0]['email'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/appimages/bgg.jpg'),
          fit: BoxFit.cover,
        )),
        child: new ListView(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  new Image.asset(
                    'assets/appimages/logo.png',
                    width: 250,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: user,
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          hintText: "Username",
                          labelText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      obscureText: true,
                      controller: pass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  RaisedButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.verified_user),
                        Text("LOGIN")
                      ],
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      _login();
                    },
                  ),
                  Text(msg)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
