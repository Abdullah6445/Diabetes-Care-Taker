

import 'package:diabetes_care_taker/COMPONENTS_PAGES/mealDoseCalulationPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diabetes_care_taker/CONTROLLER_PAGE/insulinDosePageController.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';

class insulinDosePage extends StatelessWidget {
  insulinDosePage({Key? key}) : super(key: key);
  // TextEditingController insulindosepagecontroller.bolusInsulin = TextEditingController();
  // TextEditingController insulindosepagecontroller.basalInsulin = TextEditingController();
  List<String> insulintypes = [
    'Select Insulin Type',
    'Regular Insulin',
    'Rapid Acting Insulin'
  ];

  @override
  Widget build(BuildContext context) {
    final insulindosepagecontroller =
        Provider.of<insulinDosePageController>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                'Insulin Dose Calculation',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Consumer<insulinDosePageController>(
              builder: (context, controller, child) {
                return DropdownButton<String>(
                  iconEnabledColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  value: controller.selectedinsulintype.isNotEmpty
                      ? controller.selectedinsulintype
                      : insulintypes.first,
                  items: insulintypes
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    controller.setselectedinsulintype(newValue!);
                  },
                );
              },
            ),
            customTextFormField(
              controllerr: insulindosepagecontroller.bolusInsulin,
              labelTextt: "Enter Your Total Bolus Insulin Dose",
              hintTextt: "Short/Rapid Acting Insulin",
              prefixIconn: Icon(Icons.medical_services),
              keyboardType: TextInputType.number,
            ),
            customTextFormField(
              controllerr: insulindosepagecontroller.basalInsulin,
              labelTextt: "Enter Your Total Basal Insulin Dose",
              hintTextt: "Long Acting Insulin",
              prefixIconn: Icon(Icons.medical_services),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  if (insulindosepagecontroller.bolusInsulin.text.isNotEmpty &&
                      insulindosepagecontroller.basalInsulin.text.isNotEmpty &&
                      insulindosepagecontroller
                          .selectedinsulintype.isNotEmpty) {
                    insulindosepagecontroller.calculateisf();
                  } else if (insulindosepagecontroller
                          .bolusInsulin.text.isEmpty ||
                      insulindosepagecontroller.basalInsulin.text.isEmpty ||
                      insulindosepagecontroller.selectedinsulintype.isEmpty ||
                      insulintypes.first == "Select Insulin Type") {
                    print("empty");
                    insulindosepagecontroller.emptyfieldsforisf();
                    CustomToast(
                        message:
                            'Please Enter Both Insulin Doses For ISF & Select Insulin Type');
                  }
                },
                child: Text('Calculate ISF(Insulin Sensitivity Factor)')),
            Consumer<insulinDosePageController>(
                builder: (context, value, child) {
              return Text(
                "${value.isf.toStringAsFixed(0)} mg/dl",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  if (insulindosepagecontroller.bolusInsulin.text.isNotEmpty &&
                      insulindosepagecontroller.basalInsulin.text.isNotEmpty) {
                    insulindosepagecontroller.calculateicr();
                  } else if (insulindosepagecontroller
                          .bolusInsulin.text.isEmpty ||
                      insulindosepagecontroller.basalInsulin.text.isEmpty) {
                    insulindosepagecontroller.emptyfieldsforicr();
                    CustomToast(
                        message: 'Please Enter Both Insulin Doses For ICR');
                  }
                },
                child: Text('Calculate ICR(Insulin to Carb Ratio)')),
            Consumer<insulinDosePageController>(
                builder: (context, value, child) {
              return Text(
                "${value.icr.toStringAsFixed(0)} gram",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  if (insulindosepagecontroller.isf.toString() != "0.0" &&
                      insulindosepagecontroller.icr.toString() != "0.0") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => mealDoseCalculationPage(),
                        ));
                    print("${insulindosepagecontroller.isf.toString()}");
                    print("${insulindosepagecontroller.icr.toString()}");
                  } else {
                    CustomToast(
                        message: 'Please first calculate your ISF & ICR');
                  }
                },
                child: Text('Meal & Correction Dose Calculation')),
          ],
        ),
      ),
    );
  }
}