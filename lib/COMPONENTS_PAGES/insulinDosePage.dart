import 'package:diabetes_care_taker/COMPONENTS_PAGES/mealDoseCalulationPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diabetes_care_taker/CONTROLLER_PAGE/insulinDosePageController.dart';
import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
import 'package:diabetes_care_taker/PAGES/customToastPage.dart';
import 'package:flutter/src/material/dropdown.dart';

class insulinDosePage extends StatelessWidget {
  insulinDosePage({Key? key}) : super(key: key);
  TextEditingController bolusinsulincontroller = TextEditingController();
  TextEditingController basalinsulincontroller = TextEditingController();
  List<String> insulintypes = [
    'Insulin Type',
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
            Text(
              'Insulin Dose Calculation',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Consumer<insulinDosePageController>(
              builder: (context, controller, child) {
                return DropdownButton<String>(
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
                    // print('Selected value: $newValue');
                    controller.setselectedinsulintype(newValue!);
                  },
                );
              },
            ),
            customTextFormField(
              controllerr: bolusinsulincontroller,
              labelTextt: "Enter Your Total Bolus Insulin Dose",
              hintTextt: "Short/Rapid Acting Insulin",
              prefixIconn: Icon(Icons.medical_services),
              keyboardType: TextInputType.number,
            ),
            customTextFormField(
              controllerr: basalinsulincontroller,
              labelTextt: "Enter Your Total Basal Insulin Dose",
              hintTextt: "Long Acting Insulin",
              prefixIconn: Icon(Icons.medical_services),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  if (bolusinsulincontroller.text.isNotEmpty &&
                      basalinsulincontroller.text.isNotEmpty) {
                    double bolus =
                        double.tryParse(bolusinsulincontroller.text) ?? 0.0;
                    double basal =
                        double.tryParse(basalinsulincontroller.text) ?? 0.0;
                    insulindosepagecontroller.setinsulin(bolus, basal);
                    insulindosepagecontroller.calculateisf();
                  } else if (bolusinsulincontroller.text.isEmpty ||
                      basalinsulincontroller.text.isEmpty) {
                    CustomToast(
                        message: 'Please Enter Both Insulin Doses For ISF');
                  }
                },
                child: Text('Calculate ISF(Insulin Sensitivity Factor)')),
            Consumer<insulinDosePageController>(
                builder: (context, value, child) {
              return Text(
                value.isf.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  if (bolusinsulincontroller.text.isNotEmpty &&
                      basalinsulincontroller.text.isNotEmpty) {
                    double bolus =
                        double.tryParse(bolusinsulincontroller.text) ?? 0.0;
                    double basal =
                        double.tryParse(basalinsulincontroller.text) ?? 0.0;
                    insulindosepagecontroller.setinsulin(bolus, basal);
                    insulindosepagecontroller.calculateicr();
                  } else if (bolusinsulincontroller.text.isEmpty ||
                      basalinsulincontroller.text.isEmpty) {
                    CustomToast(
                        message: 'Please Enter Both Insulin Doses For ICR');
                  }
                },
                child: Text('Calculate ICR(Insulin to Carb Ratio)')),
            Consumer<insulinDosePageController>(
                builder: (context, value, child) {
              return Text(
                value.icr.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => mealDoseCalculationPage(),
                      ));
                },
                child: Text('Meal & Correction Dose Calcultion')),
          ],
        ),
      ),
    );
  }
}
