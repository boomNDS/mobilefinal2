    
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobilefinal/service/user.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "user.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE user ("
          "id INTEGER PRIMARY KEY autoincrement,"
          "userid VARCHAR(255),"
          "name VARCHAR(255),"
          "age INTEGER,"
          "password VARCHAR(255)"
          ")");
    });
  }

  newUser(User newUser) async {
    final db = await database;
    //get the biggest id in the table
    // var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM User");
    // int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into user (userid, name, age, password)"
        " VALUES (?,?,?, ?)",
        [newUser.userid, newUser.name, newUser.age, newUser.password]);
    return raw;
  }


  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("user", newUser.toMap(),
        where: "id = ?", whereArgs: [newUser.id]);
    return res;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query("user", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : null;
  }

   Future<List<User>> getAllCompletUser() async {
    final db = await database;
    // var res = await db.query("User", where: "age = ?", whereArgs: [age]);
    var res = await db.rawQuery("SELECT * FROM user WHERE age = 1");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }
  
  Future<List<User>> getAllTaskUser() async {
    final db = await database;
    // var res = await db.query("User", where: "age = ?", whereArgs: [age]);
    var res = await db.rawQuery("SELECT * FROM user WHERE age = 0");

     List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<User>> getStatusUser() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM User WHERE age=1");
    var res = await db.query("user", where: "age = ? ", whereArgs: [1]);

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<User>> getAllUser() async {
    final db = await database;
    // var res = await db.query("User");
    var res = await db.rawQuery("SELECT * FROM user");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  deleteUser(int id) async {
    print("delete");
    final db = await database;
    return db.delete("user", where: "id = ?", whereArgs: [id]);
  }

  deleteUserFromStatus() async {
    int age = 1;
    print("deletefromstatus");
    final db = await database;
    return db.delete("user", where: "age = ?", whereArgs: [age]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from user");
  }
}