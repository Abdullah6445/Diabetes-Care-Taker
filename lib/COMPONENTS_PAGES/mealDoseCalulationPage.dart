// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:diabetes_care_taker/CONTROLLER_PAGE/insulinDosePageController.dart';
// import 'package:diabetes_care_taker/CONTROLLER_PAGE/mealDoseCalulationPageController.dart';
// import 'package:diabetes_care_taker/PAGES/customTextFormFieldPage.dart';
// import 'package:diabetes_care_taker/PAGES/customToastPage.dart';

// class mealDoseCalculationPage extends StatelessWidget {
//   // mealDoseCalculationPage({super.key, required String bolusFromInsulinDosePage, required String basalFromInsulinDosePage});
//   TextEditingController currentbloodsugarcontroller = TextEditingController();
//   TextEditingController targetbloodsugarcontroller = TextEditingController();
//   TextEditingController noofcarbscontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final mealdosecalculationpagecontroller =
//         Provider.of<mealDoseCalculationPageController>(context, listen: false);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 25),
//               child: Text(
//                 'Meal&Correction Dose Calculation',
//                 style: TextStyle(
//                   fontSize: 22,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             customTextFormField(
//               controllerr: currentbloodsugarcontroller,
//               labelTextt: "Enter Your Current Blood Sugar",
//               hintTextt: "Current blood sugar level",
//               prefixIconn: Icon(Icons.bloodtype),
//               keyboardType: TextInputType.number,
//             ),
//             customTextFormField(
//               controllerr: targetbloodsugarcontroller,
//               labelTextt: "Enter Your Target Blood Sugar",
//               hintTextt: "Target blood sugar",
//               prefixIconn: Icon(Icons.bloodtype),
//               keyboardType: TextInputType.number,
//             ),
//             customTextFormField(
//               controllerr: noofcarbscontroller,
//               labelTextt: "Enter No. of Carbs of Your Meal",
//               hintTextt: " No. of carbs of your meal",
//               prefixIconn: Icon(Icons.food_bank),
//               keyboardType: TextInputType.number,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   if (currentbloodsugarcontroller.text.isNotEmpty &&
//                       targetbloodsugarcontroller.text.isNotEmpty &&
//                       noofcarbscontroller.text.isNotEmpty) {
//                     double currentbg =
//                         double.tryParse(currentbloodsugarcontroller.text) ??
//                             0.0;
//                     double targetbg =
//                         double.tryParse(targetbloodsugarcontroller.text) ?? 0.0;
//                     double carbs =
//                         double.tryParse(noofcarbscontroller.text) ?? 0.0;
//                     mealdosecalculationpagecontroller.setdosevalues(
//                         currentbg, targetbg, carbs);
//                     mealdosecalculationpagecontroller
//                         .correctiondosecalculation();
//                     mealdosecalculationpagecontroller.mealdosecalculation();
//                     mealdosecalculationpagecontroller
//                         .mealcorrectiondosecalculation();
//                   } else if (currentbloodsugarcontroller.text.isEmpty ||
//                       targetbloodsugarcontroller.text.isEmpty ||
//                       noofcarbscontroller.text.isEmpty) {
//                     CustomToast(message: 'Please enter in all the fields');
//                   }
//                 },
//                 child: Text('Calculate Dose')),
//             Consumer<mealDoseCalculationPageController>(
//                 builder: (context, value, child) {
//               return Text(
//                 "Meal Dose: ${value.mealdose}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               );
//             }),
//             Consumer<mealDoseCalculationPageController>(
//                 builder: (context, value, child) {
//               return Text(
//                 "Correction Dose: ${value.correctiondose}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               );
//             }),
//             Consumer<mealDoseCalculationPageController>(
//                 builder: (context, value, child) {
//               return Text(
//                 "Total Dose: ${value.mealcorrectiondose}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
