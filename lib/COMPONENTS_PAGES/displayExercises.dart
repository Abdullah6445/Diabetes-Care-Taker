import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class displayExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises History'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('exerciseLogs')
            .doc(userId)
            .collection('exerciseEntries')
            .orderBy('Date', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No exercises logs found'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              DateTime date = (data['Date'] as Timestamp).toDate();
              String formattedDate = DateFormat('MM/dd/yyyy').format(date);
              String formattedTime = DateFormat('hh:mm a').format(date);
              String activity = data['Activity'] ?? '0';
              String duration = data['Duration'].toString();
              String bgBefore = data['BGBefore']?.toString() ?? '0';
              String bgAfter = data['BGAfter']?.toString() ?? '0';

              String differenceMessage = '';
              if (data.containsKey('BGBefore') && data.containsKey('BGAfter')) {
                int bgBeforeValue = data['BGBefore'] ?? 0;
                int bgAfterValue = data['BGAfter'] ?? 0;
                if (bgBeforeValue > bgAfterValue) {
                  differenceMessage =
                      'BG Level dropped by ${bgBeforeValue - bgAfterValue}mg/dl';
                } else if (bgAfterValue > bgBeforeValue) {
                  differenceMessage =
                      'BG Level increased by ${bgAfterValue - bgBeforeValue}mg/dl';
                }
              }

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$formattedDate at $formattedTime',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          text: 'Activity: ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                              text: '$activity',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Duration: ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                              text: '$duration min',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      if (bgBefore != '0')
                        Text.rich(
                          TextSpan(
                            text: 'Blood Glucose Before: ',
                            style: TextStyle(fontWeight: FontWeight.normal),
                            children: [
                              TextSpan(
                                text: '$bgBefore',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' mg/dl',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      if (bgAfter != '0')
                        Text.rich(
                          TextSpan(
                            text: 'Blood Glucose After: ',
                            style: TextStyle(fontWeight: FontWeight.normal),
                            children: [
                              TextSpan(
                                text: '$bgAfter',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' mg/dl',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      if (differenceMessage.isNotEmpty)
                        Row(
                          children: [
                            Text("• ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(differenceMessage),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
