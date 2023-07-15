import 'package:flutter/material.dart';

import '../components/my_textfield.dart';
import '../components/mybutton.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernamecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
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
                  "Let's create an account for you",
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
                SizedBox(height: 25,),
                MyTextfield(
                  controller: confirmpasswordcontroller,
                  hintText: "Confirm Password",
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
                    Text("Already have an account?",
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login now",
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
    );;
  }
}