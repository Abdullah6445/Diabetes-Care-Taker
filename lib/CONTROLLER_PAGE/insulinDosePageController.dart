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

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  void setselectedinsulintype(String type) {
    _selectedinsulintype = type;
    notifyListeners();
  }

  void calculateisf() {
    if (form_key.currentState!.validate()) {
      debugPrint("Validated");
      if (_selectedinsulintype == 'Regular Insulin') {
        isf = (1500 /
            (double.parse(bolusInsulin.text) +
                double.parse(basalInsulin.text)));
      } else if (_selectedinsulintype == 'Rapid Acting Insulin') {
        isf = (1800 /
            (double.parse(bolusInsulin.text) +
                double.parse(basalInsulin.text)));
      } else {
        CustomToast(message: "Select Insulin Type");
      }
      notifyListeners();
    } else {
      debugPrint("Not Validated");
      notifyListeners();
    }
  }

  void calculateicr() {
    if (form_key.currentState!.validate()) {
      debugPrint("Validated");
      icr = (500 /
          (double.parse(bolusInsulin.text) + double.parse(basalInsulin.text)));
      notifyListeners();
    } else {
      debugPrint("Not Validated");
      notifyListeners();
    }
  }
}