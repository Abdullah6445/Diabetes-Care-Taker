import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class insulinDosePageController with ChangeNotifier {
  String _selectedinsulintype = '';

  TextEditingController bolusInsulin = TextEditingController();

  TextEditingController basalInsulin = TextEditingController();

  double isf = 0;
  double icr = 0;

  String get selectedinsulintype => _selectedinsulintype;

  void setselectedinsulintype(String type) {
    _selectedinsulintype = type;
    if (_selectedinsulintype == 'SELECT Insulin Type') {
      CustomToast(message: "Select Insulin Type");
    }
    notifyListeners();
  }

  void calculateisf() {
    if (_selectedinsulintype == 'Regular Insulin') {
      isf = (1500 /
              (double.parse(bolusInsulin.text) +
                  double.parse(basalInsulin.text)))
          .roundToDouble();
    } else if (_selectedinsulintype == 'Rapid Acting Insulin') {
      isf = (1800 /
              (double.parse(bolusInsulin.text) +
                  double.parse(basalInsulin.text)))
          .roundToDouble();
    } else {
      CustomToast(message: "Select Insulin Type");
    }
    notifyListeners();
  }

  void calculateicr() {
    icr = (500 /
            (double.parse(bolusInsulin.text) + double.parse(basalInsulin.text)))
        .roundToDouble();
    notifyListeners();
  }
}

























/*

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class insulinDosePageController with ChangeNotifier {
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
    // print('Selected Insulin Type: $_selectedinsulintype');
    notifyListeners();
  }

  void setinsulin(double bolus, double basal) {
    bolusInsulin = bolus;
    basalInsulin = basal;
    notifyListeners();
  }

  void calculateisf() {
    if (_selectedinsulintype == 'Regular Insulin') {
      isf = (1500 /
              (double.parse(bolusInsulin.text) +
                  double.parse(basalInsulin.text)))
          .roundToDouble();
    } else if (_selectedinsulintype == 'Rapid Acting Insulin') {
      isf = (1800 /
              (double.parse(bolusInsulin.text) +
                  double.parse(basalInsulin.text)))
          .roundToDouble();
    }
    notifyListeners();
  }

  void calculateicr() {
    icr = (500 /
            (double.parse(bolusInsulin.text) + double.parse(basalInsulin.text)))
        .roundToDouble();
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


*/