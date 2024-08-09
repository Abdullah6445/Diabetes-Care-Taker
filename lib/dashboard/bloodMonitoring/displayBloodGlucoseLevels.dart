import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class displayBloodGlucoseLevels extends StatefulWidget {
  @override
  _displayBloodGlucoseLevelsState createState() =>
      _displayBloodGlucoseLevelsState();
}

class _displayBloodGlucoseLevelsState extends State<displayBloodGlucoseLevels> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Glucose Readings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(_currentUser?.uid)
            .collection('entries')
            .orderBy('Date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No BG Readings to Display'));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.1),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dividerThickness: 2.0,
                  headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return const Color.fromARGB(255, 5, 65, 114);
                    },
                  ),
                  headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  columns: const [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time')),
                    DataColumn(label: Text('BGL')),
                    DataColumn(label: Text('Carb Intake')),
                    DataColumn(label: Text('Bolus Insulin Intake')),
                    DataColumn(label: Text('Basal Insulin Intake')),
                    DataColumn(label: Text('Notes')),
                  ],
                  rows: documents
                      .map((doc) => DataRow(cells: [
                            DataCell(Text(
                              doc['Date'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Time'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Blood Glucose Level'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Carb Intake'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Bolus Insulin Intake'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Basal Insulin Intake'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                            DataCell(Text(
                              doc['Notes'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            )),
                          ]))
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
