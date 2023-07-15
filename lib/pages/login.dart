// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:socialapp/components/my_textfield.dart';
import 'package:socialapp/components/mybutton.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hourglass_empty_rounded,
                  size: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome Back you have been missed ',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextfield(
                  controller: usernamecontroller,
                  hintText: "Username",
                  obscureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextfield(
                  controller: passwordcontroller,
                  hintText: "Password",
                  obscureText: true,
                ),
               
                SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: (){},
                  text: "Sign in",
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                        color: Colors.blue,
                         fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}