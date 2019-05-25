import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilefinal/db/db.dart';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  Myform createState() {
    return Myform();
  }
}

class Myform extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  Widget buildUi(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            child: Image.network(
              "https://cdn-images-1.medium.com/max/1200/0*MXYivtrvfMI2nZXU.",
              height: 232,
            ),
            margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
          ),
          Container(
            child: TextFormField(
              controller: userControl,
              decoration: InputDecoration(
                labelText: "User Id",
                hintText: "User Id",
                icon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุ user";
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          ),
          Container(
            child: TextFormField(
              controller: passControl,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "password",
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุ password";
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Container(
            child: RaisedButton(
              child: Text("LOGIN"),
              onPressed: () async {
                print(_formKey.currentState.validate());
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("กรุณาระบุ user or password"),
                  ));
                } else {
                  List<User> users = await DBProvider.db.getAllUser();
                  bool check = false;
                  for (int i = 0; i < users.length; i++) {
                    print("userid " +
                        users[i].userid +
                        " == " +
                        userControl.text);
                    print("pass " +
                        users[i].password +
                        " == " +
                        passControl.text);

                    if (users[i].userid == userControl.text &&
                        users[i].password == passControl.text) {
                      check = true;
                      SharePreference.id = users[i].id;
                      SharePreference.setAttr(users[i]);
                      Navigator.pushReplacementNamed(context, "/Main");
                    }
                  }
                  if (!check) {
                    Fluttertoast.showToast(
                        msg: "Invalid user or password",
                        toastLength: Toast.LENGTH_SHORT);
                  }
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: GestureDetector(
                  child: Text("Register New Account",
                      style: TextStyle(color: Colors.green),
                      textDirection: TextDirection.ltr),
                  onTap: () {
                    Navigator.pushNamed(context, "/regist");
                  },
                ),
                margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
          return buildUi(context);
        }));
  }
}
