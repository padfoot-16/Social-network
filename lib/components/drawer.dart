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
      backgroundColor: Colors.grey[850],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
              child: SizedBox(
                      height: 200,
                      child: Image.asset("lib/assets/images/pulse.png",color: Colors.white,))),
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
            ],
          ),
           Padding(
             padding: const EdgeInsets.only(bottom:25.0),
             child: MyListTile(
              icon: Icons.logout_outlined,
              text: 'LOGOUT',
              onTap: onsignout),
           ),
           
        ],
      ),
    );
  }
}
