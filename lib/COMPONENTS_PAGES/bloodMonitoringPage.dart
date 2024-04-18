import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
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
              customTextFormField(
                labelTextt: "Enter Your Name",
                hintTextt: "enter here...",
                prefixIconn: Icon(Icons.person),
              ),
              customTextFormField(
                labelTextt: "Enter Password",
                hintTextt: "enter here...",
                prefixIconn: Icon(Icons.security),
              ),
              ElevatedButton(
                  onPressed: () {
                    CustomToast(message: "Education library");
                  },
                  child: Text("submit"))
            ],
          ),
        ),
      ),
    );
  }
}
