// import 'package:flutter/material.dart';
// import 'package:socialapp/components/editedbox.dart';
// import 'package:socialapp/components/textbox.dart';

// class EditOrNo extends StatefulWidget {
//   const EditOrNo({super.key});

//   @override
//   State<EditOrNo> createState() => _EditOrNoState();
// }

// class _EditOrNoState extends State<EditOrNo> {
//   bool editorno=false;

//   void toggleedit(){
//     setState(() {
//       editorno=!editorno;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//    if(editorno){
//     return EditedBox(sectionname: sectionname, fieldcontroller: fieldcontroller, ontap: ontap);
//    }
//    else {
//     return MyTextBox(text: text, sectionname: sectionname, onPressed: onPressed);
//    }
//   }
// }