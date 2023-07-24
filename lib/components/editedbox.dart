import 'package:flutter/material.dart';

class EditedBox extends StatefulWidget {
  final String sectionname;
  final fieldcontroller;
  final void Function()? ontap;
  const EditedBox({super.key,
   required this.sectionname,
   required this.fieldcontroller,
   required this.ontap});

  @override
  State<EditedBox> createState() => _EditedBoxState();
}

class _EditedBoxState extends State<EditedBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.sectionname,
                style: TextStyle(color: Colors.grey[500]),
              ),
              
            ],
          ),
         TextField(
          controller: widget.fieldcontroller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
              ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
              ),)
         ),
         Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: widget.ontap,
                child: Container(
                  color: Colors.grey[500],
                  child: Text("Cancel",style: TextStyle(color: Colors.white),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: widget.ontap,
                child: Container(
                  color: Colors.grey[500],
                  child: Text("Save",style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
         )
        ],
      ),
    );
    
  }
}
