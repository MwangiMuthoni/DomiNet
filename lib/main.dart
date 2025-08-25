import 'package:flutter/material.dart';
import 'package:ke_domain_connect/Auth/Login.dart';
import 'package:ke_domain_connect/Screens/HomeScreen.dart';
import 'package:ke_domain_connect/Screens/SplashScreen.dart';

import 'Screens/RegistrarDashboard.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: 'Kenya Domain Search',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: RegistrarCustomersScreen(),
    );
  }
}
