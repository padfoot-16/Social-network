import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('Users');
  final unamecontroller = TextEditingController();
  final biocontroller = TextEditingController();
  bool uenabled = false;
  bool benabled = false;
  bool enabled = false;
  String uval = "";
  String bval = "";
  Future<void> toggleedit() async {
    setState(() {
      enabled = !enabled;
    });
  }

  Future<void> editfield(
    String field,
    data,
  ) async {
    setState(() {
      enabled = !enabled;
    });

    if (uval.trim().isNotEmpty) {
      await userCollection.doc(currentuser.email).update({"username": uval});
    }
    if (bval.isNotEmpty) {
      await userCollection.doc(currentuser.email).update({"bio": bval});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text("Profile Page"),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentuser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userdata = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(
                      Icons.person,
                      size: 80,
                    ),
                    Text(
                      currentuser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            "My Details",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        IconButton(
                          onPressed: toggleedit,
                          icon: const Icon(Icons.settings),
                          color: Colors.grey[400],
                        )
                      ],
                    ),
                    // // utext=Text(unamecontroller.text),
                    // unamecontroller.text =userdata["username"],
                    // biocontroller.text = userdata["bio"],
                    enabled == false
                        ? MyTextBox(
                            text: userdata['username'],
                            sectionname: 'Username',
                            onPressed: () =>
                                editfield('username', userdata["username"]))
                        : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 15),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Username",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextField(
                                  controller: unamecontroller,
                                  cursorColor: Colors.grey[900],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade500)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400)),
                                  ),
                                  onChanged: (value) {
                                    uval = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                    enabled == false
                        ? MyTextBox(
                            text: userdata['bio'],
                            sectionname: 'Bio',
                            onPressed: () =>
                                editfield('username', userdata["username"]),
                          )
                        : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8)),
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 15),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bio",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextField(
                                  controller: biocontroller,
                                  cursorColor: Colors.grey[900],
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade500),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400)),
                                  ),
                                  onChanged: (value) {
                                    bval = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                    enabled == true
                        ? Padding(
                          padding: const EdgeInsets.only(right:18.0,top: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: toggleedit,
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(
                                            Colors.grey[800])),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                    SizedBox(width: 10,),
                                TextButton(
                                    onPressed: () => editfield(
                                        'username', userdata["username"]),
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(
                                            Colors.grey[800])),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                        )
                        : SizedBox(),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
