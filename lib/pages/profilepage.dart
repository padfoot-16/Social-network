import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/editedbox.dart';
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
  void toggleedit(String field,bool enabl){
  setState(() {
      enabl = !enabl;
    });
  }
  Future<void> editfield(String field, data) async {
    
    String newvalue = "";
    if (field == "username") {
      setState(() {
        unamecontroller.text = data;
      });
      newvalue = unamecontroller.text;
    } else {
      setState(() {
        biocontroller.text = data;
      });
      newvalue = biocontroller.text;
    }
    // await showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           backgroundColor: Colors.grey[900],
    //           title: Text(
    //             "Edit $field",
    //             style: const TextStyle(color: Colors.white),
    //           ),
    //           content: TextField(
    //             autofocus: true,
    //             style: const TextStyle(
    //               color: Colors.white,
    //             ),
    //             decoration: InputDecoration(
    //                 hintText: "Enter New $field",
    //                 hintStyle: const TextStyle(color: Colors.grey)),
    //             onChanged: (value) {
    //               newvalue = value;
    //             },
    //           ),
    //           actions: [
    //             TextButton(
    //                 onPressed: () => Navigator.pop(context),
    //                 child: const Text(
    //                   "Cancel",
    //                   style: TextStyle(color: Colors.white),
    //                 )),
    //             TextButton(
    //                 onPressed: () => Navigator.of(context).pop(newvalue),
    //                 child: const Text(
    //                   "Save",
    //                   style: TextStyle(color: Colors.white),
    //                 )),
    //           ],
    //         ));
    if (newvalue.trim().length > 0) {
      await userCollection.doc(currentuser.email).update({field: newvalue});
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
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "My Details",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    // utext=Text(unamecontroller.text),
                    // unamecontroller.text = userdata["username"],
                    // biocontroller.text = userdata["bio"],
                    uenabled == false
                        ? MyTextBox(
                            text: userdata['username'],
                            sectionname: 'username',
                            onPressed: () =>
                                toggleedit('username', uenabled),
                          )
                        : EditedBox(
                            sectionname: 'username',
                            fieldcontroller: unamecontroller,
                            ontap: () =>
                                editfield('username', userdata["username"])),
                    benabled == false
                        ? MyTextBox(
                            text: userdata['bio'],
                            sectionname: 'bio',
                            onPressed: () => toggleedit('bio', benabled),
                          )
                        : EditedBox(
                            sectionname: "Bio",
                            fieldcontroller: biocontroller,
                            ontap: () => editfield('bio', userdata["bio"])),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "My Posts",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
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
