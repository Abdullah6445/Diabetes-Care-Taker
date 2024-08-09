import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:diabetes_care_taker/dashboard/insulinDose/insulinDosePageController.dart';
import 'package:diabetes_care_taker/dashboard/insulinDose/mealDoseCalulationPageController.dart';
import 'package:diabetes_care_taker/customWidgets/customTextFormFieldPage.dart';

class mealDoseCalculationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealdosecalculationpagecontroller =
        Provider.of<mealDoseCalculationPageController>(context, listen: false);
    final insulindosepagecontroller =
        Provider.of<insulinDosePageController>(context, listen: false);

    mealdosecalculationpagecontroller.isf = insulindosepagecontroller.isf;
    mealdosecalculationpagecontroller.icr = insulindosepagecontroller.icr;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal Dose Calculation"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: mealdosecalculationpagecontroller.form_key,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Meal & Correction Dose Calculation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Required"),
                ]),
                controllerr: mealdosecalculationpagecontroller
                    .currentbloodsugarcontroller,
                labelTextt: "Enter Your Current Blood Sugar",
                hintTextt: "Current blood sugar level",
                prefixIconn: const Icon(Icons.bloodtype),
                keyboardType: TextInputType.number,
              ),
              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Required"),
                ]),
                controllerr: mealdosecalculationpagecontroller
                    .targetbloodsugarcontroller,
                labelTextt: "Enter Your Target Blood Sugar",
                hintTextt: "Target blood sugar",
                prefixIconn: const Icon(Icons.bloodtype),
                keyboardType: TextInputType.number,
              ),
              customTextFormField(
                validatorrr: MultiValidator([
                  RequiredValidator(errorText: "Required"),
                ]),
                controllerr:
                    mealdosecalculationpagecontroller.noofcarbscontroller,
                labelTextt: "Enter No. of Carbs of Your Meal",
                hintTextt: " No. of carbs of your meal",
                prefixIconn: const Icon(Icons.food_bank),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                width: 250,
                child: ElevatedButton(
                    onPressed: () {
                      mealdosecalculationpagecontroller
                          .correctiondosecalculation();
                      mealdosecalculationpagecontroller.mealdosecalculation();
                      mealdosecalculationpagecontroller
                          .mealcorrectiondosecalculation();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Calculate Dose',
                        style: TextStyle(fontSize: 17))),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                  elevation: 10.0,
                  shadowColor: Colors.blue.withOpacity(0.9),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<mealDoseCalculationPageController>(
                          builder: (context, value, child) {
                            return Text(
                              "Meal Dose: ${value.mealdose.toStringAsFixed(1)} units",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Consumer<mealDoseCalculationPageController>(
                            builder: (context, value, child) {
                          return Text(
                            "Correction Dose: ${value.correctiondose.toStringAsFixed(1)} units",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        }),
                        const SizedBox(
                          height: 8,
                        ),
                        Consumer<mealDoseCalculationPageController>(
                            builder: (context, value, child) {
                          return Text(
                            "Total Dose: ${value.mealcorrectiondose.toStringAsFixed(1)} units",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        }),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
