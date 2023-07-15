import 'package:flutter/material.dart';
import 'package:socialapp/auth/login_or_register.dart';
import 'package:socialapp/pages/login.dart';
import 'package:socialapp/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
    );
  }
}