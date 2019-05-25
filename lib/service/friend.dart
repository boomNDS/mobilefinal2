class Userapi {
  int id;
  String name;
  String email;
  String phone;
  String website;

  Userapi(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.website = website;
  }

  Userapi.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        website = json['website'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email,'phone':phone,'website':website};
  }
}