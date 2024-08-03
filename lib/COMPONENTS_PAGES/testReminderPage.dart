import 'package:diabetes_care_taker/COMPONENTS_PAGES/test_page.dart';
import 'package:diabetes_care_taker/PAGES/popupMenuPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class testReminderPage extends StatefulWidget {
  const testReminderPage({super.key});

  @override
  State<testReminderPage> createState() => _testReminderPageState();
}

class _testReminderPageState extends State<testReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test Reminder Page"),
          actions: [popupMenuPage()],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("data"),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Get.to(diabetesTestTablePage());
                    },
                    child: Text('Diabetes Test Table')),
              ],
            ),
          ),
        ));
  }
}
