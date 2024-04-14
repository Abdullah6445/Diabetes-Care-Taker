import 'package:flutter/material.dart';

class testReminderPage extends StatelessWidget {
  const testReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Reminder Page"),
      ),
      body: Container(
        child: Center(child: Text("test Reminder Page")),
      ),
    );
  }
}
