import 'dart:ffi';
import 'package:flutter/material.dart';

class insulinDosePageController extends ChangeNotifier {
  String _selectedinsulintype = '';
  double _bolusinsulin = 0;
  double _basalinsulin = 0;
  double _isf = 0;
  double _icr = 0;

  String get selectedinsulintype => _selectedinsulintype;
  double get bolusinsulin => _bolusinsulin;
  double get basalinsulin => _basalinsulin;
  double get isf => _isf;
  double get icr => _icr;

  void setselectedinsulintype(String type) {
    _selectedinsulintype = type;
    print('Selected Insulin Type: $_selectedinsulintype');
    notifyListeners();
  }

  void setinsulin(double bolus, double basal) {
    _bolusinsulin = bolus;
    _basalinsulin = basal;
    notifyListeners();
  }

  void calculateisf() {
    if (_selectedinsulintype == 'Regular Insulin') {
      _isf = (1500 / (_bolusinsulin + _basalinsulin)).roundToDouble();
    } else if (_selectedinsulintype == 'Rapid Acting Insulin') {
      _isf = (1800 / (_bolusinsulin + _basalinsulin)).roundToDouble();
    }
    notifyListeners();
  }

  void calculateicr() {
    _icr = (500 / (_bolusinsulin + _basalinsulin)).roundToDouble();
    notifyListeners();
  }
}
