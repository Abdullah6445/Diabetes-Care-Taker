import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class dailyGraph extends StatefulWidget {
  @override
  _dailyGraphState createState() => _dailyGraphState();
}

class _dailyGraphState extends State<dailyGraph> {
  List<FlSpot> _dataPoints = [];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  String _errorMessage = '';
  bool _noData = false;

  @override
  void initState() {
    super.initState();
    _fetchData(_selectedDate);
  }

  void _fetchData(DateTime selectedDate) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _noData = false;
    });

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? '';

    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('entries')
          .where('Date',
              isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
          .orderBy('Time')
          .get();

      if (snapshot.docs.isEmpty) {
        setState(() {
          _noData = true;
          _isLoading = false;
        });
        return;
      }

      List<FlSpot> dataPoints = [];
      DateFormat dateFormat = DateFormat.jm();

      snapshot.docs.forEach((doc) {
        String bglString = doc['Blood Glucose Level'];
        double bgl = double.tryParse(bglString) ?? 0.0;

        String timeString = doc['Time'];
        DateTime dateTime;
        try {
          dateTime = dateFormat.parse(timeString);
        } catch (e) {
          dateTime = DateTime.now(); // Default to current time if parsing fails
        }
        double time = (dateTime.hour * 60 + dateTime.minute) /
            (24 * 60); // Convert time to a value between 0 and 1

        dataPoints.add(FlSpot(time, bgl));
      });

      // Sorting the data points values of x axis
      dataPoints.sort((a, b) => a.x.compareTo(b.x));

      setState(() {
        _dataPoints = dataPoints;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching data: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _fetchData(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Blood Glucose Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(child: Text(_errorMessage))
                      : _noData
                          ? Center(
                              child: Text(
                                  'No blood glucose readings were entered to show'))
                          : LineChart(
                              LineChartData(
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  bottomTitles: _getBottomTitles(),
                                  leftTitles: _getLeftTitles(),
                                  rightTitles: SideTitles(showTitles: false),
                                  topTitles: SideTitles(showTitles: false),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                    right:
                                        BorderSide(color: Colors.transparent),
                                    top: BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                minX: 0,
                                maxX: 1,
                                minY: 0,
                                maxY: 400,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _dataPoints,
                                    isCurved: false,
                                    colors: [Colors.blue],
                                    barWidth: 2,
                                    belowBarData: BarAreaData(
                                        show: false,
                                        colors: [Colors.blue.withOpacity(0.1)]),
                                    dotData: FlDotData(show: true),
                                    dashArray: [5, 5],
                                  ),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  SideTitles _getBottomTitles() {
    return SideTitles(
      showTitles: true,
      margin: 10,
      interval: 1 / 6, // Setting the interval to show titles every 4 hours
      getTitles: (value) {
        return _formatTime(value);
      },
    );
  }

  String _formatTime(double value) {
    int hours = (value * 24).toInt(); // Convert value back to hours
    String period = hours < 12 ? 'AM' : 'PM'; // Determine Am or PM
    hours = hours % 12 == 0 ? 12 : hours % 12; // Convert to 12-hour format
    return '$hours$period'; // Time displaying format
  }

  SideTitles _getLeftTitles() {
    return SideTitles(
      showTitles: true,
      margin: 16,
      reservedSize: 25,
      getTitles: (value) {
        if (value == 0) return '0';
        if (value == 100) return '100';
        if (value == 200) return '200';
        if (value == 300) return '300';
        if (value == 400) return '400';
        return '';
      },
    );
  }
}
