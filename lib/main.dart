import "package:flutter/material.dart";
import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,                                          // remove debug banner form main.dart
      theme: ThemeData(primarySwatch: Colors.blue), home: LoginPage()
    );
  }
}