import 'package:diabetes_care_taker/popUpButton/PopUpMenuClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class popupMenuPage extends StatelessWidget {
  const popupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
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
          leading: const Icon(Icons.info_outline_rounded, color: Colors.black),
          title: const Text("ABOUT App"),
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
          leading:
              const Icon(Icons.contact_emergency_outlined, color: Colors.black),
          title: const Text("Contact Us"),
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
          leading: const Icon(Icons.help_center_outlined, color: Colors.black),
          title: const Text("Help Center"),
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
          leading: const Icon(Icons.group, color: Colors.black),
          title: const Text("Developers"),
        )),
        PopupMenuItem(
            child: ListTile(
          onTap: () {
            Navigator.pop(context);
            Get.to(
              DetailPopUpButtonPage(
                title: "Terms and Privacy Policy",
                widget_widget: PopUpMenuClass().TermsAndPrivacyWidget,
              ),
            );
          },
          horizontalTitleGap: 0,
          leading: const Icon(Icons.menu_book_sharp, color: Colors.black),
          title: const Text("Terms and Privacy Policy"),
        )),
      ],
    );
  }
}

class DetailPopUpButtonPage extends StatelessWidget {
  var title;
  Widget? widget_widget;

  DetailPopUpButtonPage({
    super.key,
    this.title,
    this.widget_widget,
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
