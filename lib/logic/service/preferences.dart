import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences{

    static Future<void> saveUserDetails(String email, String password) async{
    SharedPreferences instance=await SharedPreferences.getInstance();
    await instance.setString('email', email);
    await instance.setString('password', password);
    debugPrint('Saved users details');

  }

   static Future<Map<String,dynamic>> getUserDetails() async{
    SharedPreferences instance=await SharedPreferences.getInstance();
    String? email= instance.getString('email');
    String? password= instance.getString('password');
     return {
      "email": email,
      "password": password
     };
  }
  static Future<void> clear() async{
    SharedPreferences instance=await SharedPreferences.getInstance();
    instance.clear();

  }


}