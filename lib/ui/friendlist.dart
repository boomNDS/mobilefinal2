import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/file.dart';
import 'package:http/http.dart' as http;

class Friend extends StatefulWidget {
  @override
  FriendState createState() {
    return FriendState();
  }
}

class FriendState extends State<Friend> {
  List list = List();
  var isLoading = false;

  Widget buildUi(BuildContext context) {
    return FutureBuilder<List<Friendinfo>>(
        future: getAllFriend(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Center(child: Text("s"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Friend")),
        body: Builder(builder: (BuildContext context) {
          return buildUi(context);
        }));
  }
}

class Friendinfo {
  final int id;

  Friendinfo({ this.id});

  factory Friendinfo.fromJson(Map<String, dynamic> json) {
    return Friendinfo(
      id: json['id'],
    );
  }
}
