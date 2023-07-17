import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentuser=FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("Profile Page"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50,),
          Icon(Icons.person,size: 80,),

          Text(currentuser.email!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[700]
          ),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left:25.0),
            child: Text("My Details",style: TextStyle(
              color: Colors.grey[600]
            ),),
          ),

          MyTextBox(
            text: 'User Bio',
           sectionname: 'username')

        ],
      ),
    );
  }
}