import 'package:flutter/material.dart';

class emergencyAlertPage extends StatelessWidget {
  const emergencyAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Alert Page"),
      ),
      body: Container(
        child: Center(child: Text("emergency Alert Page")),
      ),
    );
  }
}
