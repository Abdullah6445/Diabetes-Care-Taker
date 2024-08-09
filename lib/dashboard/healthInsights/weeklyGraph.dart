import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class weeklyGraph extends StatefulWidget {
  @override
  _weeklyGraphState createState() => _weeklyGraphState();
}

class _weeklyGraphState extends State<weeklyGraph> {
  List<FlSpot> _dataPoints = [];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  String _errorMessage = '';
  bool _noData = false;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 6));
  final _auth = FirebaseAuth.instance;

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
      _startDate = selectedDate.subtract(const Duration(days: 6));
    });

    User? user = _auth.currentUser;
    String userId = user?.uid ?? '';

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DateTime endDate = selectedDate;

    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('entries')
          .where('Date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(_startDate),
              isLessThanOrEqualTo: DateFormat('yyyy-MM-dd').format(endDate))
          .get();

      if (snapshot.docs.isEmpty) {
        setState(() {
          _noData = true;
          _isLoading = false;
        });
        return;
      }

      Map<String, List<double>> dailyReadings = {};
      snapshot.docs.forEach((doc) {
        String date = doc['Date'];
        double bgl = double.tryParse(doc['Blood Glucose Level']) ?? 0.0;
        if (!dailyReadings.containsKey(date)) {
          dailyReadings[date] = [];
        }
        dailyReadings[date]!.add(bgl);
      });

      List<FlSpot> dataPoints = [];
      for (int i = 0; i < 7; i++) {
        DateTime date = _startDate.add(Duration(days: i));
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        List<double> readings = dailyReadings[formattedDate] ?? [];
        if (readings.isNotEmpty) {
          double avgBgl = readings.reduce((a, b) => a + b) / readings.length;
          if (avgBgl > 0) {
            dataPoints.add(FlSpot(i.toDouble(), avgBgl));
          }
        }
      }

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
      lastDate: DateTime.now(),
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
        title: const Text('Weekly Blood Glucose Graph'),
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
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 400,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage))
                        : _noData
                            ? const Center(
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
                                    border: const Border(
                                      right:
                                          BorderSide(color: Colors.transparent),
                                      top:
                                          BorderSide(color: Colors.transparent),
                                      left: BorderSide(color: Colors.black),
                                      bottom: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  minX: 0,
                                  maxX: 6,
                                  minY: 0,
                                  maxY: 400,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: _dataPoints,
                                      isCurved: true,
                                      colors: [Colors.blue],
                                      barWidth: 3,
                                      belowBarData: BarAreaData(
                                          show: false,
                                          colors: [
                                            Colors.blue.withOpacity(0.1)
                                          ]),
                                      dotData: FlDotData(show: true),
                                      dashArray: [5, 5],
                                    ),
                                  ],
                                ),
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
      getTitles: (value) {
        DateTime date = _startDate.add(Duration(days: value.toInt()));
        return DateFormat('M/d').format(date);
      },
    );
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
