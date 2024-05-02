import 'package:flutter/material.dart';

class mealDoseCalculationPageController with ChangeNotifier {
  TextEditingController currentbloodsugarcontroller = TextEditingController();
  TextEditingController targetbloodsugarcontroller = TextEditingController();
  TextEditingController noofcarbscontroller = TextEditingController();

  double isf = 0;
  double icr = 0;
  double mealdose = 0;
  double correctiondose = 0;
  double mealcorrectiondose = 0;

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  void mealdosecalculation() {
    if (form_key.currentState!.validate()) {
      debugPrint("OK");
      mealdose = ((double.parse(noofcarbscontroller.text)) / icr);

      notifyListeners();
    } else {
      debugPrint("NOT OK");
      notifyListeners();
    }
  }

  void correctiondosecalculation() {
    if (form_key.currentState!.validate()) {
      debugPrint("OK");
      correctiondose = (((double.parse(currentbloodsugarcontroller.text)) -
              (double.parse(targetbloodsugarcontroller.text))) /
          isf);
      notifyListeners();
    } else {
      debugPrint("NOT OK");
      notifyListeners();
    }
  }

  void mealcorrectiondosecalculation() {
    if (form_key.currentState!.validate()) {
      debugPrint("OK");
      mealcorrectiondose = (mealdose + correctiondose);
      notifyListeners();
    } else {
      debugPrint("NOT OK");
      notifyListeners();
    }
  }
}
