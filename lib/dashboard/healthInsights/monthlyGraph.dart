import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class monthlyGraph extends StatefulWidget {
  @override
  _monthlyGraphState createState() => _monthlyGraphState();
}

class _monthlyGraphState extends State<monthlyGraph> {
  List<FlSpot> _dataPoints = [];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;
  String _errorMessage = '';
  bool _noData = false;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 29));
  DateTime _endDate = DateTime.now();
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
      _startDate = DateTime(selectedDate.year, selectedDate.month, 1);
      _endDate = DateTime(selectedDate.year, selectedDate.month + 1, 0);
    });

    User? user = _auth.currentUser;
    String userId = user?.uid ?? '';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('entries')
          .where('Date',
              isGreaterThanOrEqualTo:
                  DateFormat('yyyy-MM-dd').format(_startDate),
              isLessThanOrEqualTo: DateFormat('yyyy-MM-dd').format(_endDate))
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
      for (int i = 0; i < _endDate.day; i++) {
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
    double screenHeight = MediaQuery.of(context).size.height;
    double reductionFraction = 0.3;
    double adjustedHeight = screenHeight - (screenHeight * reductionFraction);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Blood Glucose Graph'),
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
            SizedBox(
              height: 400,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(child: Text(_errorMessage))
                      : _noData
                          ? const Center(
                              child: Text(
                                  'No blood glucose readings were entered to show'))
                          : Center(
                              child: SizedBox(
                                height: adjustedHeight,
                                child: LineChart(
                                  LineChartData(
                                    gridData: FlGridData(show: true),
                                    titlesData: FlTitlesData(
                                      bottomTitles: _getBottomTitles(),
                                      leftTitles: _getLeftTitles(),
                                      rightTitles:
                                          SideTitles(showTitles: false),
                                      topTitles: SideTitles(showTitles: false),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.black),
                                        left: BorderSide(color: Colors.black),
                                        right: BorderSide(
                                            color: Colors.transparent),
                                        top: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    minX: 0,
                                    maxX: _endDate
                                            .difference(_startDate)
                                            .inDays
                                            .toDouble() -
                                        1,
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
      interval: 3,
      getTitles: (value) {
        DateTime date = _startDate.add(Duration(days: value.toInt()));
        return DateFormat('M/d').format(date);
      },
      rotateAngle: 45,
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
