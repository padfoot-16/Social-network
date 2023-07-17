

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/components/likebutton.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postid;
  final List<String> likes;
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postid,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef=FirebaseFirestore.instance.collection('User Posts').doc(widget.postid);
    if (isLiked){
      postRef.update({
        'Likes':FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding:const  EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(
                isLiked: isLiked,
                 onTap: toggleLike
                 ),
                 const SizedBox(height: 5,),
                 Text(widget.likes.length.toString())
                 ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[400]),
              ),
             const SizedBox(
                height: 10,
              ),
              Text(widget.message),
            ],
          )
        ],
      ),
    );
  }
}
