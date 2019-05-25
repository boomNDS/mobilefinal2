import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/file.dart';

class Main extends StatefulWidget {
  @override
  MainState createState() {
    return MainState();
  }
}

class MainState extends State<Main> {
  String quote = "to day is my day";
  String name = "FIRSTNAME LASTNAME";
  final _formKey = GlobalKey<FormState>();
  TextEditingController userControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  Widget buildUi(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Hello $name \n this is my quote " + '\"$quote\"',
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: 300,
                child: new RaisedButton(
                  child: new Text('PROFILE SETUP'),
                  onPressed: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: 300,
                child: new RaisedButton(
                  child: new Text('MY FRIENDS'),
                  onPressed: () {
                    Navigator.pushNamed(context, "/friend");
                  },
                ),
              ),
            ),
            Container(
              child: SizedBox(
                width: 300,
                child: new RaisedButton(
                  child: new Text('SIGN OUT'),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<String> text = FileManager.fileManager.readFile();
    text.then((value) {
      setState(() {
        if (value != null) quote = value;
      });
    });
    Future<String> prefname = SharePreference.getName();
    prefname.then((value) {
      setState(() {
        if (value != null) name = value;
      });
    });
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Builder(builder: (BuildContext context) {
          return buildUi(context);
        }));
  }
}
