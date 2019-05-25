import 'package:flutter/material.dart';
import 'package:mobilefinal/ui/login.dart';
import 'package:mobilefinal/ui/register.dart';
import 'package:mobilefinal/ui/main.dart';
import 'package:mobilefinal/ui/friendlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(48, 63, 159, 1.0)
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/regis": (context) => Register(),
        "/main": (context) => Main(),
        "/friend": (context) => Friend(),
      },
    );
  }
}
