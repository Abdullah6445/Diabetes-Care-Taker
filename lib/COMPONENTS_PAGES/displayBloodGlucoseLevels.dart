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
        title: Text('Blood Glucose Readings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(_currentUser?.uid)
            .collection('entries')
            .orderBy('Date')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No BG Readings to Display'));
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                DataColumn(
                    label: Text('Time',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('BGL',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Carb Intake',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Bolus Insulin Intake',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Basal Insulin Intake',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Notes',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: documents
                  .map((doc) => DataRow(cells: [
                        DataCell(Text(
                          doc['Date'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Time'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Blood Glucose Level'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Carb Intake'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Bolus Insulin Intake'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Basal Insulin Intake'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                        DataCell(Text(
                          doc['Notes'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17),
                        )),
                      ]))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
