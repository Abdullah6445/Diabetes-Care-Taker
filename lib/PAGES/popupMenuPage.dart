import 'package:flutter/material.dart';

class popupMenuPage extends StatelessWidget {
  const popupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, 50),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          onTap: () {},
          horizontalTitleGap: 0,
          leading: Icon(Icons.info_outline_rounded, color: Colors.black),
          title: Text("ABOUT App"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {},
          horizontalTitleGap: 0,
          leading: Icon(Icons.contact_emergency_outlined, color: Colors.black),
          title: Text("Contact Us"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {},
          horizontalTitleGap: 0,
          leading: Icon(Icons.help_center_outlined, color: Colors.black),
          title: Text("Help"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {},
          horizontalTitleGap: 0,
          leading: Icon(Icons.group, color: Colors.black),
          title: Text("Developers"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {},
          horizontalTitleGap: 0,
          leading: Icon(Icons.menu_book_sharp, color: Colors.black),
          title: Text("Terms and Privacy Policy"),
        )),
      ],
    );
  }
}
