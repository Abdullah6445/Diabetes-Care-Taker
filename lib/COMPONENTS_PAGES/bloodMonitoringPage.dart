import 'package:flutter/material.dart';

class bloodMonitoringPage extends StatelessWidget {
  const bloodMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Blood glucose monitoring"),
            ],
          ),
        ),
      ),
    );
  }
}
