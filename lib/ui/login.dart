import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilefinal/db/db.dart';
import 'package:mobilefinal/service/shared_preference.dart';
import 'package:mobilefinal/service/user.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  @override
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
            margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
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
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
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

                    if (users[i].userid == userControl.text &&
                        users[i].password == passControl.text) {
                      check = true;
                      SharePreference.id = users[i].id;
                      SharePreference.setAttr(users[i]);
                      Navigator.pushReplacementNamed(context, "/main");
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
                child: FlatButton(
                  child: Text("Register New Account"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/regis");
                  },
                ),
                // margin: EdgeInsets.fromLTRB(0, 10, 15, 0),
              ))
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")), body: buildUi(context));
  }
}
