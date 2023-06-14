import 'package:flutter/material.dart';
import 'package:navigate/Navigate/navigation.dart';
import 'package:navigate/pages/Login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginForm(),
    );
  }
}
