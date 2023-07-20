import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/comment_button.dart';
import 'package:socialapp/components/comments.dart';
import 'package:socialapp/components/likebutton.dart';
import 'package:socialapp/helper/helper_methods.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postid;
  final List<String> likes;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postid,
    required this.likes,
    required this.time,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commenttextcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postid);
    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addcomment(String commenttext) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postid)
        .collection("comment")
        .add({
      "Comment": commenttext,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showcommentdialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add comment"),
              content: TextField(
                controller: _commenttextcontroller,
                decoration: InputDecoration(
                    hintText: "Write a Comment",
                    hintStyle: TextStyle(color: Colors.grey[300])),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _commenttextcontroller.clear();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (_commenttextcontroller.text.isNotEmpty) {
                        addcomment(_commenttextcontroller.text);
                      }
                      _commenttextcontroller.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("Post")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.user,
              style: TextStyle(
                color: Colors.grey[400]
              ),
              ),
               Text(" . ",
              style: TextStyle(
                color: Colors.grey[400]
              ),),
              Text(widget.time,
              style: TextStyle(
                color: Colors.grey[400]
              ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.message),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  CommentButton(onTap: showcommentdialog),
                  const SizedBox(
                    width: 50,
                  ),
                  const Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postid)
                .collection("comment")
                .orderBy("CommentTime", descending: true).snapshots(),
            builder:(context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData=doc.data() as Map<String,dynamic>;
                  return Comment(
                    text: commentData["Comment"],
                   user: commentData["CommentedBy"],
                    time: formatteddate(commentData["CommentTime"]) 
                    );
                }).toList(),
              );
            },)
        ],
        
      ),
    );
  }
}
