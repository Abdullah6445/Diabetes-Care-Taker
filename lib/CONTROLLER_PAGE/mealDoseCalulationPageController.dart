import 'dart:js';

import 'package:flutter/material.dart';
import 'package:diabetes_care_taker/CONTROLLER_PAGE/insulinDosePageController.dart';
import 'package:provider/provider.dart';

class mealDoseCalculationPageController extends ChangeNotifier {
  double _currentbloodsugar = 0;
  double _targetbloodsugar = 0;
  double _noofcarbs = 0;
  double _mealdose = 0;
  double _correctiondose = 0;
  double _mealcorrectiondose = 0;

  double get currentbloodsugar => _currentbloodsugar;
  double get targetbloodsugar => _targetbloodsugar;
  double get noofcarbs => _noofcarbs;
  double get mealdose => _mealdose;
  double get correctiondose => _correctiondose;
  double get mealcorrectiondose => _mealcorrectiondose;

  final insulindosepagecontroller = Provider.of<insulinDosePageController>(
      context as BuildContext,
      listen: false);

  void setdosevalues(
      double currentbloodsugar, double targerbloodsugar, double noofcarbs) {
    _currentbloodsugar = currentbloodsugar;
    _targetbloodsugar = targerbloodsugar;
    _noofcarbs = noofcarbs;
  }

  void mealdosecalculation() {
    _mealdose = (noofcarbs / insulindosepagecontroller.icr).roundToDouble();
  }

  void correctiondosecalculation() {
    _correctiondose =
        ((currentbloodsugar - targetbloodsugar) / insulindosepagecontroller.isf)
            .roundToDouble();
  }

  void mealcorrectiondosecalculation() {
    _mealcorrectiondose = (mealdose + correctiondose).roundToDouble();
  }
}
