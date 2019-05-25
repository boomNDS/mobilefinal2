import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/file.dart';
import 'package:mobilefinal/service/friend.dart';
import 'package:mobilefinal/service/api.dart';
import 'package:http/http.dart' as http;
import 'package:mobilefinal/ui/todolist.dart';

class Friend extends StatefulWidget {
  @override
  FriendState createState() {
    return FriendState();
  }
}

class FriendState extends State<Friend> {
  var usersapi = new List<Userapi>();
  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        usersapi = list.map((model) => Userapi.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  Widget buildUi(BuildContext context) {
    return ListView.builder(
      itemCount: usersapi.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(usersapi[index].id.toString() +
              " :" +
              usersapi[index].name +
              "\n" +
              usersapi[index].email +
              "\n" +
              usersapi[index].phone +
              "\n" +
              usersapi[index].website),
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new Todo(id: usersapi[index].id)));
          },
        );
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
