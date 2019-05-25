
import 'dart:async';

import 'package:mobilefinal/service/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreference{
    static int id;
    static String userid;
    static String name;


    static Future setAttr(User user) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("id", user.id);
      prefs.setString("userid", user.userid);
      prefs.setString("name", user.name);
    }
    static Future clear() async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.clear();
    }
    static getId() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getInt('id');
      return id;      
    }
  
    static Future<String> getName() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('name');      
    }
    static getUserId() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userid = prefs.getString('userid');
      return userid;      
    }
}