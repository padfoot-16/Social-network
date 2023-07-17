import 'package:flutter/material.dart';
import 'package:socialapp/components/mylisttile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onprofiletap;
  final void Function()? onsignout;
  const MyDrawer({super.key,
  required this.onsignout,
  required this.onprofiletap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[800],
      child: Column(
        children: [
          DrawerHeader(
              child: Container(
                  height: 200,
                  child: Image.asset("lib/assets/images/pulse.png"))),
          MyListTile(
            icon: Icons.home,
           text: 'HOME',
           onTap: () {
             Navigator.pop(context);
           },
           ),
           MyListTile(
            icon: Icons.person,
            text: 'PROFILE',
            onTap: onprofiletap,),
           MyListTile(
            icon: Icons.logout_outlined,
            text: 'LOGOUT',
            onTap: onsignout),
           
        ],
      ),
    );
  }
}
