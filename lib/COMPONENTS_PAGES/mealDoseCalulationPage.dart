import 'package:flutter/material.dart';

class mealDoseCalculationPage extends StatelessWidget {
  // mealDoseCalculationPage({super.key, required String bolusFromInsulinDosePage, required String basalFromInsulinDosePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Dose Calculation"),
      ),
      body: Center(
        child: Text("meal dose"),
      ),
    );
  }
}
