import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionname;
  const MyTextBox({super.key,
  required this.text,
  required this.sectionname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.only(left: 15,bottom: 15),
      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Column(
        children: [
          Text(sectionname),

          Text(text),
        ],
      ),
    );
  }
}