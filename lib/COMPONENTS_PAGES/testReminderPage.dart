import 'package:diabetes_care_taker/PAGES/popupMenuPage.dart';
import 'package:flutter/material.dart';

class testReminderPage extends StatefulWidget {
  const testReminderPage({super.key});

  @override
  State<testReminderPage> createState() => _testReminderPageState();
}

class _testReminderPageState extends State<testReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tests Table"),
        actions: [popupMenuPage()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(),
            columns: const [
              DataColumn(
                  label: Text(
                'Test',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              )),
              DataColumn(
                  label: Text(
                'Identifies',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              )),
              DataColumn(
                  label: Text(
                'Reminder Duration',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
              )),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text(
                  'HbA1c',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Blood sugar control over past 3 months')),
                DataCell(Text(
                  'Every 3 months',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Kidneys',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Kidney function')),
                DataCell(Text(
                  'Annually',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Eyes',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Diabetic retinopathy, cataracts, glaucoma')),
                DataCell(Text(
                  'Annually',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Cholesterol',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Blood cholesterol levels')),
                DataCell(Text(
                  'Every 3-6 months',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Thyroid',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Thyroid function')),
                DataCell(Text(
                  'Annually',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
              DataRow(cells: [
                DataCell(Text(
                  'Foot test',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Colors.green),
                )),
                DataCell(Text('Nerve damage in feet (tests sensations)')),
                DataCell(Text(
                  'Annually',
                  style:
                      TextStyle(fontWeight: FontWeight.w900, color: Colors.red),
                )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
