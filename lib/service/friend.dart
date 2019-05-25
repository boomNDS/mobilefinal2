import 'dart:convert';

Friend friendFromJson(String str) {
  final jsonData = json.decode(str);
  return Friend.fromJson(jsonData);
}

String friendToJson(Friend data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Friend> allFriendFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Friend>.from(jsonData.map((x) => Friend.fromJson(x)));
}

class Friend {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  Friend({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => new Friend(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "website": website,
      };
}
