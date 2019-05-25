import 'package:flutter/material.dart';
import 'package:mobilefinal/service/user.dart';
import 'package:mobilefinal/db/db.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:validators/validators.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  bool check = false;
  TextEditingController userControl = new TextEditingController();
  TextEditingController nameControl = new TextEditingController();
  TextEditingController ageControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget buildUi(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "User ID",
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
              controller: userControl,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุ user";
                } else if (value.length < 6 || value.length > 12) {
                  return "กรุณาระบุความยาว user id ให้ถูกต้อง";
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.perm_contact_calendar),
              ),
              keyboardType: TextInputType.text,
              controller: nameControl,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุชื่อ";
                } else {
                  int count = 0;
                  for (int i = 0; i < value.length; i++) {
                    if (value[i] == " ") {
                      count++;
                    }
                  }
                  print(count);
                  if (count > 1 || count == 0)
                    return "กรุณาระบุนามสกุลให้ถูกต้อง";
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Age",
                prefixIcon: Icon(Icons.calendar_view_day),
              ),
              controller: ageControl,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุอายุ";
                } else if (isInt(value) != true) {
                  return "กรุณาระบุอายุเป็นตัวเลข";
                } else if (isInt(value)) {
                  if ((int.parse(value) > 80 || int.parse(value) < 10)) {
                    return "กรุณาระบุอายุในช่วง 10-80 ปี";
                  }
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              controller: passControl,
              onSaved: (value) => print(value),
              validator: (value) {
                if (value.isEmpty) {
                  return "กรุณาระบุ password";
                } else if (value.length < 6) {
                  return "ความยาวต้องมากกว่า 6 ตัวอักษร";
                }
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          ),
          Container(
            child: RaisedButton(
              child: Text("REGISTER NEW ACCOUNT"),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("กรุณาระบุข้อมูลให้ครบถ้วน"),
                  ));
                } else if (check) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("user นี้มีอยู่ในระบบแล้ว"),
                  ));
                } else {
                  User user = new User(
                      userid: userControl.text,
                      name: nameControl.text,
                      age: int.parse(ageControl.text),
                      password: passControl.text);
                  await DBProvider.db.newUser(user);

                  Fluttertoast.showToast(
                      msg: "User " + user.name + " was saved",
                      toastLength: Toast.LENGTH_SHORT);
                  Navigator.pop(context);
                }
                check = false;
              },
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
              child: Text("REGISTER"),
              margin: EdgeInsets.fromLTRB(60, 20, 0, 50)),
        ),
        body: buildUi(context));
  }
}
