// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
//
// import '../NetworkUtils/api.dart';
//
//
// class UserUtil {
//   static Future getUser(BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userD = jsonDecode(localStorage.getString('user') ?? '');
//     if (userD != null) {
//       return userD;
//     } else {
//       Navigator.pushNamed(context, "/login");
//     }
//   }
//
//
//   static Future updateUser(BuildContext context, user) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     localStorage.setString('user', json.encode(user));
//   }
//
//   static Future checkAuth(BuildContext context) async {
//     var res = await Network().getData('/checkAuth');
//     var body = json.decode(res.body);
//     if (body['success']) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setString('user', json.encode(body['user']));
//       return body['user'];
//     }
//     else{Navigator.pushNamed(context, '/login');}
//   }
// }