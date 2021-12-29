import 'package:flutter/material.dart';
import 'package:flutter_project/views/adminView/LoginView.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: LoginView(),
    );
  }
}


