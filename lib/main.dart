import 'package:flutter/material.dart';
import 'package:projekakhir/home.dart';
import 'package:projekakhir/login_screen.dart';
import 'package:projekakhir/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(), // Assume you have a HomePage widget
      },
    );
  }
}
