import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mealDoseCalculationPageController with ChangeNotifier {
  TextEditingController currentbloodsugarcontroller = TextEditingController();
  TextEditingController targetbloodsugarcontroller = TextEditingController();
  TextEditingController noofcarbscontroller = TextEditingController();

  double isf = 0;
  double icr = 0;
  double mealdose = 0;
  double correctiondose = 0;
  double mealcorrectiondose = 0;

  void mealdosecalculation() {
    mealdose = ((double.parse(noofcarbscontroller.text)) / icr);
    notifyListeners();
  }

  void correctiondosecalculation() {
    correctiondose = (((double.parse(currentbloodsugarcontroller.text)) -
            (double.parse(targetbloodsugarcontroller.text))) /
        isf);
    notifyListeners();
  }

  void mealcorrectiondosecalculation() {
    mealcorrectiondose = (mealdose + correctiondose);
    notifyListeners();
  }

  void emptyfields() {
    if (currentbloodsugarcontroller.text.isEmpty ||
        targetbloodsugarcontroller.text.isEmpty ||
        noofcarbscontroller.text.isEmpty) {
      mealdose = 0;
      correctiondose = 0;
      mealcorrectiondose = 0;
      notifyListeners();
    }
  }
}
