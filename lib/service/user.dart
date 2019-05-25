import 'dart:convert';

User userFromJson(String str) => User.fromMap(json.decode(str));

String userToJson(User data) => json.encode(data.toMap());

class User {
    int id;
    String userid;
    String name;
    int age;
    String password;

    User({
        this.id,
        this.userid,
        this.name,
        this.age,
        this.password,
    });

    factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json["id"],
        userid: json["userid"],
        name: json["name"],
        age: json["age"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "userid": userid,
        "name": name,
        "age": age,
        "password": password,
    };
}
