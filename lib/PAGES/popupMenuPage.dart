import 'package:diabetes_care_taker/PopUpMenuClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class popupMenuPage extends StatelessWidget {
  const popupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0, 50),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "About App",
                widget_widget: PopUpMenuClass().AboutAppWidget,
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: Icon(Icons.info_outline_rounded, color: Colors.black),
          title: Text("ABOUT App"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "Contact Us",
                widget_widget: PopUpMenuClass().ContactUsWidget,
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: Icon(Icons.contact_emergency_outlined, color: Colors.black),
          title: Text("Contact Us"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "Help Center",
                widget_widget: PopUpMenuClass().HelpWidget,
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: Icon(Icons.help_center_outlined, color: Colors.black),
          title: Text("Help Center"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "Developers",
                widget_widget: PopUpMenuClass().DevelopersWidget,
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: Icon(Icons.group, color: Colors.black),
          title: Text("Developers"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "Terms and Privacy Policy",
                // content1: "This is Terms and Privacy Policy section",
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: Icon(Icons.menu_book_sharp, color: Colors.black),
          title: Text("Terms and Privacy Policy"),
        )),
      ],
    );
  }
}

class DetailPopUpButtonPage extends StatelessWidget {
  var title;
  Widget? widget_widget;
  var content2;
  var content3;
  var content4;
  var content5;

  var imagePath;

  DetailPopUpButtonPage({
    super.key,
    this.title,
    this.widget_widget,
    this.content2,
    this.content3,
    this.content4,
    this.content5,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(child: widget_widget),
      ),
    );
  }
}
