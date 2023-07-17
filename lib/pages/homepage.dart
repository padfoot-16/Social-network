import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/drawer.dart';
import 'package:socialapp/components/my_textfield.dart';
import 'package:socialapp/components/wall_post.dart';
import 'package:socialapp/pages/profilepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  final textcontroller = TextEditingController();

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  void gotoprofilepage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => ProfilePage()
          )
          );
  }

  void postmessage() {
    if (textcontroller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentuser.email,
        'Message': textcontroller.text,
        "TimeStamp": Timestamp.now(),
        "Likes": [],
      });
      setState(() {
        textcontroller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text("Welcome To Pulse"),
      ),
      drawer: MyDrawer(
        onprofiletap: gotoprofilepage,
        onsignout: signout,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy("TimeStamp", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data!.docs[index];
                    return WallPost(
                      message: post['Message'],
                      user: post['UserEmail'],
                      postid: post.id,
                      likes: List<String>.from(post['Likes'] ?? []),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error:${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                    child: MyTextfield(
                        controller: textcontroller,
                        hintText: "What's on your mind",
                        obscureText: false)),
                IconButton(
                    onPressed: postmessage,
                    icon: const Icon(Icons.arrow_circle_up_rounded)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
