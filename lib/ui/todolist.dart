import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/file.dart';
import 'package:mobilefinal/service/todo.dart';
import 'package:mobilefinal/service/api.dart';
import 'package:http/http.dart' as http;

class Todo extends StatefulWidget {
  int id;
  Todo({this.id});
  @override
  TodoState createState() {
    return TodoState();
  }
}

class TodoState extends State<Todo> {
  var todoapi = new List<Todoapi>();
  getTodouser() {
    API.getTodouser(widget.id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        todoapi = list.map((model) => Todoapi.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    getTodouser();
  }

  dispose() {
    super.dispose();
  }

  Widget buildUi(BuildContext context) {
    return ListView.builder(
      itemCount: todoapi.length,
      itemBuilder: (context, index) {
        String com = todoapi[index].completed ? "completed" : "";
        return Card(
            child: Container(
          child: FlatButton(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[Text(todoapi[index].id.toString()),Text(todoapi[index].title),Text(com)],
              ),
            ),
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Todo")),
        body: Builder(builder: (BuildContext context) {
          return buildUi(context);
        }));
  }
}
