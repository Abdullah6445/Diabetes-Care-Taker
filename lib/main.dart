import 'package:diabetes_care_taker/PAGES/homePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetes Care Taker',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodySmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 65, 114)),
        useMaterial3: false,
      ),
      home: homePage(),
    );
  }
}
