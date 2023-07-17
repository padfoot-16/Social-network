import 'package:firebase_auth/firebase_auth.dart';
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

  void signup() async{

    showDialog(
     context: context,
     builder: (context)=>const Center(
      child: CircularProgressIndicator(),
     ));

     if(passwordcontroller.text != confirmpasswordcontroller.text){
      Navigator.pop(context);
      displaymessage("Passwords don't match");
      return;
     }

     try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernamecontroller.text,
        password: passwordcontroller.text);
        if(context.mounted) Navigator.pop(context);
        
     } on FirebaseAuthException catch(e){
      Navigator.pop(context);
      displaymessage(e.code);
     }
  }

  void displaymessage(String message){
    showDialog(
      context: context,
     builder: (context)=>AlertDialog(
      title: Text(message),
     ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.hourglass_empty_rounded,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Let's create an account for you",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextfield(
                    controller: usernamecontroller,
                    hintText: "Username",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextfield(
                    controller: passwordcontroller,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 25,),
                  MyTextfield(
                    controller: confirmpasswordcontroller,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
      
                  const SizedBox(
                    height: 25,
                  ),
                  
                  
                  MyButton(
                    onTap: signup,
                    text: "Sign Up",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                      style: TextStyle(
                        color: Colors.grey[700]
                      ),),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
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
      ),
    );
  }
}